module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Http
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , currentRoute : Route
    , lastCountryInfo : Maybe CountryInfo
    , countryInput : String
    }


type alias BackendModel =
    { lastCountryInfo : Maybe CountryInfo
    , lastError : Maybe String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg
    | FetchCountryInfo String
    | UpdateCountryInput String


type Route
    = Main
    | Admin
    | NotFound


type ToBackend
    = NoOpToBackend
    | FetchCountryInfoRequest String


type BackendMsg
    = NoOpBackendMsg
    | GotCountryInfo (Result Http.Error CountryInfo)
    | CountryInfoInserted (Result String (Maybe ()))


type ToFrontend
    = NoOpToFrontend
    | CountryInfoFetched CountryInfo


type alias CountryInfo =
    { name : String
    , capital : String
    , phoneCode : String
    }
