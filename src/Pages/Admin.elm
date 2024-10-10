module Pages.Admin exposing (view)

import Html exposing (..)
import Html.Attributes as Attr
import Types exposing (FrontendModel, FrontendMsg)


view : FrontendModel -> Html FrontendMsg
view model =
    div [ Attr.class "bg-gray-100 min-h-screen p-8" ]
        [ h1 [ Attr.class "text-3xl font-bold text-gray-800 mb-6" ] [ text "Admin Page" ]
        , p [ Attr.class "text-lg text-gray-600" ] [ text "Welcome to the admin page. Here you can manage your application settings and data." ]

        -- Add more admin-specific content here
        ]
