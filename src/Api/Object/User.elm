-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.User exposing (..)

import Api.Enum.TransactionsOrderBy
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
nodeId : SelectionSet Api.ScalarCodecs.Id Api.Object.User
nodeId =
    Object.selectionForField "ScalarCodecs.Id" "nodeId" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecId |> .decoder)


id : SelectionSet Int Api.Object.User
id =
    Object.selectionForField "Int" "id" [] Decode.int


username : SelectionSet String Api.Object.User
username =
    Object.selectionForField "String" "username" [] Decode.string


email : SelectionSet String Api.Object.User
email =
    Object.selectionForField "String" "email" [] Decode.string


createdAt : SelectionSet (Maybe Api.ScalarCodecs.Datetime) Api.Object.User
createdAt =
    Object.selectionForField "(Maybe ScalarCodecs.Datetime)" "createdAt" [] (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapCodecs |> .codecDatetime |> .decoder |> Decode.nullable)


type alias TransactionsByClientIdOptionalArguments =
    { first : OptionalArgument Int
    , last : OptionalArgument Int
    , offset : OptionalArgument Int
    , before : OptionalArgument Api.ScalarCodecs.Cursor
    , after : OptionalArgument Api.ScalarCodecs.Cursor
    , orderBy : OptionalArgument (List Api.Enum.TransactionsOrderBy.TransactionsOrderBy)
    , condition : OptionalArgument Api.InputObject.TransactionCondition
    }


{-| Reads and enables pagination through a set of `Transaction`.

  - first - Only read the first `n` values of the set.
  - last - Only read the last `n` values of the set.
  - offset - Skip the first `n` values from our `after` cursor, an alternative to cursor
    based pagination. May not be used with `last`.
  - before - Read all values in the set before (above) this cursor.
  - after - Read all values in the set after (below) this cursor.
  - orderBy - The method to use when ordering `Transaction`.
  - condition - A condition to be used in determining which values should be returned by the collection.

-}
transactionsByClientId :
    (TransactionsByClientIdOptionalArguments -> TransactionsByClientIdOptionalArguments)
    -> SelectionSet decodesTo Api.Object.TransactionsConnection
    -> SelectionSet decodesTo Api.Object.User
transactionsByClientId fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { first = Absent, last = Absent, offset = Absent, before = Absent, after = Absent, orderBy = Absent, condition = Absent }

        optionalArgs____ =
            [ Argument.optional "first" filledInOptionals____.first Encode.int, Argument.optional "last" filledInOptionals____.last Encode.int, Argument.optional "offset" filledInOptionals____.offset Encode.int, Argument.optional "before" filledInOptionals____.before (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecCursor), Argument.optional "after" filledInOptionals____.after (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecCursor), Argument.optional "orderBy" filledInOptionals____.orderBy (Encode.enum Api.Enum.TransactionsOrderBy.toString |> Encode.list), Argument.optional "condition" filledInOptionals____.condition Api.InputObject.encodeTransactionCondition ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "transactionsByClientId" optionalArgs____ object____ Basics.identity
