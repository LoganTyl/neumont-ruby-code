=begin
    cls = clear screen
    rmdir <name> = remove directory
    dir = show what is in directory
    mkdir <name> = make directory 
=end

puts "hello world"; # puts = println; "p" is shortcut for puts, but puts quotes around item
#---------------------------------#
print "name: "
name = gets.chomp
puts "Hello #{name}!"
#---------------------------------#
p "hiya"
x = "4. Hello World!"
puts x
#---------------------------------#
x=9
puts x
message = if x > 10
    "5. Hello World!"
    elsif x < 10
        "Another Option"
    else 
        "It's the end of the world"
    end
puts message
#---------------------------------#
x = "6. Hello World!"
y = x
y.upcase!   #same as y = y.upcase, but ! makes it permamnent
puts x
#---------------------------------#
x = "7. Hello World!"
y = x.clone
x.upcase!
puts y
#---------------------------------#
class MyClass
    def initialize
        puts "8. Hello World!"
    end
end
a_class = MyClass.new
#---------------------------------#
class WorldGreeter
    def set_my_number(my_number)
        @my_number = my_number  # @ makes a variable class-level
        say_hello
    end
    def say_hello
        puts @my_number.to_s + '. Hello World!' # to_s = to string; to_i = to int
    end
end
my_greeter = WorldGreeter.new
my_greeter.set_my_number(9)
#---------------------------------#
i = 10
while i <= 12
    my_greeter.set_my_number(i)
    i += 1
end
#---------------------------------#
i = 13
until i > 15
    my_greeter.set_my_number(i)
    i += 1
end
#---------------------------------#
for i in 16..19 # two dots makes the last digit inclusive, three dots makes the last digit exclusive
    my_greeter.set_my_number(i)
end
#---------------------------------#
array = [20, 21, 22]
array.each do |i|   # not abs value; "takes whatever is being done and puts it in i"
    my_greeter.set_my_number(i)
end
#---------------------------------#
i = 23
loop do
    my_greeter.set_my_number(i)
    i += 1
    break if i >= 26
end
#---------------------------------#
26.upto( 29 ) do |i|    # inclusive
    my_greeter.set_my_number(i)
end
#---------------------------------#
30.step(32,1) do |i|    #inclusive; negatives work too for steps
    my_greeter.set_my_number(i)
end
#---------------------------------#
i = 33
5.times do
    my_greeter.set_my_number(i)
    i += 1
end
puts
#---------------------------------#
name = "Jimmy Joe Bob"

puts name[1]
puts name[3,5]  # starts at index 3, grabs 5 characters
puts name["Joe"]
puts name["Joe"] = "Bubba"

puts "Freddy B"["edd"]  # returns string in bracket if bracket-string is in the initial string

puts name*2
#---------------------------------#
my_array = ["Harry", 15, true]

my_array.each do |x|
    print "#{x} "   # variable interpolation
end
puts
#---------------------------------#
my_2d_array = [["Bob", 26, false], ["Sally", 24, true]]

my_2d_array.each do |x|
    print "#{x} "
    x.each do |y|
        print "#{y} "
    end
    puts
end
#---------------------------------#
arr = []
arr = Array.new(3) {"abc"}
arr[1].upcase!
print arr
puts
arr2 = %w(I really\ love\ working with Ruby)    # puts each word in an element of an array, backslash+whitespace connects the words
print arr2
puts
#---------------------------------#
require "date"    # ruby's form of import

a = Date.new(2018, 4, 23)
b = 3
puts a
puts "Hello, it's " + a.strftime("%A, %B, %d, %Y")   #Monday, April 23, 2018
#string format time; A=Day of Week, a=Day of Week Abrv. B=Month, d=Day, Y=Year, y=Last 2 Digits of Year
puts "It has been " + b.to_s + " days since our last accident."
#---------------------------------#
hi_score = [["1000", "Jane"], ["800", "Sally"]]
filename = "data.txt"
file = File.open(filename, "w") # overwrites what's in file, use append to add on
file.puts hi_score.join(", ")
file.close      # "type data.txt" in terminal: prints what's in file

file = File.open(filename, "r")
my_data = file.read
puts my_data
file.close
#---------------------------------#
H = Hash["a" => 100, "b" =>200]

puts "#{H['a']}"
puts "#{H['b']}"

grades = { "Jane Doe" => 10, "Jim Doe" => 6 }
options = { :font_size => 10, :font_family => "Arial" }
options = { font_size: 10, font_family: "Arial" } # both options are identical, regardless of colon placement; second more natural
puts options[:font_size]
#---------------------------------#
class Dog
    # @@ = Class variable
    @@dogcount = 0

    def initialize(breed, name)
        # @ = Instance Variables
        @breed = breed
        @name = name
        @@dogcount += 1
        puts "I am a Dog: #{@name}, #{@breed}, dogcount: #{@@dogcount}"
    end

    def self.count
        @@dogcount
    end

    def bark
        puts "Ruff! Ruff!"
    end

    def display
        puts "I am of #{@breed} breed and my name is #{@name}"
    end

    def age=(age)
        @age = age
    end

    def age
        @age
    end

    def name=(name)
        @name = name
    end

    def name
        @name
    end
end

d1 = Dog.new('Labrador', 'Benzy')
d1.age = 5

d2 = Dog.new('German Shepherd', 'Champ')
d2.age = 3

d3 = Dog.new('Poodle', 'Miffy')
d3.age = 4

puts "d1: #{d1.name}, #{d1.age}"
puts "d2: #{d2.name}, #{d2.age}"
puts "d3: #{d3.name}, #{d3.age}"

puts "total dog count: #{Dog.count}"

d1.bark  
d1.display

d1 = d2
d2.display

d1 = nil  
d1.display

d2 = nil
d3 = nil
#---------------------------------#
class Box
    def initialize(w, h)
        @width, @height = w, h
    end
    
    def getArea
        @width * @height
    end
end

class BigBox < Box # BigBox inherits from Box
    def printArea
        @area = @width * @height
        puts "Big box area is : #{@area}"
    end
end

box = BigBox.new(10,20)
box.printArea()
#---------------------------------#
# comment out everything else to run this example
puts "abc"

puts ARGV[0]
puts ARGV[1]
#---------------------------------#

