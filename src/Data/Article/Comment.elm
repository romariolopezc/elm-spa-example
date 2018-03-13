module Data.Article.Comment exposing (Comment, CommentId, commentIdDecoder, decoder, idToString)

import Data.Article.Author as Author exposing (Author)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (custom, decode, required)
import Time exposing (Posix)
import Util


type alias Comment =
    { id : CommentId
    , body : String
    , createdAt : Posix
    , updatedAt : Posix
    , author : Author
    }



-- SERIALIZATION --


decoder : Decoder Comment
decoder =
    decode Comment
        |> required "id" commentIdDecoder
        |> required "body" Decode.string
        |> required "createdAt" Util.dateStringDecoder
        |> required "updatedAt" Util.dateStringDecoder
        |> required "author" Author.decoder



-- IDENTIFIERS --


type CommentId
    = CommentId Int


idToString : CommentId -> String
idToString (CommentId id) =
    toString id


commentIdDecoder : Decoder CommentId
commentIdDecoder =
    Decode.map CommentId Decode.int
