# frozen_string_literal: true

%w[table cell json_manager printer].each { |file| require_relative file }

class Gol
  @@EXIT_WORDS = %w[quit q exit]

  def initialize
    @json_manager = JsonManager.new
    @gen = 0
    run
  end

  private

  # Checks whether a "config.json" file exists
  # Runs a prompt if it does
  # Starts a new game if it doesn't
  def run
    Printer.greet

    start_fresh unless File.file?('config.json')
    loop do
      prompt
    end
  end

  # Prompts the user to start a new game or read from "config.json"
  def prompt
    loop do
      Printer.options
      get_input
      case @input.downcase
      when '1'
        start_fresh
      when '2'
        start_from_json
      when '3', *@@EXIT_WORDS
        puts 'Goodbye'
        exit
      else
        puts "\nInvalid choice, try again.\n"
      end
    end
  end

  # Collects user input and writes to "config.json"
  def start_fresh
    Printer.fresh_intro
    Printer.enter_size

    loop do
      @size = validate(get_input, 10, 40)
      break if @size
    end

    generate_board

    Printer.enter_gens

    loop do
      @max_gen = validate(get_input, 10, 100)
      break if @max_gen
    end

    @json_manager.write(@size, @max_gen)

    start_game
  end

  # Reads table parameters from "config.json"
  def start_from_json
    Printer.json_intro

    json = @json_manager.read
    @size = json['size'].to_i

    generate_board

    @max_gen = json['gens'].to_i

    start_game
  end

  # Starts the game
  # Applies the rules
  # Prints generations and boards
  def start_game
    @gen = 0
    @max_gen.times do
      @gen += 1
      Printer.current_gen(@gen)
      @board.apply_rules
      @board.print_table
      sleep 1
    end
  end

  def get_input
    print '> '
    @input = gets.chomp
  end

  # Validates user input
  # Returns a valid integer
  def validate(input, min, max)
    if @@EXIT_WORDS.include?(input.downcase)
      puts 'Goodbye'
      exit
    end
    catch :size_err do
      throw :size_err, puts("\nInvalid input\n") unless input.to_i >= min && input.to_i <= max
      return input.to_i
    end
    puts "\nPlease enter a number between #{min} and #{max}\n\n"
    false
  end

  def generate_board
    @board = Table.new @size
  end
end
