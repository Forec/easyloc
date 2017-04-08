module Attribute where

import qualified Data.Map as Map
import Data.Map (Map)

type Type = String
type File = String
type Pattern = String
type Language = String
type Rules = Map Pattern Type
type Files = Map Pattern File