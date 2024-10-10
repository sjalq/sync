module Pages.Main exposing (..)

import Html exposing (..)
import Html.Attributes as Attr
import Html.Events exposing (onClick, onInput)
import Types exposing (..)


init : FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
init model =
    ( model, Cmd.none )


view : FrontendModel -> Html FrontendMsg
view model =
    div [ Attr.class "bg-gray-100 min-h-screen" ]
        [ div [ Attr.class "container mx-auto px-4 py-8" ]
            [ h1 [ Attr.class "text-3xl font-bold text-gray-800 mb-8" ] [ text "Weather Data Fetcher" ]
            , div [ Attr.class "bg-white shadow-md rounded-lg p-6 mb-8" ]
                [ div [ Attr.class "flex items-center mb-4" ]
                    [ input
                        [ Attr.type_ "text"
                        , Attr.placeholder "Enter country code (e.g., US)"
                        , Attr.value model.countryInput
                        , Attr.class "border rounded-l px-4 py-2 w-64 focus:outline-none focus:ring-2 focus:ring-blue-500"
                        , Html.Events.onInput UpdateCountryInput
                        ]
                        []
                    , button
                        [ Attr.class "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-r"
                        , onClick (FetchCountryInfo model.countryInput)
                        ]
                        [ text "Fetch Country Info" ]
                    ]
                , viewCountryInfo model
                ]
            ]
        ]



-- viewWeatherData : FrontendModel -> Html FrontendMsg
-- viewWeatherData model =
--     div [ Attr.class "mt-6" ]
--         [ h2 [ Attr.class "text-xl font-semibold mb-4" ] [ text "Last Fetched Weather Data" ]
--         , case model.lastCountryInfo of
--             Just countryInfo ->
--                 table [ Attr.class "min-w-full bg-white border border-gray-300" ]
--                     [ thead []
--                         [ tr [ Attr.class "bg-gray-200 text-gray-600 uppercase text-sm leading-normal" ]
--                             [ th [ Attr.class "py-3 px-6 text-left" ] [ text "Field" ]
--                             , th [ Attr.class "py-3 px-6 text-left" ] [ text "Value" ]
--                             ]
--                         ]
--                     , tbody [ Attr.class "text-gray-600 text-sm font-light" ]
--                         [ weatherDataRow "Location" weatherData.location
--                         , weatherDataRow "Time" weatherData.time
--                         , weatherDataRow "Wind" weatherData.wind
--                         , weatherDataRow "Visibility" weatherData.visibility
--                         , weatherDataRow "Temperature" weatherData.temperature
--                         , weatherDataRow "Dew Point" weatherData.dewPoint
--                         , weatherDataRow "Relative Humidity" weatherData.relativeHumidity
--                         , weatherDataRow "Pressure" weatherData.pressure
--                         ]
--                     ]
--             Nothing ->
--                 p [ Attr.class "text-gray-600" ] [ text "No weather data fetched yet." ]
--         ]


weatherDataRow : String -> String -> Html FrontendMsg
weatherDataRow field value =
    tr [ Attr.class "border-b border-gray-200 hover:bg-gray-100" ]
        [ td [ Attr.class "py-3 px-6 text-left whitespace-nowrap font-medium" ] [ text field ]
        , td [ Attr.class "py-3 px-6 text-left" ] [ text value ]
        ]


viewCountryInfo : FrontendModel -> Html FrontendMsg
viewCountryInfo model =
    div [ Attr.class "mt-6" ]
        [ h2 [ Attr.class "text-xl font-semibold mb-4" ] [ text "Last Fetched Country Info" ]
        , case model.lastCountryInfo of
            Just countryInfo ->
                table [ Attr.class "min-w-full bg-white border border-gray-300" ]
                    [ thead []
                        [ tr [ Attr.class "bg-gray-200 text-gray-600 uppercase text-sm leading-normal" ]
                            [ th [ Attr.class "py-3 px-6 text-left" ] [ text "Field" ]
                            , th [ Attr.class "py-3 px-6 text-left" ] [ text "Value" ]
                            ]
                        ]
                    , tbody [ Attr.class "text-gray-600 text-sm font-light" ]
                        [ countryInfoRow "Name" countryInfo.name
                        , countryInfoRow "Capital" countryInfo.capital
                        , countryInfoRow "Phone Code" countryInfo.phoneCode
                        ]
                    ]

            Nothing ->
                p [ Attr.class "text-gray-600" ] [ text "No country info fetched yet." ]
        ]


countryInfoRow : String -> String -> Html FrontendMsg
countryInfoRow field value =
    tr [ Attr.class "border-b border-gray-200 hover:bg-gray-100" ]
        [ td [ Attr.class "py-3 px-6 text-left whitespace-nowrap" ] [ text field ]
        , td [ Attr.class "py-3 px-6 text-left" ] [ text value ]
        ]
