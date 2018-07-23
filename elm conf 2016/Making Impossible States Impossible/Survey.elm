module Survey exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Questions as Q exposing (..)


type alias Model =
    { history : History }


first : Q.Question
first =
    { prompt = "question 1", response = Just "answer 1" }


remaining : List Q.Question
remaining =
    [ { prompt = "question 2", response = Just "answer 2" }
    , { prompt = "question 3", response = Just "answer 3" }
    , { prompt = "question 4", response = Just "answer 4" }
    , { prompt = "question 5", response = Just "answer 5" }
    ]


initialModel : Model
initialModel =
    { history = Q.init first remaining }


view : Model -> Html Msg
view { history } =
    div []
        [ h2 [] [ text "Survey" ]
        , fieldset []
            [ button [ onClick Bck ] [ text "Back" ]
            , button [ onClick Fwd ] [ text "Forw" ]
            , toHtml history
            ]
        ]


type Msg
    = Fwd
    | Bck


update : Msg -> Model -> Model
update msg ({ history } as model) =
    case msg of
        Fwd ->
            { model | history = forward history }

        Bck ->
            { model | history = back history }


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
