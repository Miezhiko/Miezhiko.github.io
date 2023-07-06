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
            in doesDirectoryExist srcPath >>= \dirExist ->
                if dirExist then copyDirOrFiles srcPath name
                            else copyFile srcPath name
          removeDirIfExists hSite
          removeDirIfExists hCache

 where
  copyDirOrFiles :: FilePath -> FilePath -> IO ()
  copyDirOrFiles s t =
    doesDirectoryExist t >>= \dirExist ->
      if dirExist then do hContent <- getDirectoryContents s
                          let hh = filter (`notElem` [".", ".."]) hContent
                          for_ hh $ \name -> do
                            let srcPath = s </> name
                                trgPath = t </> name
                            ex <- doesDirectoryExist srcPath
                            if ex then copyDir srcPath trgPath
                                  else copyFile srcPath trgPath
                  else copyDir s t

  appName ∷ String
  appName = "Miezhiko"

  buildPath ∷ String
  buildPath = "dist-newstyle"

  miezExecutable ∷ String
  miezExecutable =
    {- HLINT ignore "Redundant multi-way if" -}
    if | os ∈ ["win32", "mingw32", "cygwin32"] -> buildPath </> appName ++ "exe"
       | otherwise                             -> buildPath </> appName
