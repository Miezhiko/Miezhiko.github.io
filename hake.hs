{-# LANGUAGE
    MultiWayIf
  , UnicodeSyntax
  #-}

import           Hake

main ∷ IO ()
main = hake $ do
  "clean | clean the project" ∫
    cabal ["clean"] ?> removeDirIfExists buildPath
                    >> cleanCabalLocal

  "build deps | install all the dependencies" ∫
    cabal ["install", "--only-dependencies", "--overwrite-policy=always"]

  miezExecutable ♯
   let processBuild =
           cabalConfigure
        >> cabalBuild
        >> getCabalBuildPath appName >>=
            \p -> copyFile p miezExecutable
       mie a = system (miezExecutable ++ " " ++ a)
    in do processBuild ?> cleanCabalLocal
          _ <- mie "clean"
          _ <- mie "build"
          let hSite   = "_site"
              hCache  = "_cache"
              hPosts  = "posts"
          removeDirIfExists hPosts
          hContent <- getDirectoryContents hSite
          let hh = filter (`notElem` [".", "..", "src"]) hContent
          for_ hh $ \name ->
            let srcPath = hSite </> name
            in doesDirectoryExist srcPath >>= \dirExist →
                if dirExist then copyDir srcPath name
                            else copyFile srcPath name
          removeDirIfExists hSite
          removeDirIfExists hCache

 where
  appName ∷ String
  appName = "Miezhiko"

  buildPath ∷ String
  buildPath = "dist-newstyle"

  miezExecutable ∷ String
  miezExecutable =
    {- HLINT ignore "Redundant multi-way if" -}
    if | os ∈ ["win32", "mingw32", "cygwin32"] -> buildPath </> appName ++ "exe"
       | otherwise                             -> buildPath </> appName
