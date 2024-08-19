import qualified Data.Text as T
import Obelisk.Asset.Copy
import Obelisk.Asset.Gather
import Obelisk.Asset.Promoted
import System.Environment

main :: IO ()
main = do
  --TODO: Usage
  [root, haskellTarget, packageName, moduleName, fileTarget] <- getArgs
  paths <- gatherHashedPaths root
  writeStaticProject paths haskellTarget $ StaticConfig
    { _staticConfig_packageName = T.pack packageName
    , _staticConfig_moduleName = T.pack moduleName
    }
  copyFiles paths root fileTarget
