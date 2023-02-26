# frozen_string_literal: true

class Printer
  def self.greet
    puts "
####################################################################################
################################## GAME OF LIFE ####################################
####################################################################################

This is a Ruby implementation of Conway's Game of Life
(read more at https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life )\n"
  end

  def self.options
    puts "\nPlease, choose an option:

    1. Start a new game
    2. Use the configuration from \"config.json\"
    3. Quit
    "
  end

  def self.json_intro
    puts "\n
################################ READING JSON... ###################################
\n"
  end

  def self.fresh_intro
    puts "\n
#################################### NEW GAME ######################################
\n"
  end

  def self.enter_size
    puts "\nEnter a board size from 10 up to 40\n\n"
  end

  def self.enter_gens
    puts "\nHow many generations would you like to see?
Enter a number from 10 to 100\n\n"
  end

  def self.current_gen(gen)
    puts "\n### GENERATION #{gen} ###"
  end
end
