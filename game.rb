# frozen_string_literal: true

class TicTacToe
  def initialize(player1, player2)
    @board = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    @turn = 1
    @player1 = player1.capitalize
    @player2 = player2.capitalize
    @ended = false
    start_text
  end

  def play(num)
    return puts "Looks like the game has ended. To play agane, reset the game using '#.reset'" if @ended

    return puts "The board is full. '#.reset' to GO AGANE" if full?

    return puts "Number #{num} is unavailable. Please enter number from 1 to 9" if num > 9 || num < 1

    row = (num - 1) / 3
    col = (num - 1) % 3

    return puts "Square #{num} is already taken. Please try different one" if @board[row][col] != 0

    @board[row][col] = @turn
    print_board

    if won?
      @ended = true
      return puts "#{@player1} is the winner. '#.reset' to GO AGANE" if @turn == 1

      return puts "#{@player2} is the winner. '#.reset' to GO AGANE"

    end

    return puts 'Its a draw' if full?

    puts ''
    if @turn == 1
      puts "#{@player2}'s turn"
      @turn = 2
    else
      puts "#{@player1}'s turn"
      @turn = 1
    end
  end

  def reset(player1 = @player1, player2 = @player2)
    initialize(player1, player2)
  end

  private

  def start_text
    puts ''
    puts "Welcome #{@player1} and #{@player2} to the game of 'Tic Tac Toe'"
    puts ''
    puts 'The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row is the winner'
    puts 'To place a mark, pick a number from 1 to 9 corresponding to a square shown below'
    puts ''
    puts '  1  │  2  │  3  '
    puts '─────────────────'
    puts '  4  │  5  │  6  '
    puts '─────────────────'
    puts '  7  │  8  │  9  '
    puts ''
    puts "#{@player1} goes first"
    puts ''
  end

  def print_board
    puts ''
    @board.each_with_index do |row, i|
      curr = '     │     │     '
      row.each_with_index do |symbol, j|
        case symbol
        when 1
          curr[j * 6 + 2] = 'X'
        when 2
          curr[j * 6 + 2] = 'O'
        end
      end
      puts curr
      if i != 2
        puts '─────────────────'
      else
        puts ''
      end
    end
  end

  def won?
    # check rows
    @board.each do |r|
      return true if r[0] != 0 && r[0] == r[1] && r[0] == r[2]
    end

    # check columns
    @board.transpose.each do |c|
      return true if c[0] != 0 && c[0] == c[1] && c[0] == c[2]
    end

    # check diagonals
    if @board[1][1] != 0 && ((@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]) ||
                             (@board[2][0] == @board[1][1] && @board[1][1] == @board[0][2]))
      return true
    end

    false
  end

  def full?
    @board.flatten.all? { |symbol| symbol != 0 }
  end
end