module Test.Exit (exit) where

import Prelude

import Effect (Effect)

foreign import exit :: Int -> Effect Unit
