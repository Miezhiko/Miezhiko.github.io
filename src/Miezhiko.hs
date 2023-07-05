{-# LANGUAGE
    OverloadedStrings
  , UnicodeSyntax
  #-}

import           Hakyll

moveRoute ∷ String -> String -> Routes
moveRoute p t = gsubRoute (p ++ "/") (const (t ++ "/"))
                  `composeRoutes` setExtension "html"

main ∷ IO ()
main = hakyll $ do
  match "blog/*.md" $ do
    route $ moveRoute "blog" "posts"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html"    pCtx
      >>= loadAndApplyTemplate "templates/default.html" pCtx
      >>= relativizeUrls

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
