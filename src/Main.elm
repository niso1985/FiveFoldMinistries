module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { ministries : Dict String Int }


init : Model
init =
    { ministries =
        Dict.fromList
            [ ( "Apostles", 0 )
            , ( "Prophets", 0 )
            , ( "Evangelists", 0 )
            , ( "Shepherds", 0 )
            , ( "Teachers", 0 )
            ]
    }



-- UPDATE


type Msg
    = Increment String
    | Decrement String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment mType ->
            { model | ministries = Dict.update mType (\(Just n) -> Just (n + 1)) model.ministries }

        Decrement mType ->
            { model | ministries = Dict.update mType (\(Just n) -> Just (n - 1)) model.ministries }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]
