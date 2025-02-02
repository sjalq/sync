-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.DeleteWeatherDatumPayload exposing (..)

import Api.Enum.WeatherDataOrderBy
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


{-| The exact same `clientMutationId` that was provided in the mutation input,
unchanged and unused. May be used by a client to track mutations.
-}
clientMutationId : SelectionSet (Maybe String) Api.Object.DeleteWeatherDatumPayload
clientMutationId =
    Object.selectionForField "(Maybe String)" "clientMutationId" [] (Decode.string |> Decode.nullable)


{-| The `WeatherDatum` that was deleted by this mutation.
-}
weatherDatum :
    SelectionSet decodesTo Api.Object.WeatherDatum
    -> SelectionSet (Maybe decodesTo) Api.Object.DeleteWeatherDatumPayload
weatherDatum object____ =
    Object.selectionForCompositeField "weatherDatum" [] object____ (Basics.identity >> Decode.nullable)


deletedWeatherDatumId : SelectionSet (Maybe Api.ScalarCodecs.Id) Api.Object.DeleteWeatherDatumPayload
deletedWeatherDatumId =
    Object.selectionForField "(Maybe ScalarCodecs.Id)" "deletedWeatherDatumId" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecId |> .decoder |> Decode.nullable)


{-| Our root query field type. Allows us to run any query from our mutation payload.
-}
query :
    SelectionSet decodesTo RootQuery
    -> SelectionSet (Maybe decodesTo) Api.Object.DeleteWeatherDatumPayload
query object____ =
    Object.selectionForCompositeField "query" [] object____ (Basics.identity >> Decode.nullable)


type alias WeatherDatumEdgeOptionalArguments =
    { orderBy : OptionalArgument (List Api.Enum.WeatherDataOrderBy.WeatherDataOrderBy) }


{-| An edge for our `WeatherDatum`. May be used by Relay 1.

  - orderBy - The method to use when ordering `WeatherDatum`.

-}
weatherDatumEdge :
    (WeatherDatumEdgeOptionalArguments -> WeatherDatumEdgeOptionalArguments)
    -> SelectionSet decodesTo Api.Object.WeatherDataEdge
    -> SelectionSet (Maybe decodesTo) Api.Object.DeleteWeatherDatumPayload
weatherDatumEdge fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { orderBy = Absent }

        optionalArgs____ =
            [ Argument.optional "orderBy" filledInOptionals____.orderBy (Encode.enum Api.Enum.WeatherDataOrderBy.toString |> Encode.list) ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "weatherDatumEdge" optionalArgs____ object____ (Basics.identity >> Decode.nullable)
