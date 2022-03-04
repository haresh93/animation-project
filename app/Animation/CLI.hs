

module Animation.CLI where

import System.Environment (getArgs)
import System.Random (randomRIO)
import Animation.State


parseArgsIO :: IO (Environment, State)
parseArgsIO = getArgs >>= parseArgs

randomPosition :: Int -> Int -> IO (Int, Int)
randomPosition w h = 
            randomRIO (1, w) >>= \x -> randomRIO (1, h) >>= (\y -> pure (x, y))

parseArgs :: [String] -> IO (Environment, State)
parseArgs [w, h, mV, vI] = 
            randomPosition (read w) (read h) >>= \pos -> 
                    pure (Environment (read w) (read h) (read mV) (read vI)
                        , State pos (True, True) (1, 1))

