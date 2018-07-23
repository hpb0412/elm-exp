module Questions exposing (History, Question, back, forward, init, questions, toHtml)

import Html exposing (..)


type alias Question =
    { prompt : String
    , response : Maybe String
    }


type ZipList a
    = ZipList
        { previous : List a
        , current : a
        , remaining : List a
        }


type alias History =
    ZipList Question


last : List a -> Maybe a
last =
    {--ref: https://www.reddit.com/r/elm/comments/4j2fg6/finding_the_last_list_element/ --}
    List.foldl (Just >> always) Nothing


back : History -> History
back ((ZipList { previous, current, remaining }) as history) =
    if List.isEmpty previous then
        history
    else
        ZipList
            { previous = List.take (List.length previous - 1) previous
            , current =
                case last previous of
                    Just value ->
                        value

                    Nothing ->
                        current
            , remaining = current :: remaining
            }


forward : History -> History
forward ((ZipList { previous, current, remaining }) as history) =
    if List.isEmpty remaining then
        history
    else
        ZipList
            { previous = List.append previous [ current ]
            , current =
                case List.head remaining of
                    Just value ->
                        value

                    Nothing ->
                        current
            , remaining =
                case List.tail remaining of
                    Just value ->
                        value

                    Nothing ->
                        remaining
            }


init : Question -> List Question -> History
init first remaining =
    ZipList { previous = [], current = first, remaining = remaining }


questions : History -> List Question
questions (ZipList { previous, current, remaining }) =
    remaining
        |> (::) current
        |> List.append previous



-- List.append previous <| (current :: remaining)


toHtml : History -> Html msg
toHtml (ZipList { previous, current, remaining }) =
    div []
        [ ul [] <|
            List.map questionToHtml previous
        , questionToHtml current
        , ul [] <|
            List.map questionToHtml remaining
        ]


questionToHtml : Question -> Html msg
questionToHtml { prompt } =
    li [] [ text prompt ]
