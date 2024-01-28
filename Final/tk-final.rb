require 'tk'
require 'json'
require 'httparty' #gem install/uninstall httparty

class TkFinal
    def initialize
        begin
            @page = HTTParty.get(@url)
        rescue
            @url = 'https://api.openweathermap.org/data/2.5/forecast?q=Salt+Lake+City,us&units=imperial&appid=4d399dd2f89e04d7a461815f8f2d3f79'
            @page = HTTParty.get(@url)
        ensure
            @weatherData = JSON.parse(@page.body)
        end

        begin
            file = File.open("toDo.txt", "r")
            file.close()
        rescue
            createTXT()
        end

        @root = TkRoot.new do
            title "Ruby Final"
            minsize(320, 240)
            maxsize(320, 240)
        end

        @tabs = Tk::Tile::Notebook.new(@root) do
            pack(side: 'top')
        end
        @tab1 = Tk::Tile::Frame.new(@tabs)
        @tab2 = Tk::Tile::Frame.new(@tabs)
        @tabs.add @tab1, :text => 'To-Do List'
        @tabs.add @tab2, :text => 'Weather Forecast'

        #To-Do List Tab------------------------------

        @tab1_frame_top = TkFrame.new(@tab1)
        @tab1_frame_bottom = TkFrame.new(@tab1)
        @tab1_frame_top.pack(side: 'top')
        @tab1_frame_bottom.pack(side: 'top')

        @tab1_entry_input = TkEntry.new(@tab1_frame_top) do
            width 50
        end

        addEntry = proc do
            data = readTXT
            newNote = @tab1_entry_input.value
            data << newNote
            writeTXT(data)
            @tab1_entry_input.delete(0, "end")
            @tab1_listbox_notes.delete(0, "end")
            printNotes()
        end

        @tab1_btn_add = TkButton.new(@tab1_frame_top) do
            text "Add"
            command addEntry
        end

        editEntry = proc do
            data = readTXT
            dataArray = data.split("\n")
            begin
                selectedIndex = @tab1_listbox_notes.curselection()[0]
                editNote = @tab1_entry_input.value
                dataArray.slice! (selectedIndex)
                dataArray.insert(selectedIndex,editNote)
                writeTXT(dataArray)
                @tab1_entry_input.delete(0, "end")
                @tab1_listbox_notes.delete(0, "end")
                printNotes()
            rescue
                return
            end
        end

        @tab1_btn_edit = TkButton.new(@tab1_frame_top) do
            text "Edit"
            command editEntry
        end

        deleteEntry = proc do
            data = readTXT
            dataArray = data.split("\n")
            begin
                selectedIndex = @tab1_listbox_notes.curselection()[0]
                editNote = @tab1_entry_input.value
                dataArray.slice! (selectedIndex)
                writeTXT(dataArray)
                @tab1_listbox_notes.delete(0, "end")
                printNotes()
            rescue
                return
            end
        end

        @tab1_btn_delete = TkButton.new(@tab1_frame_top) do
            text "Delete"
            command deleteEntry
        end

        listHelp = proc do
            instructions = %q{
                Add: Insert text into textbox at top, then press Add to add it to the bottom of the list
                Edit: Insert text into textbox at top, then press Edit with the desired item selected to edit that item
                Delete: Selected desired item, then press Delete to delete that item from the list
            }
            begin
                $helpWindow.destroy
            rescue
            end
            $helpWindow = TkToplevel.new do
                title "To-Do List Help"
            end
            TkLabel.new($helpWindow) do
                text instructions
                pack(side: 'top')
            end
            TkButton.new($helpWindow) do
                text "Close"
                command "$helpWindow.destroy()"
                pack(side: 'top')
            end
        end

        @tab1_btn_help = TkButton.new(@tab1_frame_top) do
            text "Help"
            command listHelp
        end

        @tab1_entry_input.pack(side: 'top')
        @tab1_btn_add.pack(side: 'left')
        @tab1_btn_edit.pack(side: 'left')
        @tab1_btn_delete.pack(side: 'left')
        @tab1_btn_help.pack(side: 'left')

        @tab1_listbox_notes = TkListbox.new(@tab1_frame_bottom) do
            width 50
            pack(side: 'top')
        end

        printNotes()
        
        # Weather Forecast Tab-----------------------
        
        currentDate = @weatherData['list'][0]['dt_txt']
        currentDateTemp = @weatherData['list'][0]['main']['temp']
        currentDateDescription = @weatherData['list'][0]['weather'][0]['description']

        datePlusOne = @weatherData['list'][8]['dt_txt']
        datePlusOneTemp = @weatherData['list'][8]['main']['temp']
        datePlusOneDescription = @weatherData['list'][8]['weather'][0]['description']

        datePlusTwo = @weatherData['list'][16]['dt_txt']
        datePlusTwoTemp = @weatherData['list'][16]['main']['temp']
        datePlusTwoDescription = @weatherData['list'][16]['weather'][0]['description']

        datePlusThree = @weatherData['list'][24]['dt_txt']
        datePlusThreeTemp = @weatherData['list'][24]['main']['temp']
        datePlusThreeDescription = @weatherData['list'][24]['weather'][0]['description']

        datePlusFour = @weatherData['list'][32]['dt_txt']
        datePlusFourTemp = @weatherData['list'][32]['main']['temp']
        datePlusFourDescription = @weatherData['list'][32]['weather'][0]['description']

        @tab2_frame_top = TkFrame.new(@tab2)
        @tab2_frame_bottom = TkFrame.new(@tab2)
        @tab2_frame_top.pack(side: 'top')
        @tab2_frame_bottom.pack(side: 'top')

        @tab2_label_cityEntry = TkLabel.new(@tab2_frame_top) do
            text "Enter US City: "
        end
        @tab2_entry_city = TkEntry.new(@tab2_frame_top)

        changeCity = proc do
            newCity = @tab2_entry_city.value
            newCity.strip!
            cityUrl = newCity.tr(" ", "+")
            @url = "https://api.openweathermap.org/data/2.5/forecast?q=" + cityUrl + ",us&units=imperial&appid=4d399dd2f89e04d7a461815f8f2d3f79"
            begin
                @page = HTTParty.get(@url)
                @weatherData = JSON.parse(@page.body)
                newCurrentDate = @weatherData['list'][0]['dt_txt']
                newCurrentDateTemp = @weatherData['list'][0]['main']['temp']
                newCurrentDateDescription = @weatherData['list'][0]['weather'][0]['description']

                newDatePlusOne = @weatherData['list'][8]['dt_txt']
                newDatePlusOneTemp = @weatherData['list'][8]['main']['temp']
                newDatePlusOneDescription = @weatherData['list'][8]['weather'][0]['description']

                newDatePlusTwo = @weatherData['list'][16]['dt_txt']
                newDatePlusTwoTemp = @weatherData['list'][16]['main']['temp']
                newDatePlusTwoDescription = @weatherData['list'][16]['weather'][0]['description']

                newDatePlusThree = @weatherData['list'][24]['dt_txt']
                newDatePlusThreeTemp = @weatherData['list'][24]['main']['temp']
                newDatePlusThreeDescription = @weatherData['list'][24]['weather'][0]['description']

                newDatePlusFour = @weatherData['list'][32]['dt_txt']
                newDatePlusFourTemp = @weatherData['list'][32]['main']['temp']
                newDatePlusFourDescription = @weatherData['list'][32]['weather'][0]['description']

                @tab2_label_cityName.text = newCity
                @tab2_label_currentDate.text = "#{newCurrentDate}: #{newCurrentDateTemp}°F - #{newCurrentDateDescription}"
                @tab2_label_datePlusOne.text = "#{newDatePlusOne}: #{newDatePlusOneTemp}°F - #{newDatePlusOneDescription}"
                @tab2_label_datePlusTwo.text = "#{newDatePlusTwo}: #{newDatePlusTwoTemp}°F - #{newDatePlusTwoDescription}"
                @tab2_label_datePlusThree.text = "#{newDatePlusThree}: #{newDatePlusThreeTemp}°F - #{newDatePlusThreeDescription}"
                @tab2_label_datePlusFour.text = "#{newDatePlusFour}: #{newDatePlusFourTemp}°F - #{newDatePlusFourDescription}"
            rescue
                @tab2_label_cityName.text = ""
                @tab2_label_currentDate.text = "Unrecognized City. Please enter a valid US city."
                @tab2_label_datePlusOne.text = ""
                @tab2_label_datePlusTwo.text = ""
                @tab2_label_datePlusThree.text = ""
                @tab2_label_datePlusFour.text = ""
            end
            @tab2_entry_city.delete(0, "end")
        end

        @tab2_btn_submit = TkButton.new(@tab2_frame_top) do
            text "Submit"
            command changeCity
        end
        @tab2_label_cityEntry.pack(side: 'left')
        @tab2_entry_city.pack(side: 'left')
        @tab2_btn_submit.pack(side: 'left')

        @tab2_label_cityName = TkLabel.new(@tab2_frame_bottom) do
            text "Salt Lake City"
        end

        @tab2_label_currentDate = TkLabel.new(@tab2_frame_bottom) do
            text "#{currentDate}: #{currentDateTemp}°F - #{currentDateDescription}"
        end
        @tab2_label_datePlusOne = TkLabel.new(@tab2_frame_bottom) do
            text "#{datePlusOne}: #{datePlusOneTemp}°F - #{datePlusOneDescription}"
        end
        @tab2_label_datePlusTwo = TkLabel.new(@tab2_frame_bottom) do
            text "#{datePlusTwo}: #{datePlusTwoTemp}°F - #{datePlusTwoDescription}"
        end
        @tab2_label_datePlusThree = TkLabel.new(@tab2_frame_bottom) do
            text "#{datePlusThree}: #{datePlusThreeTemp}°F - #{datePlusThreeDescription}"
        end
        @tab2_label_datePlusFour = TkLabel.new(@tab2_frame_bottom) do
            text "#{datePlusFour}: #{datePlusFourTemp}°F - #{datePlusFourDescription}"
        end

        @tab2_label_cityName.pack(side: 'top')
        @tab2_label_currentDate.pack(side: 'top')
        @tab2_label_datePlusOne.pack(side: 'top')
        @tab2_label_datePlusTwo.pack(side: 'top')
        @tab2_label_datePlusThree.pack(side: 'top')
        @tab2_label_datePlusFour.pack(side: 'top')
    end

    def readTXT
        file = File.open('toDo.txt', 'r')
        existingData = file.read
        file.close()
        return existingData
    end

    def writeTXT(existingData)
        file = File.open('toDo.txt', 'w')
        file.puts existingData
        file.close()
    end

    def createTXT
        writeTXT([])
    end

    def printNotes
        data = readTXT()
        dataArray = data.split("\n")
        dataArray.each do |i|
            @tab1_listbox_notes.insert("end", i)
        end
    end
end

TkFinal.new
Tk.mainloop