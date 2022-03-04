module Main where

import Animation.Draw
import Animation.State
import Animation.CLI

import Control.Concurrent (threadDelay)

main :: IO ()

wrap :: String -> String
wrap inner  = unlines (replicate 8 "\n") ++ inner ++ unlines (replicate 7 "\n") 

renderState :: Environment -> State -> IO()
renderState env@(Environment w h mv vi) st@(State pos _ _) =
    (putStrLn $ wrap $ render w h pos) >>
    printStats env st

printStats :: Environment -> State -> IO ()
printStats env st = print env >> print st

animate :: Environment -> State -> IO()
animate env@(Environment w h mv vi) st =
    renderState env st
        >> threadDelay 1000000
        >> animate env (next env st)


main = parseArgsIO >>= \(env, st) -> animate env st
