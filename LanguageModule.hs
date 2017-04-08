module LanguageModule (
  languages
 ,files
)
where

import Data.Map (Map, fromList)
import Attribute
import Language.C (crules, cfiles)

languages :: Map Language Rules
languages = fromList languageTuples

files :: Map Language Files
files = fromList fileTuples

languageTuples :: [(Language, Rules)]
languageTuples = [("C", crules)]

fileTuples :: [(Language, Files)]
fileTuples = [("C", cfiles)]
