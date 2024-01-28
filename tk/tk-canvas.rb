require 'tk'

Frequency = 10

class TkDemo
  def initialize
    @start_x = 290
    @start_y = 200
    @box_x = @start_x
    @box_y = @start_y

    @mouse_x = @start_x
    @mouse_y = @start_y
    @speed = 2

    @root = TkRoot.new do
      title "Ruby Tk Canvas"
      background '#435'
      minsize(600,500)
      maxsize(600,500)
    end

    @frame = TkFrame.new(@root) do
      padx 10
      pady 10
      background '#435'
      pack(side: 'top')
    end

    @my_canvas = TkCanvas.new(@frame) do
      background '#000'
      width 580
      height 400
      pack(side: 'top')
    end
    @label_1 = TkLabel.new(@frame) do
      background '#435'
      foreground '#cf0'
      text 'Mouse'
      font TkFont.new('courier 14 bold')
      width 20
      pack(side: 'left')
    end
    @label_2 = TkLabel.new(@frame) do
      background '#435'
      foreground '#cf0'
      text 'Screen'
      font TkFont.new('courier 14 bold')
      width 20
      pack(side: 'left')
    end
    @label_3 = TkLabel.new(@frame) do
      background '#435'
      foreground '#cf0'
      text 'right btn: 0'
      font TkFont.new('courier 14 bold')
      width 15
      pack(side: 'bottom')
    end
    @label_4 = TkLabel.new(@frame) do
      background '#435'
      foreground '#cf0'
      text 'left btn: 0'
      font TkFont.new('courier 14 bold')
      width 15
      pack(side: 'bottom')
    end
    20.times do |i|
      TkcLine.new(@my_canvas, i*29, 400, 580, 400-i*25, fill: 'blue', width: 3)
    end
    @line1 = TkcLine.new(@my_canvas, 50, 50, 75, 100, fill: 'green', width: 3)
    @line2 = TkcLine.new(@my_canvas, 75, 100, 25, 100, fill: 'green', width: 3)
    @line3 = TkcLine.new(@my_canvas, 25, 100, 50, 50, fill: 'green', width: 3)


    def do_motion(x, y)
      @label_1.text = "canvas x:#{x} y:#{y}"
      if x < 3 || x > 576 || y < 3 || y > 396
        x = @start_x
        y = @start_y
      end

      @mouse_x = x
      @mouse_y = y
    end
    def do_app_motion(x, y)
      @label_2.text = "screen x:#{x} y:#{y}"
      @screen_x = x
      @screen_y = y
    end
    def do_l_btn
      @label_4.text = "left btn: 1"
    end
    def do_l_btn_release
      @label_4.text = "left btn: 0"
    end
    def do_r_btn
      @label_3.text = "right btn: 1"
    end
    def do_r_btn_release
      @label_3.text = "right btn: 0"
    end

    @my_canvas.bind("Motion", proc{ |x, y| do_motion(x,y) }, "%x %y")
    @root.bind("Motion", proc{ |x, y| do_app_motion(x,y) }, "%X %Y")
    @my_canvas.bind("Button-1", proc{do_l_btn})
    @my_canvas.bind("ButtonRelease-1", proc{do_l_btn_release})
    @my_canvas.bind("Button-3", proc{do_r_btn})
    @my_canvas.bind("ButtonRelease-3", proc{do_r_btn_release})

    Tk.after(Frequency, proc { my_loop })
  end



  def my_loop
    stop_loop = false

    if @box_x > @mouse_x
      @box_x -= @speed
    end
    if @box_x < @mouse_x
      @box_x += @speed
    end
    if @box_y > @mouse_y
      @box_y -= @speed
    end
    if @box_y < @mouse_y
      @box_y += @speed
    end
    @my_canvas.delete(@my_line)
    @my_canvas.delete(@my_rect) # delete the old rectangle before drawing a new one
    @my_rect = TkcRectangle.new(@my_canvas, @box_x-20, @box_y-20,  @box_x+20,  @box_y+20, fill: '#879') # redraw the rectangle
    @my_line = TkcLine.new(@my_canvas, 0, 0, 580, 400, fill: 'red', width: 3)

    if !stop_loop
      Tk.after(Frequency, proc { my_loop }) #recursively calls my_loop. 'Frequency' determines how quickly it gets called so it controls the speed of the loop
    end

  end
end

TkDemo.new
Tk.mainloop