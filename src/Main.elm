module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


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
            { model | ministries = Dict.update mType (addModel 1) model.ministries }

        Decrement mType ->
            { model | ministries = Dict.update mType (addModel -1) model.ministries }


addModel : Int -> Maybe Int -> Maybe Int
addModel add v =
    case v of
        Just n ->
            Just (n + add)

        Nothing ->
            Just add



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "5役者の賜物の査定" ]
        , p [] [ text "下記1~30には、2つの主張(性向)が併記されています。そのうち、自分のことだ思う方を選んでください。" ]
        , input [ type_ "radio", name "rrr", value "n" ] [ text "asdfasdfa" ]
        , input [ type_ "radio", name "rrr", value "n1" ] [ text "ddddd" ]
        , table [ style "border-collapse" "collapse" ]
            [ tr []
                [ td [ sbs ] [ text "1" ]
                , tr [ sbs ]
                    [ td [ sbs ] [ text "aaa" ]
                    , td [ sbs ] [ text "問題文" ]
                    ]
                , tr [ sbs ]
                    [ td [ sbs ] [ text "bbb" ]
                    , td [ sbs ] [ text "問題部" ]
                    ]
                ]
            , tr []
                [ td [ sbs ] [ text "2" ]
                , tr [ sbs ]
                    [ td [ sbs ] [ text "ccc" ]
                    , td [ sbs ] [ text "問題文" ]
                    ]
                , tr [ sbs ]
                    [ td [ sbs ] [ text "bbb" ]
                    , td [ sbs ] [ text "問題部" ]
                    ]
                ]
            , row 3 "ccc" "Apostles" "question" "Prophets" Increment
            , row 4 "ccc" "Apostles" "question" "Prophets" Increment
            , row 5 "ccc" "Apostles" "question" "Prophets" Increment
            , row 6 "ccc" "Apostles" "question" "Prophets" Increment
            , row 7 "ccc" "Apostles" "question" "Prophets" Increment
            ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Apostles" model.ministries))) ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Prophets" model.ministries))) ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Evangelists" model.ministries))) ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Shepherds" model.ministries))) ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Teachers" model.ministries))) ]
        ]


row : Int -> String -> String -> String -> String -> (String -> msg) -> Html msg
row index q1 m1 q2 m2 toMsg =
    tr []
        [ td [ sbs ] [ text (String.fromInt index) ]
        , tr [ sbs ]
            [ td [ sbs ] [ input [ type_ "radio", name (String.fromInt index), value m1, onInput toMsg ] [] ]
            , td [ sbs ] [ text q1 ]
            ]
        , tr [ sbs ]
            [ td [ sbs ] [ input [ type_ "radio", name (String.fromInt index), value m2, onInput toMsg ] [] ]
            , td [ sbs ] [ text q2 ]
            ]
        ]


sbs : Attribute msg
sbs =
    style "border" "solid 1px"
