module Settings exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { email : Bool
    , autoplay : Autoplay
    , location : Bool
    }


type Autoplay
    = Off AutoplaySettings
    | On AutoplaySettings


toggleAutoplay : Autoplay -> Autoplay
toggleAutoplay autoplay =
    case autoplay of
        On settings ->
            Off settings

        Off settings ->
            On settings


type alias AutoplaySettings =
    { audio : Bool
    , withoutWifi : Bool
    }


model : Model
model =
    { email = False
    , autoplay = Off { audio = False, withoutWifi = False }
    , location = False
    }


view : Model -> Html Msg
view { email, autoplay, location } =
    div []
        [ h2 [] [ text "Settings" ]
        , fieldset []
            [ checkbox email ToggleEmail "Email Notifications" False
            , viewAutoplay autoplay
            , checkbox location ToggleLocation "Use Location" False
            ]
        ]


viewAutoplay : Autoplay -> Html Msg
viewAutoplay autoplay =
    case autoplay of
        On settings ->
            div []
                [ checkbox True ToggleAutoplay "Video Autoplay" False
                , viewAutoplaySettings settings False
                ]

        Off settings ->
            div []
                [ checkbox False ToggleAutoplay "Video Autoplay" False
                , viewAutoplaySettings settings True
                ]


viewAutoplaySettings : AutoplaySettings -> Bool -> Html Msg
viewAutoplaySettings { audio, withoutWifi } isDisabled =
    div [ style [ ( "margin-left", "20px" ) ] ]
        [ checkbox audio ToggleAudio "Audio" isDisabled
        , checkbox withoutWifi ToggleNoWifi "WithoutWifi" isDisabled
        ]


checkbox : Bool -> msg -> String -> Bool -> Html msg
checkbox isChecked msg description isDisabled =
    label [ style [ ( "display", "block" ) ] ]
        [ input [ type_ "checkbox", checked isChecked, onClick msg, disabled isDisabled ] []
        , text description
        ]


type Msg
    = ToggleEmail
    | ToggleAutoplay
    | ToggleLocation
    | ToggleAudio
    | ToggleNoWifi


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleEmail ->
            { model | email = not model.email }

        ToggleLocation ->
            { model | location = not model.location }

        ToggleAutoplay ->
            { model | autoplay = toggleAutoplay model.autoplay }

        ToggleAudio ->
            case model.autoplay of
                On settings ->
                    let
                        { audio, withoutWifi } =
                            settings
                    in
                        { model | autoplay = On { audio = audio, withoutWifi = withoutWifi } }

                _ ->
                    model

        _ ->
            model


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
