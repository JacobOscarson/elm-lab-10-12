module Main exposing (main)

import Uuid
import Random.Pcg exposing (Seed, initialSeed, step)
import Html.App exposing (programWithFlags)
import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)


type alias Model =
    { currentSeed : Seed
    , currentUuid : Maybe Uuid.Uuid
    }


type Msg
    = NewUuid


regen curSeed =
    step Uuid.uuidGenerator curSeed


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewUuid ->
            let
                ( newUuid, newSeed ) =
                    regen model.currentSeed
            in
                ( { model
                    | currentUuid = Just newUuid
                    , currentSeed = newSeed
                  }
                , Cmd.none
                )


view : Model -> Html Msg
view model =
    let
        uuidText =
            case model.currentUuid of
                Nothing ->
                    "No Uuid was created so far"

                Just uuid ->
                    "Current Uuid: " ++ Uuid.toString uuid
    in
        div []
            [ button [ onClick NewUuid ] [ text "Create a new Uuid!" ]
            , text uuidText
            ]



{- this init function takes a tuple of two ints that are handed over
   in the initializiation code of our Elm app in the javascript code. It
   uses these JS random values as the initial seed.
-}


init : Int -> ( Model, Cmd Msg )
init seed =
    let
        firstSeed =
            initialSeed seed

        ( firstUuid, secondSeed ) =
            regen firstSeed

        initialModel =
            { currentSeed = secondSeed
            , currentUuid = Just firstUuid
            }
    in
        ( initialModel, Cmd.none )


main =
    programWithFlags
        -- using programWithFlags to get the seed values from JS
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
