module Pages.PageFrame exposing (..)

import Html exposing (..)
import Html.Attributes as Attr
import Pages.Admin
import Pages.Main
import Pages.Route exposing (..)
import Types exposing (..)


viewTabs : FrontendModel -> Html FrontendMsg
viewTabs model =
    div [ Attr.class "flex justify-center mb-5" ]
        [ viewTab "Main" Main model.currentRoute
        , viewTab "Admin" Admin model.currentRoute
        ]


viewTab : String -> Route -> Route -> Html FrontendMsg
viewTab label page currentPage =
    a
        [ Attr.href (Pages.Route.toString page)
        , Attr.classList
            [ ( "px-4 py-2 mx-2 border cursor-pointer", True )
            , ( "bg-gray-300", page == currentPage )
            , ( "bg-white", page /= currentPage )
            ]
        ]
        [ text label ]


viewCurrentPage : FrontendModel -> Html FrontendMsg
viewCurrentPage model =
    case model.currentRoute of
        Main ->
            Pages.Main.view model

        Admin ->
            Pages.Admin.view model

        NotFound ->
            viewNotFoundPage model


viewNotFoundPage : FrontendModel -> Html FrontendMsg
viewNotFoundPage model =
    div [ Attr.class "bg-gray-100 min-h-screen flex items-center justify-center" ]
        [ div [ Attr.class "text-center" ]
            [ h1 [ Attr.class "text-4xl font-bold text-gray-800 mb-4" ] [ text "404 - Page Not Found" ]
            , p [ Attr.class "text-lg text-gray-600" ] [ text "The page you're looking for doesn't exist." ]
            ]
        ]
