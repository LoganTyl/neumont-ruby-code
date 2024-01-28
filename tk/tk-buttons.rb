require 'tk'

root = TkRoot.new do
  title "Ruby Tk Example"
  background '#435'
  minsize(800,500)
  #maxsize(800,500)
end

f1 = TkFrame.new(root) do
  background 'red'
  padx 25 # adds padding so the frame is a little larger than the items that fill it
  pady 25

  grid('column': 0, 'row': 0)
end

b1_hit = proc do
  print "push button1!!\n"
end

b1 = TkButton.new(f1) {
  text 'Button1'
  command b1_hit
  pack("side"=>"left")
}



b2_hit = proc do
  print "push button2!!\n"
end

b2 = TkButton.new(f1) {
  text 'Button2'
  command b2_hit
  pack("side"=>"left")
}

f2 = TkFrame.new(root) do
  background 'orange'
  padx 25 # adds padding so the frame is a little larger than the items that fill it
  pady 25
  grid('column': 1, 'row': 0)
end

b3_hit = proc do
  print "push button3!!\n"
end

b3 = TkButton.new(f2) {
  text 'Button3'
  command b3_hit
  pack('fill': 'x')
}

f3 = TkFrame.new(root) do
  background 'yellow'
  padx 25 # adds padding so the frame is a little larger than the items that fill it
  pady 25
  grid('column': 2, 'row': 2)
end

b4_hit = proc do
  print "push button4!!"
end

b4 = TkButton.new(f3) {
  text 'Button4'
  command b4_hit
  width 20
  pack('fill': 'x')
}

f4 = TkFrame.new(root) do
  background 'green'
  padx 25 # adds padding so the frame is a little larger than the items that fill it
  pady 25
  grid('column': 3, 'row': 3)
end

@l1 = TkLabel.new(f4) do
  background 'green'
  text 'Mouse coordinates'
  borderwidth 5
  font TkFont.new('times 20 bold')
  foreground  "yellow"
  relief      "groove"
  width 20
  pack('fill': 'x')
end

root.bind("Motion", proc{|x, y| @l1.text = "#{x} : #{y}"}, "%x %y")

Tk.mainloop