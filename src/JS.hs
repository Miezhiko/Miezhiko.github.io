{-# LANGUAGE
    OverloadedStrings
  , UnicodeSyntax
  #-}

module JS ( compressJsCompiler
          , minifyJsRoute
          ) where

import qualified Data.ByteString.Lazy.Char8 as LB
import           Data.List                  (isSuffixOf)
import qualified Data.Text                  as T
import qualified Data.Text.Encoding         as E

import           Hakyll

import           Text.Jasmine

compressJsCompiler ∷ Compiler (Item String)
compressJsCompiler = fmap jasmin <$> getResourceString

jasmin ∷ String → String
jasmin src = LB.unpack $ minify
                       $ LB.fromChunks [E.encodeUtf8 $ T.pack src]

minifyJsRoute ∷ FilePath -> FilePath
minifyJsRoute path =
  let minSuffix = ".min.js"
  in if minSuffix `isSuffixOf` path
       then path
       else (takeWhile (/= '.') path) ++ minSuffix
