object Form1: TForm1
  Left = 192
  Top = 152
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 352
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 39
    Width = 170
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Image1: TImage
    Left = 280
    Top = 68
    Width = 258
    Height = 276
    Center = True
    Proportional = True
    Stretch = True
  end
  object ListBox1: TListBox
    Left = 8
    Top = 68
    Width = 265
    Height = 273
    ItemHeight = 13
    TabOrder = 0
  end
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 33
    Height = 25
    Caption = '<<'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 240
    Top = 8
    Width = 33
    Height = 25
    Caption = '>>'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 48
    Top = 8
    Width = 49
    Height = 25
    Caption = 'Play'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 104
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Pause'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 184
    Top = 8
    Width = 49
    Height = 25
    Caption = 'Stop'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button1: TButton
    Left = 184
    Top = 37
    Width = 90
    Height = 25
    Caption = 'Jump To Time'
    TabOrder = 6
    OnClick = Button1Click
  end
end
