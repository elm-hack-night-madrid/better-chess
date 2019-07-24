module Main exposing (..)

import Browser
import Html exposing(div, text, button, h1)
import Html.Events exposing(onClick)
import Html.Attributes exposing(disabled, style)
import Dict exposing(Dict)

type alias Model =
    { board: Board
    , currentPlayer: Player
    , selectedPosition: Maybe Position
    , gameState: GameState
    }

type alias Board = 
    Dict Position Piece

type alias Piece = (Figure, Player)

type alias Position = (Int, Int)

type Figure
    = Rook
    | Knight
    | Bishop
    | Queen
    | King
    | Pawn

type Player
    = White
    | Black

type GameState
    = Playing
    | Over

initialModel = 
    { board = initialBoard
    , currentPlayer = White
    , gameState = Playing
    , selectedPosition = Nothing
    }

initialBoard =
    Dict.fromList
    [ ((0,0), (Rook, Black))
    , ((0,1), (Knight, Black))
    , ((0,2), (Bishop, Black))
    , ((0,3), (Queen, Black))
    , ((0,4), (King, Black))
    , ((0,5), (Bishop, Black))
    , ((0,6), (Knight, Black))
    , ((0,7), (Rook, Black))
    , ((1,0), (Pawn, Black))
    , ((1,1), (Pawn, Black))
    , ((1,2), (Pawn, Black))
    , ((1,3), (Pawn, Black))
    , ((1,4), (Pawn, Black))
    , ((1,5), (Pawn, Black))
    , ((1,6), (Pawn, Black))
    , ((1,7), (Pawn, Black))
    -- Whites
    , ((6,0), (Pawn, Black))
    , ((6,1), (Pawn, Black))
    , ((6,2), (Pawn, Black))
    , ((6,3), (Pawn, Black))
    , ((6,4), (Pawn, Black))
    , ((6,5), (Pawn, Black))
    , ((6,6), (Pawn, Black))
    , ((6,7), (Pawn, Black))
    , ((7,0), (Rook, White))
    , ((7,1), (Knight, White))
    , ((7,2), (Bishop, White))
    , ((7,3), (King, White))
    , ((7,4), (Queen, White))
    , ((7,5), (Bishop, White))
    , ((7,6), (Knight, White))
    , ((7,7), (Rook, White))
    ]

type Msg
    = NoOp
    | ChoosePosition Position

view model =
    div []
      [ h1 [] [ text "Chess" ] 
      , div [ style "display" "inline-flex"
      , style "width" "100px"
              ] (boardView model.board)

      ]

boardView board =
    List.range 0 7
    |> List.map(\x -> 
        rowView x board
        )

rowView x board =
    div [] (List.range 0 7
    |> List.map(\y -> fieldView (x, y) board)
    )

fieldView position board = 
    let
        field = Dict.get position board
    in
    div 
    [ style "width" "20px"
    , style "height" "20px"
    , style "border" "1px solid black"
    ] [ text (fieldToSymbol field) ]

fieldToSymbol field =
    case field of
        Nothing -> ""
        Just (figure, player) -> figureToText figure

figureToText figure =
    case figure of
        Pawn -> "P"
        Rook -> "R"
        Knight -> "K"
        Bishop -> "B"
        Queen -> "Q"
        King -> "K"

init =
    ( initialModel, Cmd.none )

update msg model =
    case msg of
        NoOp ->
            (initialModel, Cmd.none)
        ChoosePosition newPosition ->
            case model.selectedPosition of
                Nothing -> ( { model | selectedPosition = Just newPosition }, Cmd.none )
                Just positionFrom -> (model, Cmd.none)

main : Program () Model Msg
main =
    Browser.element
    { init = \_ -> init
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }
