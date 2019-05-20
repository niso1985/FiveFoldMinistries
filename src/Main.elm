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
    = Select String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Select ps ->
            let
                p =
                    pairDecode ps
            in
            { model
                | ministries =
                    if Dict.get p.second model.ministries == Just 0 then
                        Dict.update p.first (addModel 1) model.ministries

                    else
                        Dict.update p.second (addModel -1) (Dict.update p.first (addModel 1) model.ministries)
            }


addModel : Int -> Maybe Int -> Maybe Int
addModel add v =
    case v of
        Just n ->
            Just (n + add)

        Nothing ->
            Just add



-- VIEW


type alias SelectionPair =
    { first : String
    , second : String
    }


pairEncode : Bool -> SelectionPair -> String
pairEncode isReverse p =
    if isReverse then
        p.second ++ "," ++ p.first

    else
        p.first ++ "," ++ p.second


pairDecode : String -> SelectionPair
pairDecode ps =
    case String.split "," ps of
        [ first, second ] ->
            SelectionPair first second

        _ ->
            SelectionPair "Nothing" "Nothing"


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "5役者の賜物の査定" ]
        , p [] [ text "下記1~30には、2つの主張(性向)が併記されています。そのうち、自分のことだ思う方を選んでください。" ]
        , table [ style "border-collapse" "collapse" ]
            [ tr []
                [ th [ sbs ] [ text "No" ]
                , th [ sbs ] [ text "主張(性向)" ]
                ]
            , row 1 "問題AAAA" "問題BBB" (SelectionPair "Apostles" "Prophets") Select
            , row 2 "問題AAAA" "問題BBB" (SelectionPair "Apostles" "Prophets") Select
            , row 3 "問題AAAA" "問題BBB" (SelectionPair "Apostles" "Prophets") Select
            , row 4 "問題AAAA" "問題BBB" (SelectionPair "Apostles" "Prophets") Select
            ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Apostles" model.ministries))) ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Prophets" model.ministries))) ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Evangelists" model.ministries))) ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Shepherds" model.ministries))) ]
        , div [] [ text (String.fromInt (Maybe.withDefault 0 (Dict.get "Teachers" model.ministries))) ]
        ]


row : Int -> String -> String -> SelectionPair -> (String -> msg) -> Html msg
row index q1 q2 m toMsg =
    tr []
        [ td [ sbs ] [ text (String.fromInt index) ]
        , tr [ sbs ]
            [ td [ sbs ] [ input [ type_ "radio", name (String.fromInt index), value (pairEncode False m), onInput toMsg ] [] ]
            , td [ sbs ] [ text q1 ]
            ]
        , tr [ sbs ]
            [ td [ sbs ] [ input [ type_ "radio", name (String.fromInt index), value (pairEncode True m), onInput toMsg ] [] ]
            , td [ sbs ] [ text q2 ]
            ]
        ]


sbs : Attribute msg
sbs =
    style "border" "solid 1px"
