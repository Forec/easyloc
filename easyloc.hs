{-# OPTIONS_GHC -Wall #-}

module Main where

import System.Directory
import System.FilePath
import System.Environment
import Data.List (foldl', sort)
import Data.Maybe (fromJust)
import qualified Data.Map as Map
import Data.Map (Map)
import Text.Regex.Posix ((=~))
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Lazy.Char8 as B

import Attribute
import LanguageModule (files)

main :: IO ()
main = do
  [language, path] <- getArgs
  let dict' = Map.lookup language files
  case dict' of
    Nothing -> 
      putStr ("Cannot find language module for " ++ language)
    Just dict -> do
      let patterns = Map.keys dict
      r <- count path patterns dict
      let output = format r
      putStr output

count :: FilePath -> [Pattern] -> Files -> IO (Map File Int)
count path patterns dict = do
  fs <- getDirectoryContents path
  let fs' = sort $ filter (`notElem` [".", ".."]) fs
  (m, _)  <- foldl' dealJoin (return (Map.empty, path)) fs'
  return m
 where
  dealJoin :: IO (Map File Int, FilePath) -> String -> IO (Map File Int, FilePath)
  dealJoin m name = do
    (map', root) <- m
    let filepath = root </> name
        key = match patterns name
    isdir <- doesDirectoryExist filepath
    if isdir
    then do
      rec <- count filepath patterns dict
      return (Map.unionWith (+) rec map', root)
    else do
      contents <- L.readFile filepath
      let loc = length (B.lines contents)
      case key of
        Nothing -> return (Map.insertWith (+) "Unknown" loc map', root)
        Just k  -> do
          let fileType = fromJust (Map.lookup k dict)
          return (Map.insertWith (+) fileType loc map', root)

match :: [Pattern] -> String -> Maybe Pattern
match [] _ = Nothing
match (p:ps) s = if (s =~ p :: Bool) then Just p else match ps s

format :: Map File Int -> String
format dict = foldl' format' "" (Map.toList dict) where
  format' :: String -> (File, Int) -> String
  format' accs (filetype, count') = accs ++ filetype ++ ": " ++ show count' ++ " lines\n"