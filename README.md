# Pebbles

Pebbles is a language with 4 pebbles and an infinite beach.

## Interpretation

Pebble is read left to right with certain characters performing certain actions.

## Memory

Pebble's memory is an infinte tape of ones and zeros extending in both directions.

Exactly 4 cells on the tape will be on at any point, never more, never less.

There is a read head that is always positioned between two adjacent cells

## Commands

- `]` Move the read head right

- `[` Move the read head left

- `>` Add the bit to the right to the output

- `<` Add the bit to the left to the output

- `~` Switch the bit to the left with the bit to the right

- `_(` Begin loop, `_` represents a predicate

- `)` End loop

## Loops

A loop will be entered if the two bit adjacent to the read head *fails* to meet a predicate.
A loop will be run repeatedly until the predicate is failed on a `)`.

## Predicates

- `&` performs logical and on the two bits

- `|` performs logical or on the two bits

- `^` performs logical xor on the two bits

- `!_` negates the next predicate

## Running Pebbles

Currently Pebbles can be called in interactive mode using:

    $ ghci Pebbles.hs

To run a program call the function `pebble` with the source as an argument. Example:

    Prelude> pebble "[[<>"
