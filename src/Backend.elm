module Backend exposing (..)

import Api.InputObject as InputObject
import Api.Mutation as Mutation
import Api.Scalar exposing (Datetime(..))
import Graphql.Http
import Graphql.Operation exposing (RootMutation)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Http
import Lamdera exposing (ClientId, SessionId)
import Supplemental exposing (..)
import Task
import Types exposing (..)
import Xml.Decode as Decode exposing (Decoder, path, single, string)


type alias Model =
    BackendModel


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = \m -> Sub.none
        }


init : ( Model, Cmd BackendMsg )
init =
    ( { lastCountryInfo = Nothing
      , lastError = Nothing
      }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Cmd.none )

        GotCountryInfo res ->
            case res of
                Ok countryInfo ->
                    ( { model | lastCountryInfo = Just countryInfo }
                    , insertCountryInfo countryInfo
                    )

                Err error ->
                    ( { model | lastError = Just (Debug.toString error) }, Cmd.none )

        CountryInfoInserted res ->
            case res of
                Ok _ ->
                    ( model, Cmd.none )

                Err error ->
                    ( { model | lastError = Just error }, Cmd.none )



-- getWeatherData : String -> Cmd BackendMsg
-- getWeatherData city =
--     let
--         url =
--             "http://www.webservicex.net/globalweather.asmx"
--         soapEnvelope =
--             """<?xml version="1.0" encoding="utf-8"?>
--                <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
--                  <soap:Body>
--                    <GetWeather xmlns="http://www.webserviceX.NET">
--                      <CityName>""" ++ city ++ """</CityName>
--                      <CountryName>United States</CountryName>
--                    </GetWeather>
--                  </soap:Body>
--                </soap:Envelope>"""
--     in
--     Http.task
--         { method = "POST"
--         , headers = [ Http.header "Content-Type" "text/xml; charset=utf-8" ]
--         , url = url
--         , body = Http.stringBody "text/xml" soapEnvelope
--         , resolver = Http.stringResolver (handleWeatherResponse weatherDataDecoder)
--         , timeout = Nothing
--         }
--         |> Task.attempt GotWeatherData
-- handleWeatherResponse : Decoder WeatherData -> Http.Response String -> Result Http.Error WeatherData
-- handleWeatherResponse decoder response =
--     case response of
--         Http.BadUrl_ url ->
--             Err (Http.BadUrl url)
--         Http.Timeout_ ->
--             Err Http.Timeout
--         Http.NetworkError_ ->
--             Err Http.NetworkError
--         Http.BadStatus_ metadata _ ->
--             Err (Http.BadStatus metadata.statusCode)
--         Http.GoodStatus_ _ body ->
--             case Decode.decodeString decoder body of
--                 Ok weatherData ->
--                     Ok weatherData
--                 Err err ->
--                     Err (Http.BadBody err)
-- weatherDataDecoder : Decoder WeatherData
-- weatherDataDecoder =
--     let
--         path_ =
--             path [ "soap:Envelope", "soap:Body", "GetWeatherResponse", "GetWeatherResult" ]
--     in
--     Decode.succeed WeatherData
--         |> Decode.andMap (path_ (single (path [ "Location" ] (single string))))
--         |> Decode.andMap (path_ (single (path [ "Time" ] (single string))))
--         |> Decode.andMap (path_ (single (path [ "Wind" ] (single string))))
--         |> Decode.andMap (path_ (single (path [ "Visibility" ] (single string))))
--         |> Decode.andMap (path_ (single (path [ "Temperature" ] (single string))))
--         |> Decode.andMap (path_ (single (path [ "DewPoint" ] (single string))))
--         |> Decode.andMap (path_ (single (path [ "RelativeHumidity" ] (single string))))
--         |> Decode.andMap (path_ (single (path [ "Pressure" ] (single string))))


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        FetchCountryInfoRequest isoCode ->
            ( model
            , getCountryInfo isoCode
            )



-- insertWeatherData : WeatherData -> Cmd BackendMsg
-- insertWeatherData weatherData =
--     let
--         mutation =
--             Mutation.createWeatherDatum
--                 { input =
--                     InputObject.buildCreateWeatherDatumInput
--                         { weatherDatum =
--                             InputObject.buildWeatherDatumInput
--                                 { location = weatherData.location
--                                 , time = Datetime weatherData.time
--                                 }
--                                 (\opts ->
--                                     { opts
--                                         | wind = Present weatherData.wind
--                                         , visibility = Present weatherData.visibility
--                                         , temperature = Present weatherData.temperature
--                                         , dewPoint = Present weatherData.dewPoint
--                                         , relativeHumidity = Present weatherData.relativeHumidity
--                                         , pressure = Present weatherData.pressure
--                                     }
--                                 )
--                         }
--                         identity
--                 }
--                 (SelectionSet.succeed ())
--         mutationRequest =
--             mutation
--                 |> Graphql.Http.mutationRequest "/graphql"
--     in
--     mutationRequest
--         |> Graphql.Http.send (resultToSimpleErrorResult >> WeatherDataInserted)


getCountryInfo : String -> Cmd BackendMsg
getCountryInfo countryISOCode =
    let
        url =
            "http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso"

        soapEnvelope =
            """<?xml version="1.0" encoding="utf-8"?>
               <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                 <soap:Body>
                   <FullCountryInfo xmlns="http://www.oorsprong.org/websamples.countryinfo">
                     <sCountryISOCode>""" ++ countryISOCode ++ """</sCountryISOCode>
                   </FullCountryInfo>
                 </soap:Body>
               </soap:Envelope>"""
    in
    Http.task
        { method = "POST"
        , headers = [ Http.header "Content-Type" "text/xml; charset=utf-8" ]
        , url = url
        , body = Http.stringBody "text/xml" soapEnvelope
        , resolver = Http.stringResolver (handleCountryInfoResponse countryInfoDecoder)
        , timeout = Nothing
        }
        |> Task.attempt GotCountryInfo


handleCountryInfoResponse : (String -> Result String CountryInfo) -> Http.Response String -> Result Http.Error CountryInfo
handleCountryInfoResponse decoder response =
    case response of
        Http.BadUrl_ url ->
            Err (Http.BadUrl url)

        Http.Timeout_ ->
            Err Http.Timeout

        Http.NetworkError_ ->
            Err Http.NetworkError

        Http.BadStatus_ metadata body ->
            Err (Http.BadStatus metadata.statusCode)

        Http.GoodStatus_ metadata body ->
            case decoder body of
                Ok value ->
                    Ok value

                Err err ->
                    Err (Http.BadBody err)


countryInfoDecoder : String -> Result String CountryInfo
countryInfoDecoder xmlString =
    let
        decoder : Decoder CountryInfo
        decoder =
            Decode.succeed CountryInfo
                |> Decode.andMap (path [ "soap:Body", "m:FullCountryInfoResponse", "m:FullCountryInfoResult", "m:sName" ] (single string))
                |> Decode.andMap (path [ "soap:Body", "m:FullCountryInfoResponse", "m:FullCountryInfoResult", "m:sCapitalCity" ] (single string))
                |> Decode.andMap (path [ "soap:Body", "m:FullCountryInfoResponse", "m:FullCountryInfoResult", "m:sPhoneCode" ] (single string))
    in
    case Decode.decodeString decoder xmlString of
        Ok countryInfo ->
            Ok countryInfo

        Err error ->
            Err error


insertCountryInfo : CountryInfo -> Cmd BackendMsg
insertCountryInfo countryInfo =
    let
        mutation =
            Mutation.createCountryInfo
                { input =
                    InputObject.buildCreateCountryInfoInput
                        { countryInfo =
                            InputObject.buildCountryInfoInput
                                { name = countryInfo.name
                                , capital = countryInfo.capital
                                , phoneCode = countryInfo.phoneCode
                                }
                                identity
                        }
                        identity
                }
                (SelectionSet.succeed ())

        mutationRequest =
            mutation
                |> Graphql.Http.mutationRequest "http://127.0.0.1:5000/graphql"
    in
    mutationRequest
        |> Graphql.Http.send (resultToSimpleErrorResult >> CountryInfoInserted)
