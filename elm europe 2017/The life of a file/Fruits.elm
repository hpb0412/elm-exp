module Fruits exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List exposing (..)
import SelectedFruits as SF


type alias Model =
    { fruits : List String
    , selected : SF.SelectedFruits
    }


initialModel : Model
initialModel =
    { fruits = [ "Apple", "Apricot", "Banana", "Mango", "Orange", "Plum" ]
    , selected = SF.empty 2
    }


type Msg
    = Select String
    | Deselect String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Select fruit ->
            { model | selected = SF.insert fruit model.selected }

        Deselect fruit ->
            { model | selected = SF.remove fruit model.selected }


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Which fruit do you want?" ]
        , fieldset [] (List.map (checkbox model.selected) model.fruits)
        ]


checkbox : SF.SelectedFruits -> String -> Html Msg
checkbox selectedFruits fruit =
    let
        isChecked =
            SF.member fruit selectedFruits

        message =
            if isChecked then
                Deselect fruit
            else
                Select fruit
    in
        label [ style [ ( "display", "block" ) ] ]
            [ input [ type_ "checkbox", checked isChecked, onClick message ] []
            , text fruit
            ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
