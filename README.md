# Memory Match 2
Console version of the classic [Memory Match][wiki].
[wiki]: https://en.wikipedia.org/wiki/Concentration_(game)

Memory Match 2 is a single player console game

## Playing the Game

1. Clone the repo.
2. From the console,within the repo directory, run `ruby game.rb`.
3. Difficulty can be specified after the filename. Valid inputs are `easy`, `med`, `hard`.
4. Try to match all the pairs. To guess, a card on the board can be specified with it's row, col numbers.

## About the Game
Memory Match 2 is a object oriented project, with each component within the game representing it's own ruby class.

### `game.rb`
Maintains game state and controls players turns.

### `board.rb`
Maintains board state, can determine winning state.

### `card.rb`
Holds the card value.

### `player.rb`
Provides player interaction logic like prompts and receiving player guesses.
