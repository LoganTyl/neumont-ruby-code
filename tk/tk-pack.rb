require 'tk'

root = TkRoot.new do
  title "Tk - pack"
  background "#000"
end
label = TkLabel.new(root) do
  text 'Hello World'
  background "#cf0"
  padx 10
  pady 10
  pack(side: 'top', fill: 'x')
end
entry = TkEntry.new(root) do
  background "#fab"
  foreground "#000"
  pack(side: 'right', fill: 'y')
end
Tk.mainloop