module Tutorial2 where

import Control.Monad
import Data.Machine

fizzbuzz :: Process Int String
fizzbuzz = repeatedly $ do
  i <- await
  let mod3 = mod i 3 == 0
  let mod5 = mod i 5 == 0
  when mod3 $ yield "Fizz"
  when mod5 $ yield "Buzz"
  when (not $ mod3 || mod5) $ yield $ show i

xs :: [Int]
xs = [0..]

main :: IO ()
main = runT_ $ autoM print <~ fizzbuzz <~ source xs

