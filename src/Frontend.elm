module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Html
import Lamdera
import Pages.PageFrame as PageFrame
import Pages.Route
import Types exposing (..)
import Url


type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \m -> Sub.none
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( { key = key
      , currentRoute = Pages.Route.fromUrl url
      , lastCountryInfo = Nothing
      , countryInput = ""
      }
    , Cmd.none
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | currentRoute = Pages.Route.fromUrl url }
            , Cmd.none
            )

        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        NoOpFrontendMsg ->
            ( model, Cmd.none )

        FetchCountryInfo isoCode ->
            ( model
            , Lamdera.sendToBackend (FetchCountryInfoRequest isoCode)
            )

        UpdateCountryInput input ->
            ( { model | countryInput = input }, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        CountryInfoFetched info ->
            ( { model | lastCountryInfo = Just info }, Cmd.none )


view : Model -> Browser.Document FrontendMsg
view model =
    { title = "Weather Data App"
    , body = [ PageFrame.viewCurrentPage model ]
    }
