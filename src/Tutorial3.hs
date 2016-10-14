module Tutorial3 where

import Data.Machine
import System.IO (IOMode(..), withFile)
import System.IO.Machine (byLine, sourceHandle)

import qualified Data.Text as T

main :: IO ()
main = do
  xs <- withFile "./lorem-ipsum.txt" ReadMode $ \h ->
    runT $ largest <~ auto T.length <~ asParts
                   <~ auto T.words <~ sourceHandle byLine h
  print xs -- [14]

