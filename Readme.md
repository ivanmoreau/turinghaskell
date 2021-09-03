# Readme

Turing Machine in Haskell.

## Usage

```Haskell
run :: Machine -> Tape -> Tape
```
where machine is a Turing Machine defined by

```Haskell
data Machine    = Machine {
    init_state   :: State,
    function     :: State -> Symbol -> Smt,
    accept_state :: State
}
```

## Example

```Haskell
testMachine :: Machine
```

## Licence
GPL-v3