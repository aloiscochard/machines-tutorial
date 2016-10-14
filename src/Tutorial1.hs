module Tutorial1 where

import Data.Machine

inc :: Int -> IO Int
inc i = return $ i + 1

dec :: Int -> IO Int
dec i = return $ i - 10

xs :: [Int]
xs = [0..]

main :: IO ()
main = do
  ys <- runT $ taking 10 <~ autoM dec <~ autoM inc <~ source xs
  print ys -- [-9,-8,-7,-6,-5,-4,-3,-2,-1,0]
