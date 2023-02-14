class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5],  # Middle row
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    def input_to_index(input)
        return Integer(input) - 1
    end
    def move(index, token = "X")
        @board[index] = token
    end
    def position_taken?(index)
        return @board[index] != " "
    end
    def valid_move?(index)
        return index >= 0 && index <= 8 && !position_taken?(index)
    end
    def turn_count
        return @board.count{|token| token != " "}
    end
    def current_player
        return turn_count % 2 == 0 ? "X" : "O"
    end
    def turn
        puts "Please enter 1-9:"
        input = gets.strip
        begin
            index = input_to_index(input)
            if valid_move?(index)
                token = current_player
                move(index, token)
                display_board
            else
                binding.pry
                turn
            end
        rescue ArgumentError
            puts "Invalid input"
            turn
        end
    end
    def won?
        WIN_COMBINATIONS.each do |combo|
            if combo.all?{|index| @board[index] == "X"}
                return combo
            elsif combo.all?{|index| @board[index] == "O"}
                return combo
            end
        end
        return false
    end
    def full?
        return @board.all?{|token| token != " "}
    end
    def draw?
        return full? && !won?
    end
    def over?
        return won? || draw?
    end
    def winner
        if combo = won?
            return @board[combo[0]]
        end
    end
    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end