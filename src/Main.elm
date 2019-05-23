module Main exposing (Model, Msg(..), init, main, update, view)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { answer : Array MinisterType }


init : Model
init =
    { answer = Array.repeat 30 None }


type MinisterType
    = A
    | B
    | C
    | D
    | E
    | None


ministerToString : MinisterType -> String
ministerToString m =
    case m of
        A ->
            "Apostles"

        B ->
            "Prophets"

        C ->
            "Evangelists"

        D ->
            "Shepherds"

        E ->
            "Teachers"

        None ->
            ""


stringToMinister : String -> MinisterType
stringToMinister str =
    case str of
        "Apostles" ->
            A

        "Prophets" ->
            B

        "Evangelists" ->
            C

        "Shepherds" ->
            D

        "Teachers" ->
            E

        _ ->
            None


getSelectedNum : MinisterType -> Array MinisterType -> Int
getSelectedNum check a =
    a
        |> Array.foldl
            (\m sum ->
                if m == check then
                    sum + 1

                else
                    sum
            )
            0



-- UPDATE


type Msg
    = Select Int String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Select index str ->
            { model
                | answer = model.answer |> Array.set index (stringToMinister str)
            }



-- VIEW


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
            , row 1 "私はリーダーの動きに合わせるようにしています。" "私は人と一緒に問題を克服するのが好きです。" A D
            , row 2 "私は具体的な答えを得るために、具体的な質問をします。" "私は学んだことを明確に表現し、人々が理解できるように取り組みをするのが好きです。" B E
            , row 3 "私は人が幸せでいるかどうか知りたいです。" "私は人々が成熟し、成長することにワクワクします。" C A
            , row 4 "よく人から相談とサポートを求められます。" "私はできる限り正確に何かをすることが好きです。" D E
            , row 5 "私はビジョンや夢を定期的に書き留めます。" "私は人に良いことを伝える方法を様々に考えます。" B C
            , row 6 "私は人を見る目があると言われています。" "人生の歩みの中で、軸となる価値観は 、私にとって不可欠です。" B E
            , row 7 "私は意見の一致が状況を改善する主要な方法だと考えています。" "私は意見を聞いて、 他の意見を知ることが状況を改善する方法だと信じています。" A B
            , row 8 "私は物事を黒か白のどちらかだと見なす傾向があります。" "私は大きな絵(ビジョン)を掲げ続ける能力があります。" E A
            , row 9 "私は正しいことを中心に据える傾向があります。" "私は離れてしまった人たちのことを、頻繁に思い出し考えています。" E C
            , row 10 "私は人々が成熟するのを助け、成長することを優先します。" "私は人々の心を癒やし、助けたりするのが大好きです。" A D
            , row 11 "私は利他の心がない人のために時々泣いています。" "私は他の人たちが成長し、仕事ができるように成長させるのが好きです。" C A
            , row 12 "私は人の話を聞いて質問するのが大好きです。" "私は人々がアドバイスを聞けるように助けるのが好きです。" D B
            , row 13 "人々を運命(目的)に導くことは最も重要なことです。" "人を愛することは最も重要なことです。" A D
            , row 14 "私は他の人のためにアドバイスを聞き求めます。" "私は批判的にはなりたくないですが、人々は自分自身に正直でなければならないと思います。" B E
            , row 15 "私はしばしば奇跡が起こるように願い、人々が癒やされるのを見ます。" "私は人々が責任を持ち、正しい情報の中に留まることに情熱を持っています。" A E
            , row 16 "勉強するとき、私は知るということに飢え乾いています。" "私は考えるとき、よく他の人のことについて、思いつきます。" E B
            , row 17 "人は私について、たいへん辛抱強く、人の世話をしていると言います。" "私は好きなことを遠くへ伝えに行くことが大好きです。" D C
            , row 18 "私はネットワーク化と人をつなぐのが好きです。" "私は人々が夢とビジョンを具体的になるよう助けます。" A B
            , row 19 "私はテーマについてすべてを学ぶのが好きです。" "私は平和が好きで、人々が愛し合える方法を見せます。" E D
            , row 20 "私は人々を慰めて励ますのが大好きです。" "私は一貫して利他の心がない人を考えています。" D C
            , row 21 "私はよく他人を励ますために個人的な言葉を語ります。" "私は一度だけ会った人でも、その人のことを心の中で思っています。" B D
            , row 22 "私は好きなことを、できる限りシェアします。" "私は人々が集まるグループに焦点を当て、そのグループに近づく戦略を立てます。" C A
            , row 23 "私は罪ある人達を見ると、すぐに「救いが必要だ」と考えます。" "映画のキャラクターであっても、すぐに感情移入します。" C D
            , row 24 "私は思い付きを言葉にし、人々やグループに宣言します。" "私は私にとって重要なことは、誰にでもシェアするのが大好きです。" B C
            , row 25 "会議やイベントに出席していない人のことを気にかけている自分によく気がつきます。" "私は地上と天国のつながりが非常によくわかります。" D B
            , row 26 "私は基盤となる考え方と原則に焦点を当てます。" "私は新しい人に会い、新しい状況が好きです。" E C
            , row 27 "私は新しいことを始めて、仲間を募集するのが好きです。" "私には、日々、新鮮な情報を受けることが重要です。" A B
            , row 28 "私はタイミングがあれば、熱心に私の好きなことを分かち合います。" "私は物事を秩序に従って整理して、明確にするのが好きです。" C E
            , row 29 "人々は私のところに来て、サポートと助けを求めます。" "私は他の人を訓練して、働きに解き放つのが好きです。" D A
            , row 30 "私は人々が正しい情報を保つのを助けます。" "私はイベントで一緒に集うために、人々を招くのが得意です。" E C
            ]
        , button [ disabled (model.answer |> Array.filter (\m -> m == None) |> Array.length |> (\len -> len /= 0)) ] [ text "診断" ]
        , div [] [ text (String.fromInt (model.answer |> getSelectedNum A)) ]
        , div [] [ text (String.fromInt (model.answer |> getSelectedNum B)) ]
        , div [] [ text (String.fromInt (model.answer |> getSelectedNum C)) ]
        , div [] [ text (String.fromInt (model.answer |> getSelectedNum D)) ]
        , div [] [ text (String.fromInt (model.answer |> getSelectedNum E)) ]
        ]


row : Int -> String -> String -> MinisterType -> MinisterType -> Html Msg
row index q1 q2 m1 m2 =
    tr []
        [ td [ sbs ] [ text (String.fromInt index) ]
        , tr [ sbs ]
            [ td [ sbs ] [ input [ type_ "radio", name (String.fromInt index), value (ministerToString m1), onInput (Select (index - 1)) ] [] ]
            , td [ sbs ] [ text q1 ]
            ]
        , tr [ sbs ]
            [ td [ sbs ] [ input [ type_ "radio", name (String.fromInt index), value (ministerToString m2), onInput (Select (index - 1)) ] [] ]
            , td [ sbs ] [ text q2 ]
            ]
        ]


sbs : Attribute msg
sbs =
    style "border" "solid 1px"
