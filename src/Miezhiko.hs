{-# LANGUAGE
    OverloadedStrings
  , UnicodeSyntax
  #-}

import           Hakyll

import           JS

moveRoute ∷ String -> String -> Routes
moveRoute p t = gsubRoute (p ++ "/") (const (t ++ "/"))

moveRouteHtml ∷ String -> String -> Routes
moveRouteHtml p t = moveRoute p t
                      `composeRoutes` setExtension "html"

main ∷ IO ()
main = hakyll $ do
  match "blog/*.md" $ do
    route $ moveRouteHtml "blog" "posts"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html"    pCtx
      >>= loadAndApplyTemplate "templates/default.html" pCtx
      >>= relativizeUrls

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
