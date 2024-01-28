require 'tk'

class TkInterface
  def initialize

    @root = TkRoot.new do
      title "Tk Widgets"
      background '#224'
      minsize(400, 800)
    end
    # WIDGET 1
    @frame_1 = TkFrame.new(@root) do
      background '#337'
      padx 25
      pady 10
      grid(column: 0, row: 0)
    end
    @label_1 = TkLabel.new(@frame_1) do
      background '#cf0'
      foreground '#000'
      text 'Widget 1'
      font TkFont.new('courier 20 bold')
      width 25
      pack(side: 'top')
    end
    @count = 0
    btn1_clicked = proc do
      @count += 1
      @label_1.text = "Widget 1 - #{@count}"
    end
    @btn_1 = TkButton.new(@frame_1) do
      text "Button 1"
      command btn1_clicked
      padx 10
      pady 10
      pack(side: 'top', fill: 'x')
    end

    # WIDGET 2
    @frame_2 = TkFrame.new(@root) do
      background '#66a'
      padx 25
      pady 10
      grid(column: 0, row: 1)
    end
    @label_2 = TkLabel.new(@frame_2) do
      background '#cf0'
      foreground '#000'
      text 'Widget 2'
      font TkFont.new('arial 20')
      width 25
      pack(side: 'top')
    end
    @entry_2 = TkEntry.new(@frame_2) do
      font TkFont.new('times 25 bold')
      pack(side: 'top')
    end
    @entry_2.value = "Enter something!"
    btn2_clicked = proc do
      @label_2.text = @entry_2.value
    end
    @btn_2 = TkButton.new(@frame_2) do
      text "Button 2"
      command btn2_clicked
      padx 10
      pady 10
      pack(side: 'top', fill: 'x')
    end
    # WIDGET 3
    @frame_3 = TkFrame.new(@root) do
      background '#337'
      padx 25
      pady 10
      grid(column: 0, row: 2)
    end
    @label_3 = TkLabel.new(@frame_3) do
      background '#cf0'
      foreground '#000'
      text 'Widget 3'
      font TkFont.new('arial 20')
      width 25
      pack(side: 'top')
    end

    @combobox_3 = TkCombobox.new(@frame_3) do
      font TkFont.new('arial 20')
      pack(side: 'top')
      state 'readonly'
    end
    @combobox_3.values = ['werewolf', 'human', 'zombie']

    btn3_clicked = proc do
      @label_3.text = @combobox_3.value
    end
    @btn_3 = TkButton.new(@frame_3) do
      text "Button 3"
      command btn3_clicked
      padx 10
      pady 10
      pack(side: 'top', fill: 'x')
    end

    # WIDGET 4
    @frame_4 = TkFrame.new(@root) do
      background '#66a'
      padx 25
      pady 10
      grid(column: 0, row: 3)
    end
    @label_4 = TkLabel.new(@frame_4) do
      background '#cf0'
      foreground '#000'
      text 'Widget 4'
      font TkFont.new('arial 20')
      width 25
      pack(side: 'top')
    end
    btn4_clicked = proc do
      print @listbox_4.curselection
      @label_4.text = @listbox_4.curselection
    end
    @btn_4 = TkButton.new(@frame_4) do
      text "Button 4"
      command btn4_clicked
      padx 10
      pady 10
      pack(side: 'right', fill: 'x')
    end
    @listbox_4 = TkListbox.new(@frame_4) {
      pack('side': 'top')
      selectmode 'multiple'
      height 3
      pack(side: 'left')
    }
    @listbox_4.insert 0, 'Jedi', 'Sith', 'Bounty Hunter', 'Smuggler', 'Droid'

    # WIDGET 5
    @frame_5 = TkFrame.new(@root) do
      background '#337'
      padx 25
      pady 10
      grid(column: 0, row: 4)
    end
    @label_5 = TkLabel.new(@frame_5) do
      background '#cf0'
      foreground '#000'
      text 'Widget 5'
      font TkFont.new('arial 20')
      width 25
      pack(side: 'top')
    end
    call_radio_test = proc do
      @label_5.text = @radio1.get_value  # with radio buttons use get_value, not just value or it won't check for each response
    end
    @radio1 = TkRadioButton.new(@frame_5) do
      background '#aae'
      text 'High'
      value 'high'
      command call_radio_test
      pack(side: 'left')
    end
    @radio2 = TkRadioButton.new(@frame_5) do
      background '#aae'
      text 'Medium'
      value 'medium'
      command call_radio_test
      pack(side: 'left')
    end
    @radio3 = TkRadioButton.new(@frame_5) do
      background '#aae'
      text 'Low'
      value 'low'
      command call_radio_test
      pack(side: 'left')
    end
    @radio2.select
  end
end

TkInterface.new
Tk.mainloop
