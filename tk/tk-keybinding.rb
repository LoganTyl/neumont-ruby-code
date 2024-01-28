require 'tk'

Frequency = 10

class TkDemo
  def initialize

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

    @label_1 = TkLabel.new(@frame) do
      background '#435'
      foreground '#cf0'
      text "ASCII Character:"
      font TkFont.new('courier 14 bold')
      width 20
      pack(side: 'top')
    end
    @label_2 = TkLabel.new(@frame) do
      background '#435'
      foreground '#cf0'
      text "Keysym Name:"
      font TkFont.new('courier 14 bold')
      width 40
      pack(side: 'top')
    end
    @label_3 = TkLabel.new(@frame) do
      background '#435'
      foreground '#cf0'
      text "Keysym Number:"
      font TkFont.new('courier 14 bold')
      width 20
      pack(side: 'top')
    end
    @root.bind("Key", proc{ |a, k, n| key_pressed(a, k, n) }, "%A %K %N")
  end
  def key_pressed(a, k, n)
    @label_1.text = "ASCII Character: #{a}"
    @label_2.text = "Keysym Name: #{k}"
    @label_3.text = "Keysym Number: #{n}"
    puts "ASCII:#{a} Keysym Name:#{k} Keysym:#{n}"
  end


end

TkDemo.new
Tk.mainloop