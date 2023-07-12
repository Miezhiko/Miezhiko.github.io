{-# LANGUAGE
    OverloadedStrings
  , UnicodeSyntax
  #-}

import           Clay
import           Prelude hiding (div, span)

main ∷ IO ()
main = putCss $ do
  body ? do margin    nil nil nil nil
            padding   nil nil nil nil

  "#canvas" ? do zIndex 90
                 height $ pct 100
                 width  $ pct 100
                 position absolute
                 top    $ px 5
                 left   nil
