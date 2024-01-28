class HiScore
    def initialize
        @filename = "hiScore.txt"
        if File.exist?(@filename)
            read_file()
        else
            build_new()
        end
    end

    def show
        @my_data.each do |i|      
            puts "#{i[0]} #{i[1]}"
        end
    end

    def build_new #makes txt file too
        @my_data = [[1000,"--"],[1000,"--"],[1000,"--"],[1000,"--"],[1000,"--"]]
        file = File.open(@filename, "w")
        file.puts @my_data.join(",")
        file.close()
    end

    def read_file
        file = File.open(@filename, "r")
        @my_data = file.read
        file.close
        process_data()
    end

    def process_data
        @my_data = @my_data.split(",")
        @my_data = @my_data.each_slice(2).to_a
    end

    def check(scoreCheck)
        read_file()
        if scoreCheck < @my_data[4][0].to_i
            @placement = 5
            @my_data.reverse_each do |i|
                if scoreCheck < i[0].to_i
                    @placement -= 1
                end
            end
            add_name(scoreCheck, @placement)
        end
    end

    def add_name(score, placement)
        print "You got on the leaderboard! Enter your name: "
        @name = gets.chomp
        @new_array = [score, @name]
        # puts score
        # puts @name
        # puts @placement
        @my_data.insert(@placement, @new_array)
        @my_data.delete_at(5)
        write_file()
    end

    def write_file
        file = File.open(@filename, "w")
        file.puts @my_data.join(",")
        file.close 
    end
end

whilePlaying = true
HiScore.new()

while whilePlaying
    correctGuess = false
    invalidNum = true
    counter = 1

    correctNum = 1 + rand(1000)
    puts "Correct Answer: #{correctNum}"
    puts "Top 5 Scores"
    
    HiScore.new.show()

    puts "Guess a number between 1 and 1000, inclusive"
    while correctGuess == false
        while invalidNum
            print "Your Guess: "
            userGuess = gets.chomp
            userGuess = userGuess.to_i
            if userGuess > 1000 or userGuess < 1
                puts "Out of range. Please give a guess between 1 and 1000, inclusive"
            else
                invalidNum = false
            end
        end

        if userGuess > correctNum
            puts "Too high"
            counter += 1
            invalidNum = true
        elsif userGuess < correctNum
            puts "Too low"
            counter += 1
            invalidNum = true
        else
            correctGuess = true
            if counter == 1
                puts "You got it! It took you 1 try to get it."
            else
                puts "You got it! It took you #{counter} tries to get it."
            end

            HiScore.new.check(counter)


            puts "Play again?(yes/no)"
            playAgain = gets.chomp
            if playAgain == "no" or playAgain == "No" or playAgain == "n" or playAgain == "N"
                whilePlaying = false
            end
        end
    end
end

