class Morse
    @morse = {
        A: '.-',
        B: '-...',
        C: '-.-.',
        D: '-..',
        E: '.',
        F: '..-.',
        G: '--.',
        H: '....',
        I: '..',
        J: '.---',
        K: '-.-',
        L: '.-..',
        M: '--',
        N: '-.',
        O: '---',
        P: '.--.',
        Q: '--.-',
        R: '.-.',
        S: '...',
        T: '-',
        U: '..-',
        V: '...-',
        W: '.--',
        X: '-..-',
        Y: '-.--',
        Z: '--..',
        N1: '.----',
        N2: '..---',
        N3: '...--',
        N4: '....-',
        N5: '.....',
        N6: '-....',
        N7: '--...',
        N8: '---..',
        N9: '----.',
        N0: '-----'
    }

    def self.encode(input)
        result = ""
        input.upcase!
        input.size.times do |i|
            if input[i].ord >= 65 and input[i].ord <= 90
                result.concat(@morse[input[i].to_sym]).concat(" ")
            elsif input[i].ord >= 48 and input[i].ord <= 57
                result.concat(@morse[("N" + input[i]).to_sym]).concat(" ")
            elsif input[i].ord == 32
                result.concat(" ")
            else
                result.concat(input[i])
            end
        end
        result = result[0...-1]
        return result
    end

    def self.decode(input)
        result = ""
        inputLetterArray = []
        inputWordArray = input.split('  ')
        inputWordArray.each do |i|
            inputLetterArray = inputWordArray.map {|i| i.split(' ')}
        end
        inputLetterArray.each do |i|
            i.each do |j|
                begin
                    result.concat(@morse.invert[j].to_s[-1])
                rescue
                    result.concat(" ")
                end
            end
            result.concat(" ")
        end
        return result
    end

    def self.read_file(filename)
        file = File.open(filename, "r")
        my_data = file.read
        file.close
        return my_data
    end

    def self.write_file(filename, input)
        file = File.open(filename, "w")
        file.puts input
        file.close
    end
end

if ARGV[0] == 'encode' and ARGV[1] == 'preamble'
    begin
        preamble = Morse.read_file("preamble.txt")
        encoded = Morse.encode(preamble)
        Morse.write_file("preamble_encoded.txt", encoded)
    rescue
        puts "File not found. Make sure <preamble.txt> is in the directory"
    end
elsif ARGV[0] == 'decode' and ARGV[1] == 'preamble_encoded'
    begin
        encoded = Morse.read_file("preamble_encoded.txt")
        preamble = Morse.decode(encoded)
        Morse.write_file("preamble_decoded.txt", preamble)
    rescue
        puts "File not found. Make sure <preamble_encoded.txt> is in the directory"
    end
else
    puts "Incorrect syntax. Please enter either <morse encode preamble> or <morse decode preamble_encoded>"
end