require "date"

class Holiday
    def printHoliday()
        if self.instance_of? FixedHoliday
            date = Date.new(@year, @month, @day)
            puts "#{@name} is on " + date.strftime("%A, %B, %d, %Y")
        elsif self.instance_of? MovingHoliday
            correctDay = false
            test_date = Date.new(@year, @month, 1)
            while !correctDay
                if test_date.send("#{@dayOfWeek}?")
                    correctDay= true
                    test_date += 7*(@weekInstance-1)
                    date = test_date.clone
                    puts "#{@name} is on " + date.strftime("%A, %B, %d, %Y")
                else
                    test_date += 1
                end
            end
        end
    end
end

class FixedHoliday < Holiday
    def initialize(name, month, day, year)
        @name = name
        @month = month
        @day = day
        @year = year
    end
end

class MovingHoliday < Holiday
    def initialize(name, month, dayOfWeek, weekInstance, year)
        @name = name
        @month = month
        @dayOfWeek = dayOfWeek
        @weekInstance = weekInstance
        @year = year
    end
end

print "Enter a year => "
year = gets.chomp
year = year.to_i

new_years_day = FixedHoliday.new("New Year's Day", 1, 1, year)
independence_day = FixedHoliday.new("Independence Day", 7, 4, year)
halloween = FixedHoliday.new("Halloween", 10, 31, year)
mothers_day = MovingHoliday.new("Mother's Day", 5, "sunday", 2, year)
fathers_day = MovingHoliday.new("Father's Day", 6, "sunday", 3, year)
thanksgiving = MovingHoliday.new("Thanksgiving", 11, "thursday", 4, year)

new_years_day.printHoliday
independence_day.printHoliday
halloween.printHoliday
mothers_day.printHoliday
fathers_day.printHoliday
thanksgiving.printHoliday
