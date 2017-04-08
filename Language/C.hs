module Language.C 
(
  crules
 ,cfiles
)
where

import Data.Map (fromList)
import Attribute

crules :: Rules
crules = fromList crulesList

crulesList :: [(Pattern, Type)]
crulesList = [("\\s*//.*", "Notation"),
              ("/*(.|[\r\n])*?\\*/", "Notation"),
              ("#.*", "Macro"),
              (".*", "Code")]

cfiles :: Files
cfiles = fromList cfilesList

cfilesList :: [(Pattern, File)]
cfilesList = [
  (".*\\.h", "Header"),
  (".*\\.hpp", "Header"),
  (".*\\.c", "Source"),
  (".*\\.cpp", "Source"),
  (".*\\.cc", "Source"),
  (".*\\.+makefile", "MakeFile")]