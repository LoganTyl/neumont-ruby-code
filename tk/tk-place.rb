require 'tk'

root = TkRoot.new do
  title "Tk - place"
  background "#000"
end
label = TkLabel.new(root) do
  text 'Hello World'
  background "#cf0"
  padx 10
  pady 10
  place(relx: 0.0, rely: 0.5)
end
entry = TkEntry.new(root) do
  background "#fab"
  foreground "#000"
  place(x: 100, y: 150)
end
Tk.mainloop