{-# LANGUAGE
    OverloadedStrings
  , UnicodeSyntax
  #-}

module CSS ( minifyCssRoute
           ) where

import           Data.List (isSuffixOf)

minifyCssRoute ∷ FilePath -> FilePath
minifyCssRoute path =
  let minSuffix = ".min.css"
  in if minSuffix `isSuffixOf` path
       then path
       else (takeWhile (/= '.') path) ++ minSuffix
