module Turing where

data Direction  = MLeft | MRight | MStay
type State      = Int
type Symbol     = Char
type Smt        = (State, Symbol, Direction)
type Tape       = [Char]
type TapeParts  = (Tape, Symbol, Tape)
data Machine    = Machine {
    init_state   :: State,
    function     :: State -> Symbol -> Smt,
    accept_state :: State
}
data MacState   = MacState {
    state :: State,
    tape  :: TapeParts
}

instance Show MacState where
    show (MacState a (x, y, z)) = x ++ " q_" ++ show a ++ " " ++ [y] ++ z ++ "\n"

moveTape :: TapeParts -> Direction -> TapeParts
moveTape ([], b, c) MLeft  = ([]      , '_'   , b :  c)
moveTape (a, b, []) MRight = (a ++ [b], '_'   , []    )
moveTape (a, b, c)  MLeft  = (init a  , last a, b :  c)
moveTape (a, b, c)  MRight = (a ++ [b], head c, tail c)

step :: Machine -> TapeParts -> [MacState] -> [MacState]
step (Machine q0 f qf) (a, b, c) mac
    | q0 == qf  = mac ++ [MacState {state = q0, tape = (a, b, c)}]
    | otherwise = let (x, y, z) = f q0 b in
        step (Machine x f qf) (case z of
            MLeft  -> moveTape (a, y, c) MLeft
            MRight -> moveTape (a, y, c) MRight
            MStay  -> (a, y, c)) (
        mac ++ [MacState {state = q0, tape = (a, b, c)}])

run :: Machine -> Tape -> [MacState]
run m t = step m ([], head t, tail t) []

testMachine :: Machine
testMachine = Machine {
    init_state   = 0,
    function     = t,
    accept_state = 30
} where
    t 0  '1' = (1,  '_', MRight)
    t 0  '0' = (20, '_', MRight)
    t 1  '1' = (1,  '1', MRight)
    t 1  '0' = (2,  '0', MRight)
    t 2  '1' = (2,  'b', MRight)
    t 2  '_' = (3,  '_', MLeft)
    t 3  'b' = (3,  'b', MLeft)
    t 3  '1' = (3,  '1', MLeft)
    t 3  '0' = (4,  '0', MRight)
    t 3  'a' = (4,  'a', MRight)
    t 4  'b' = (5,  'a', MRight)
    t 4  '1' = (6,  'b', MRight)
    t 5  'b' = (5,  'b', MRight)
    t 5  '_' = (3,  '1', MLeft)
    t 6  '1' = (6,  'b', MRight)
    t 6  '_' = (7,  '_', MLeft)
    t 7  'a' = (7,  'a', MLeft)
    t 7  'b' = (7,  'b', MLeft)
    t 7  '0' = (8,  '0', MLeft)
    t 8  '1' = (8,  '1', MLeft)
    t 8  '_' = (0,  '_', MRight)
    t 20 'a' = (20, '1', MRight)
    t 20 'b' = (20, '_', MRight)
    t 20 '_' = (30, '_', MStay)
    t 5  '1' = (5,  '1', MRight)
    t 2  'a' = (2,  'a', MRight)
    t 2  'b' = (2,  'b', MRight)
  