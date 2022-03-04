module Animation.State where

data Environment = 
    Environment {
        width :: Int,
        height :: Int,
        maxVelocity :: Double,
        velocityIncrement :: Double
    }

instance Show Environment where
    show (Environment w h mv vi) = "Width: " ++ show w ++ " | "
                                 ++ "Height: " ++ show h ++ " | "
                                 ++ "Max Vel: " ++ show h ++ " | "
                                 ++ "Vel Inc: " ++ show vi ++ " | " 

data State = 
    State 
    {
        position :: (Int, Int)
        , direction :: (Bool, Bool)
        , currentVelocity :: (Double, Double)
    }

instance Show State where
    show (State pos dir (velX, velY)) = "Position: " ++ show pos ++ " | "
                                 ++ "Direction: " ++ show dir ++ " | "
                                 ++ "Vel: " ++ show velX ++ "," ++ show velY ++ " | " 


next :: Environment -> State -> State
next (Environment w h mV vI) (State (posX, posY) (dirX, dirY) (cvX, cvY)) =
    State (newPosX, newPosY) (newDirX, newDirY) (nvX, nvY)

    where

    dirToDPos True = 1
    dirToDPos False = -1

    cvXDir = round (dirToDPos dirX * cvX)
    cvYDir = round (dirToDPos dirY * cvY)

    nvX = 
        if posX + cvXDir >= w || posX + cvXDir<= 1
        then min (cvX + vI) mV
        else cvX
    
    nvY = 
        if posY + cvYDir >= h || posY + cvYDir<= 1
        then min (cvY + vI) mV
        else cvY

    newPosX =
        if posX + cvXDir>= w 
        then w
        else if posX + cvXDir <= 1
        then 1
        else posX + cvXDir
    newPosY =
        if posY + cvYDir >= h 
        then h 
        else if posY + cvYDir <= 1
        then 1
        else posY + cvYDir
    newDirX = 
        if posX + cvXDir >= w || posX + cvXDir <= 1
        then not dirX
        else dirX
    newDirY =
        if posY + cvYDir >= h || posY + cvYDir <= 1
        then not dirY
        else dirY