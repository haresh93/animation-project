{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_animation (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/hanu/.cabal/bin"
libdir     = "/home/hanu/.cabal/lib/x86_64-linux-ghc-8.10.5/animation-0.1.0.0-inplace-animation"
dynlibdir  = "/home/hanu/.cabal/lib/x86_64-linux-ghc-8.10.5"
datadir    = "/home/hanu/.cabal/share/x86_64-linux-ghc-8.10.5/animation-0.1.0.0"
libexecdir = "/home/hanu/.cabal/libexec/x86_64-linux-ghc-8.10.5/animation-0.1.0.0"
sysconfdir = "/home/hanu/.cabal/etc"

getBinDir     = catchIO (getEnv "animation_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "animation_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "animation_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "animation_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "animation_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "animation_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (last dir) = dir ++ fname
  | otherwise                  = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
