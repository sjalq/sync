module Env exposing (..)

-- The Env.elm file is for per-environment configuration.
-- See https://dashboard.lamdera.app/docs/environment for more info.


dummyConfigItem =
    ""


slackApiToken =
    ""


slackChannel =
    ""


type Mode
    = Development
    | Production


mode : Mode
mode =
    Development
