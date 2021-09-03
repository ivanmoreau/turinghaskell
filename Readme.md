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

```bash
*Main> run testMachine ['1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1']
"_________1111111111111111111111111111111111111111111111111111111111111111_________"
*Main> 
```

## Licence
GPL-v3