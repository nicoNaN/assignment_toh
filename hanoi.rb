class TowerOfHanoi
  
  # initiliazing everything we need
  def initialize( blocks )
    @blocks = blocks
    @board = [blocks,0,0]
    @has_won = false
    @blocks_one, @blocks_two, @blocks_three = Array.new(3) { [] }
    @all_blocks = [@blocks_one, @blocks_two, @blocks_three]
  end

  # printing the instructions at the beginning
  def instructions
    puts ""
    puts "Welcome to Tower of Hanoi!"
    puts "Instructions:"
    puts "Enter where you'd like to move from and to"
    puts "in the format [1,3]. Enter 'q' to quit."
    puts ""
  end
  
  # filling position 1 with however many blocks were passed by user
  def block_init( blocks_one )
    @blocks.downto(1) do |i|
      @blocks_one << i
    end
  end
  
  # checks to see if 3 blocks are stacked in the third position
  def determine_win( board )
    if @board[2] == @blocks
      @has_won = true
    end
  end
  
  # prompts user for their move, passes input to check validity
  # if input is not, tells user and quits
  # if nputt is valid, passes the move to check validity
  def move_prompt
    puts "Your move?"
    puts ">"
    from_to = gets.chomp
    if from_to == "q"
      exit
    else
      from_to = from_to.split(",")
      input_error_checking( from_to )
      from_to = from_to.map(&:to_i)
      fix_move_positions( from_to )
      move_error_checking( from_to )
    end
  end
  
  # fixes move indexes
  def fix_move_positions( from_to )
    from_to.map! { |i| i -= 1 }
  end
  
  # checks for errors in move input formatting
  def input_error_checking( from_to )
    if from_to.length < 2 || from_to.length > 2
      puts "Wrong number of moves! Please try again."
      exit
    end
    from_to.each do |i|
      if i == "0"
        puts "You entered 0 for a to or from position! Please try again."
        exit
      elsif i.to_i == 0 
        puts "You entered a non-integer! Please try again."
        exit
      end
    end
  end
  
  # checks for errors in the actual move
  def move_error_checking( from_to )
    move_block_check = @all_blocks[from_to[0]][@all_blocks[from_to[0]].length - 1]
    if @all_blocks[from_to[0]].empty?
      puts ""
      puts "Tried to move from position with no blocks!"
      puts ""
    elsif !@all_blocks[from_to[1]].empty? && move_block_check > @all_blocks[from_to[1]][0]
      puts ""
      puts "Can't do that!"
      puts ""
    else
      move_block( from_to )
    end
  end
  
  # moves the block if it is valid
  def move_block( from_to )
    move_block = @all_blocks[from_to[0]].pop
    @board[from_to[0]] -= 1
    @board[from_to[1]] += 1
    @all_blocks[from_to[1]].push(move_block)
    determine_win( @board )
  end
  
  # prints out the current state of the board
  def render
    puts ""
    puts "Current board:"
    puts ""
    count = @blocks 
    while count >= 0
    	puts "o" * nil_check(@blocks_one[count]) + "\t" + "o" * nil_check(@blocks_two[count]) + "\t" + "o" * nil_check(@blocks_three[count])
    	count -= 1
  	end
  	puts ""
  	puts "One\tTwo\tThree"
    puts ""
  end
  
  # check if we're trying to display a block where there isn't one
  # if so, print 'o' zero times, effectively making that space blank
  def nil_check ( block )
	  if block == nil
	   return 0 
	  else 
	    return block
	  end
  end
  
  # main loop for the game
  def play
    block_init( @blocks_one )
    instructions
    while !@has_won
      render
      move_prompt
      if @has_won
        render
        puts "You won!"
        puts ""
      end
    end
  end
  
end

t = TowerOfHanoi.new(4)
t.play