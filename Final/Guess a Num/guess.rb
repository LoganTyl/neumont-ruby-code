whilePlaying = true
highScore = 10000000000
highScoreHolder = "the AI"

while whilePlaying
    correctGuess = false
    invalidNum = true
    counter = 1

    correctNum = 1 + rand(100)
    puts correctNum

    puts "Guess a number between 1 and 100, inclusive"
    while correctGuess == false
        while invalidNum
            print "Your Guess: "
            userGuess = gets.chomp
            userGuess = userGuess.to_i
            if userGuess > 100 or userGuess < 1
                puts "Out of range. Please give a guess between 1 and 100, inclusive"
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

            if counter < highScore
                puts "You got the high Score! Enter your name: "
                highScoreHolder = gets.chomp
                highScore = counter.dup
            end

            puts "Play again?(yes/no)"
            playAgain = gets.chomp
            if playAgain == "yes"
                puts "Okay. Current highest score is #{highScore}, held by #{highScoreHolder}"
            elsif playAgain == "no"
                whilePlaying = false
            end
        end
    end
end



    