module SelectedFruits exposing (SelectedFruits, empty, insert, remove, member)


type SelectedFruits
    = SelectedFruits Int (List String)


empty : Int -> SelectedFruits
empty maxSize =
    SelectedFruits maxSize []


insert : String -> SelectedFruits -> SelectedFruits
insert fruit (SelectedFruits maxSize list) =
    SelectedFruits maxSize <|
        List.take maxSize (fruit :: list)


remove : String -> SelectedFruits -> SelectedFruits
remove fruit (SelectedFruits maxSize list) =
    SelectedFruits maxSize <|
        List.filter (\f -> f /= fruit) list


member : String -> SelectedFruits -> Bool
member fruit (SelectedFruits _ list) =
    List.member fruit list
