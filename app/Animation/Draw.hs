module Animation.Draw where

renderRow :: Int -> Bool -> Int -> (Int, Int) -> String
renderRow height isEdge width (x,y) = 
    ['|'] ++ map toChar [1 .. width] ++ ['|']
    where 
        char =
            if isEdge
            then '-'
            else ' '
        toChar n
            | n == x && height == y = '0'
            | otherwise = char

renderRows :: Int -> Int -> (Int, Int) -> [String]
renderRows h_ w pos = [renderRow (h_ + 1) True w pos] ++ renderRows_ h_
    
    where

    renderRows_ 0 = [renderRow 0 True w pos]
    renderRows_ h = [renderRow h False w pos] ++ renderRows_ (h - 1)

render :: Int -> Int -> (Int, Int) -> String
render w h pos = unlines $ renderRows h w pos