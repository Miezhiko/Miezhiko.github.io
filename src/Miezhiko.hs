{-# LANGUAGE
    OverloadedStrings
  , UnicodeSyntax
  #-}

import           Hakyll

import           CSS
import           JS

moveRoute ∷ String -> String -> Routes
moveRoute p t = gsubRoute (p ++ "/") (const (t ++ "/"))

moveRouteHtml ∷ String -> String -> Routes
moveRouteHtml p t = moveRoute p t
                      `composeRoutes` setExtension "html"

runGHC ∷ Compiler (Item String)
runGHC = getResourceString >>= withItemBody (unixFilter "runghc" [])

main ∷ IO ()
main = hakyll $ do
  match "blog/*.md" $ do
    route $ moveRouteHtml "blog" "posts"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html"    pCtx
      >>= loadAndApplyTemplate "templates/default.html" pCtx
      >>= relativizeUrls

  match "css/*.hs" $ do
    route $ setExtension "min.css"
    compile $ fmap compressCss <$> runGHC

  match (fromGlob "css/*.css" .&&. complement (fromGlob "css/*.min.css")) $ do
    route $ customRoute (minifyCssRoute . toFilePath)
    compile compressCssCompiler

  match (fromGlob "js/*.js" .&&. complement (fromGlob "js/*.min.js")) $ do
    route $ customRoute (minifyJsRoute . toFilePath)
    compile compressJsCompiler

  create ["index.html"] $ do
    route idRoute
    compile $ do
      blog ← recentFirst =<< loadAll "blog/*"
      let iCtx =
            listField "posts" pCtx (return blog) `mappend`
            defaultContext

      makeItem ""
        >>= loadAndApplyTemplate "templates/index.html" iCtx
        >>= loadAndApplyTemplate "templates/default.html" pCtx
        >>= relativizeUrls

  match "templates/*" $ compile templateCompiler

pCtx ∷ Context String
pCtx =
  dateField "date" "%e %B %Y" `mappend`
  defaultContext
