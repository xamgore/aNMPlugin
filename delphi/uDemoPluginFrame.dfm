object DemoPluginForm: TDemoPluginForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'aNMusic'
  ClientHeight = 131
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelLogin: TLabel
    Left = 18
    Top = 8
    Width = 34
    Height = 13
    Caption = #1051#1086#1075#1080#1085':'
  end
  object LabelPass: TLabel
    Left = 18
    Top = 40
    Width = 41
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100':'
  end
  object Label1: TLabel
    Left = 8
    Top = 110
    Width = 99
    Height = 13
    Cursor = crHandPoint
    Caption = 'http://annimon.com/'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3646975
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentColor = False
    ParentFont = False
    OnClick = Label1Click
  end
  object CheckAuthButton: TButton
    Left = 223
    Top = 3
    Width = 74
    Height = 55
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
    TabOrder = 2
    TabStop = False
    WordWrap = True
    OnClick = CheckAuthButtonClick
  end
  object SaveSettingsButton: TButton
    Left = 223
    Top = 105
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 4
    OnClick = SaveSettingsButtonClick
  end
  object LoginTB: TEdit
    Left = 67
    Top = 5
    Width = 150
    Height = 21
    TabStop = False
    TabOrder = 0
    OnKeyDown = LoginTBKeyDown
    OnKeyUp = TBKeyUp
  end
  object PassTB: TEdit
    Left = 67
    Top = 37
    Width = 150
    Height = 21
    TabStop = False
    PasswordChar = '*'
    TabOrder = 1
    OnKeyDown = PassTBKeyDown
    OnKeyUp = TBKeyUp
  end
  object MustSendCheckBox: TCheckBox
    Left = 18
    Top = 64
    Width = 199
    Height = 17
    TabStop = False
    Caption = #1055#1088#1080#1086#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1087#1088#1072#1074#1082#1091' '#1076#1072#1085#1085#1099#1093
    TabOrder = 3
    OnClick = MustSendCheckBoxClick
  end
end
