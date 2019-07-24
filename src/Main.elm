module Main exposing (..)

import Browser
import Html exposing(div, text, button)
import Html.Events exposing(onClick)
import Html.Attributes exposing(disabled)

type alias Model = Int

type Msg
    = Increment
    | Decrement
    | Reset


view model =
    div []
      [ text(String.fromInt model)
      , button [ onClick Increment ] [ text "+" ]
      , button [ onClick Decrement ] [ text "-" ]
      , button [ onClick Reset ] [ text "Reset" ]

      ]

init =
    ( initialModel, Cmd.none )

update msg model =
    case msg of
        Increment -> 
            ( model+1, Cmd.none )
        Decrement ->
            if model == 0 then (model, Cmd.none) else (model - 1, Cmd.none)
        Reset ->
            (initialModel, Cmd.none)

initialModel = 0


main : Program () Model Msg
main =
    Browser.element
    { init = \_ -> init
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }
