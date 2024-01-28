require 'tk'

root = TkRoot.new do
  title "Tk - grid"
  background "#000"
end
label = TkLabel.new(root) do
  text 'Hello World'
  background "#cf0"
  padx 10
  pady 10
  grid(column: 0, row: 0)
end
entry = TkEntry.new(root) do
  background "#fab"
  foreground "#000"
  grid(column: 1, row: 1)
end
Tk.mainloop