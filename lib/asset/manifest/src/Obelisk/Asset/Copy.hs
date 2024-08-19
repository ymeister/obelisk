module Obelisk.Asset.Copy where

import Control.Monad
import Data.Map (Map)
import qualified Data.Map as Map
import System.Directory
import System.FilePath.Posix
import System.PosixCompat.Files

-- | Copy the given hashed files from one location to hashed paths in another
-- location
copyFiles
  :: Map FilePath FilePath
  -> FilePath
  -> FilePath
  -> IO ()
copyFiles paths source destination = forM_ (Map.toList paths) $ \(original, hashed) -> do
  createDirectoryIfMissing True $ destination </> takeDirectory hashed
  copyFile (source </> original) (destination </> hashed)

-- | Copy the given hashed files from one location to hashed paths in another
-- location, and symlink the unhashed paths to the hashed ones
copyAndSymlink
  :: Map FilePath FilePath
  -> FilePath
  -> FilePath
  -> IO ()
copyAndSymlink paths source destination = forM_ (Map.toList paths) $ \(original, hashed) -> do
  createDirectoryIfMissing True $ destination </> takeDirectory hashed
  copyFile (source </> original) (destination </> hashed)
  createSymbolicLink (takeFileName hashed) $ destination </> original
