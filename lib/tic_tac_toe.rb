require 'pry'

class TicTacToe 

    attr_accessor :board
    attr_accessor :turn_count
    attr_accessor :current_player

    def initialize
        @board = [
            ' ',' ',' ',
            ' ',' ',' ',
            ' ',' ',' '
        ]
    end

    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5],  # Middle row
        [6,7,8], # Bottom row
        [0,4,8], #Diag 1
        [2,4,6], #Diag 2
        [0,3,6], #Left
        [1,4,7], #Middle 
        [2,5,8] #right 
    ]
      
    def display_board
        puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
        puts "---------"
        puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
        puts "---------"
        puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
    end

    def input_into_index(index)
        index.to_i - 1
    end

    def move(index, token)
       @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        if index.between?(0,8) && !position_taken?(index)
            true
        else
            false
        end
    end

    def turn_count
        @board.count { |position| position != " "}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "What is your move 1-9?"
        index = gets.chomp
        make_index = input_into_index(index)
        puts make_index
        if valid_move?(make_index)
            move(make_index, current_player)
            display_board()
        else 
            puts "Invalid Move, Try Again"
            turn()
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |combo|
            if @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] && position_taken?(combo[0])
                return combo
            end
        end
    end

    def full?
        @board.all? do |index|
            index != ' '
        end
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        # won? ? current_player : nil
        won? ? @board[won?[0]] : nil
    end

    def play
        turn until over? 
        puts won? ? "Congratulations #{winner}" : "Cat's Game!"
    end
end
