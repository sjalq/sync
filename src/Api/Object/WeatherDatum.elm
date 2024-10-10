-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.WeatherDatum exposing (..)

import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.ScalarCodecs
import Api.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| A globally unique identifier. Can be used in various places throughout the system to identify this single value.
-}
nodeId : SelectionSet Api.ScalarCodecs.Id Api.Object.WeatherDatum
nodeId =
    Object.selectionForField "ScalarCodecs.Id" "nodeId" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecId |> .decoder)


id : SelectionSet Int Api.Object.WeatherDatum
id =
    Object.selectionForField "Int" "id" [] Decode.int


location : SelectionSet String Api.Object.WeatherDatum
location =
    Object.selectionForField "String" "location" [] Decode.string


time : SelectionSet Api.ScalarCodecs.Datetime Api.Object.WeatherDatum
time =
    Object.selectionForField "ScalarCodecs.Datetime" "time" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecDatetime |> .decoder)


wind : SelectionSet (Maybe String) Api.Object.WeatherDatum
wind =
    Object.selectionForField "(Maybe String)" "wind" [] (Decode.string |> Decode.nullable)


visibility : SelectionSet (Maybe String) Api.Object.WeatherDatum
visibility =
    Object.selectionForField "(Maybe String)" "visibility" [] (Decode.string |> Decode.nullable)


temperature : SelectionSet (Maybe String) Api.Object.WeatherDatum
temperature =
    Object.selectionForField "(Maybe String)" "temperature" [] (Decode.string |> Decode.nullable)


dewPoint : SelectionSet (Maybe String) Api.Object.WeatherDatum
dewPoint =
    Object.selectionForField "(Maybe String)" "dewPoint" [] (Decode.string |> Decode.nullable)


relativeHumidity : SelectionSet (Maybe String) Api.Object.WeatherDatum
relativeHumidity =
    Object.selectionForField "(Maybe String)" "relativeHumidity" [] (Decode.string |> Decode.nullable)


pressure : SelectionSet (Maybe String) Api.Object.WeatherDatum
pressure =
    Object.selectionForField "(Maybe String)" "pressure" [] (Decode.string |> Decode.nullable)


createdAt : SelectionSet (Maybe Api.ScalarCodecs.Datetime) Api.Object.WeatherDatum
createdAt =
    Object.selectionForField "(Maybe ScalarCodecs.Datetime)" "createdAt" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecDatetime |> .decoder |> Decode.nullable)
