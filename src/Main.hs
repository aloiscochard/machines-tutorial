import Data.Machine
import System.Directory.Machine
import System.Environment (getArgs)
import System.IO (IOMode(..), withFile)
import System.IO.Machine (byLine, sourceHandle)

import qualified Data.Text as T

{--
- Browse a directory
- Read files by lines
- Break into words
- count word length
- take longest
--}

main :: IO ()
main = do
  dirs <- getArgs
  print $ "Processing directories: " ++ show dirs
  runT_ $ (autoM print) <~ largest <~ (autoM count) <~ files <~ directoryWalk <~ source dirs
    where
      count :: FilePath -> IO Int
      count file = do
        xs <- withFile file ReadMode $ \h ->
          runT $ largest <~ (auto T.length) <~ asParts <~ (auto T.words) <~ sourceHandle byLine h
        return $ head xs
