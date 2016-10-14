module Tutorial4 where

import Data.Machine
import System.Directory.Machine
import System.Environment (getArgs)
import System.IO (IOMode(..), withFile)
import System.IO.Machine (byLine, sourceHandle)

import qualified Data.Text as T

main :: IO ()
main = do
  dirs <- getArgs
  runT_ $ (autoM print) <~ largest <~ (autoM count) <~ files <~ directoryWalk <~ source dirs
    where
      count :: FilePath -> IO Int
      count file = do
        xs <- withFile file ReadMode $ \h ->
          runT $ largest <~ (auto T.length) <~ asParts <~ (auto T.words) <~ sourceHandle byLine h
        return $ head xs


