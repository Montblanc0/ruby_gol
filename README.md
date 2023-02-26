# Game of Life (Ruby Project)

My implementation of John Conway's [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life "Game of Life").

This project was made with Ruby v3.0.2.


## Game Instructions

This game follows the [original rules](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Rules) but also adds a "Pac-Man Effect" on every border.

To play the game, simply run `ruby start.rb` and enter your desired **size** (from 10 to 40) and **maximum number of generations** to process (from 10 to 100). These settings will be automatically stored in a `config.json` file in the root of the game.

Starting from Generation 1, a new generation is created and printed every second.

Once the game reaches the maximum number of generations, you will be prompted to start a new game by providing a new size and maximum number of generations, or to read the settings from the configuration file.

The next time you run `ruby start.rb`, if a `config.json` file is present at the specified path, you will be immediately prompted to read from it or to start a new game.

Please note that this version does not check for still life and does not store the current state of the board.