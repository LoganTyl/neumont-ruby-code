require 'tk'
require 'win32/sound'  # gem install win32-sound
include Win32

Frequency = 25
class TkDemo
  def initialize
    @x = 0
    # set up window
    # Tk.root.state = 'zoomed'
    root = TkRoot.new do
      title "Ruby Tk Example"
      background '#435'
      minsize(800,500)
      # maxsize(800,500)
    end
    
    # set up a frame on the top to hold things
    top_frame = TkFrame.new(root) do
      background '#635'
      padx 25 # adds padding so the frame is a little larger than the items that fill it
      pady 25
      grid(column: 1, row: 0)
    end

    # set up entry box
    @my_entry = TkEntry.new(top_frame, textvariable: @name) do
      font TkFont.new('times 15 bold')
      text "Enter something"
      pack(side: 'left')
    end

    # set up a button
    use_entry = proc do
      @label.text = 'My Label'
      @check_one.onvalue = @my_entry.value
      @check_one.offvalue = "Not " + @my_entry.value
      @check_one.text = @my_entry.value
      puts @my_entry.value
    end
    @btn0 = TkButton.new(top_frame) {
      text 'Click ME!'
      command use_entry
      pady 10
      pack(fill: 'x') # fills the 'x' of the frame but not the padding
    }
    
    # set up a frame on the side to hold things
    @left_frame = TkFrame.new(root) do
      background '#324'
      padx 25 # adds padding so the frame is a little larger than the items that fill it
      pady 25
      grid(column: 0, row: 1)

    end

    @right_frame = TkFrame.new(root) do
      background '#324'
      padx 25 # adds padding so the frame is a little larger than the items that fill it
      pady 25
      grid(column: 2, row: 1)

    end



    btn1_hit = proc do
      @combo_label.text = "You selected #{@combobox.value}"
      @left_frame.background = @combobox.value
    end

    @btn1 = TkButton.new(@left_frame) {
      # text 'Button 1'
      image TkPhotoImage.new(file: 'wasp.gif') # loading image of a wasp on button
      command btn1_hit
      pady 10
      pack(fill: 'x') # fills the 'x' of the frame but not the padding
    }
    


    @combo_label = TkLabel.new(@left_frame) {
      text 'Select from the combobox below'
      pack(side: 'top')
    }
    
    @combobox = Tk::Tile::Combobox.new(@left_frame) {
      pack(side: 'bottom')
    }
    @combobox.values = ['red','orange','yellow','green','blue','purple','firebrick']
    


    btn2_hit = proc do
      @list_label.text = "You selected #{@listbox.curselection}" # curselection is an array that holds selection numbers
      Sound.play('boom.wav')
    end

    @btn2 = TkButton.new(@right_frame) {
      text 'Button 2'
      command btn2_hit
      pady 10
      pack(fill: 'x')
    }

    

    @list_label = TkLabel.new(@right_frame) {
      text 'Select from the listbox below'
      pack(side: 'top')
    }
    
    @listbox = TkListbox.new(@right_frame) {
      pack(side: 'bottom')
      selectmode 'multiple'
    }
    @listbox.insert 0, 'Jedi', 'Sith', 'Bounty Hunter', 'Smuggler', 'Droid'
    
    # set up a canvas parented to root window
    @my_canvas = TkCanvas.new(root) do
      background 'white'
      width 300
      height 200
      grid(column: 1, row: 1)
    end

    # adding a line object to the canvas
    @my_line = TkcLine.new(@my_canvas, 30, 50, 200, 80, fill: 'red', width: 3)

    # set up a frame on the bottom to hold things
    bottom_frame = TkFrame.new(root) do
      background '#635'
      padx 25 # adds padding so the frame is a little larger than the items that fill it
      pady 25
      grid(column: 1, row: 3)
    end

    # set up a label
    @label = TkLabel.new(bottom_frame) do
      text 'My Label'
      pack(side: 'top')
    end


    test_checkbox = proc do
      @label.text = @check_one.get_value
      puts @check_one.get_value
    end

    @check_one = TkCheckButton.new(bottom_frame) do
      text 'Orange'
      indicatoron 'true'
      background  '#CAF'
      relief 'groove'
      onvalue 'Orange'
      offvalue 'Not Orange'
      pack(side: 'top')
      command test_checkbox # runs the proc created above
    end

    # set up a label to hold Time
    @time_label = TkLabel.new(bottom_frame) do
      background 'black'
      foreground 'yellow'
      pack(side: 'top')
    end

    Tk.after(Frequency, proc { my_loop }) # calls my_loop

  end 
 

  def my_loop
    @time = Time.now
    @time_label.text = @time.strftime("%I:%M:%S %p")
    @my_canvas.delete(@my_rect) # delete the old rectangle before drawing a new one
    @my_canvas.delete(@my_line2)
    @my_rect = TkcRectangle.new(@my_canvas, @x,  40,  @x+40,  80, width: 2, fill: '#879') # redraw the rectangle
    @x += 2
    @my_line2 = TkcLine.new(@my_canvas, 60, 70, 250, 40, fill: 'blue', width: 3)
    if @x>300
      @x = -40
    end
    Tk.after(Frequency, proc { my_loop }) #recursively calls my_loop. 'Frequency' determines how quickly it gets called so it controls the speed of the loop
  end
end

# puts TkcRectangle.public_methods.sort
TkDemo.new
Tk.mainloop
