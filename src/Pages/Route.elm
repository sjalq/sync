module Pages.Route exposing (..)

import Browser.Navigation as Nav
import Types exposing (..)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, oneOf, s)


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Main Parser.top
        , Parser.map Admin (s "admin")
        ]


fromUrl : Url -> Route
fromUrl url =
    Parser.parse parser url
        |> Maybe.withDefault NotFound


pushUrl : Nav.Key -> Route -> Cmd msg
pushUrl key route =
    Nav.pushUrl key (toString route)


toString : Route -> String
toString route =
    case route of
        Main ->
            "/"

        Admin ->
            "/admin"

        NotFound ->
            "/not-found"
