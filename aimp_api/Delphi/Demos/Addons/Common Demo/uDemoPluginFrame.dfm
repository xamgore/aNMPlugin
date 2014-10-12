object DemoPluginForm: TDemoPluginForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'DemoPluginForm'
  ClientHeight = 396
  ClientWidth = 532
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 532
    Height = 396
    ActivePage = tsPlsMan
    Align = alClient
    TabOrder = 0
    object tsPlsMan: TTabSheet
      BorderWidth = 2
      Caption = 'PlaylistManager'
      object lbPlaylist: TListBox
        AlignWithMargins = True
        Left = 3
        Top = 30
        Width = 242
        Height = 331
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbPlaylistClick
      end
      object cbPlaylists: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 514
        Height = 21
        Align = alTop
        Style = csDropDownList
        TabOrder = 1
        OnSelect = cbPlaylistsSelect
      end
      object Panel1: TPanel
        Left = 248
        Top = 27
        Width = 272
        Height = 337
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
        object gbEntry: TGroupBox
          Left = 0
          Top = 0
          Width = 272
          Height = 257
          Align = alTop
          Caption = ' Entry '
          TabOrder = 0
          object Label1: TLabel
            Left = 179
            Top = 75
            Width = 32
            Height = 13
            Caption = 'Index:'
          end
          object Label2: TLabel
            Left = 179
            Top = 102
            Width = 27
            Height = 13
            Caption = 'Mark:'
          end
          object lbEntryStatistics: TLabel
            Left = 5
            Top = 124
            Width = 260
            Height = 98
            AutoSize = False
            WordWrap = True
          end
          object edFileName: TEdit
            AlignWithMargins = True
            Left = 5
            Top = 45
            Width = 262
            Height = 21
            Align = alTop
            TabOrder = 0
          end
          object edDisplayText: TEdit
            AlignWithMargins = True
            Left = 5
            Top = 18
            Width = 262
            Height = 21
            Align = alTop
            ReadOnly = True
            TabOrder = 1
          end
          object cbEntrySelected: TCheckBox
            Left = 5
            Top = 74
            Width = 97
            Height = 17
            Caption = 'Selected'
            TabOrder = 2
          end
          object edEntryIndex: TEdit
            Left = 216
            Top = 72
            Width = 49
            Height = 21
            NumbersOnly = True
            TabOrder = 3
            Text = '0'
          end
          object edEntryMark: TEdit
            Left = 216
            Top = 99
            Width = 49
            Height = 21
            NumbersOnly = True
            TabOrder = 4
            Text = '0'
          end
          object cbEntryAutoPlayingSwitch: TCheckBox
            Left = 5
            Top = 101
            Width = 128
            Height = 17
            Caption = 'AutoPlaying Switch'
            TabOrder = 5
          end
          object btnEntryApply: TButton
            Left = 180
            Top = 228
            Width = 89
            Height = 25
            Caption = 'Apply'
            TabOrder = 6
            OnClick = btnEntryApplyClick
          end
          object btnEntryReloadInfo: TButton
            Left = 3
            Top = 228
            Width = 75
            Height = 25
            Caption = 'Reload Info'
            TabOrder = 7
            OnClick = btnEntryReloadInfoClick
          end
        end
      end
    end
    object tsSkins: TTabSheet
      Caption = 'Skins'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 3
        Top = 4
        Width = 406
        Height = 149
        Caption = ' Skin Info '
        TabOrder = 0
        object Image1: TImage
          Left = 11
          Top = 19
          Width = 120
          Height = 90
        end
        object Label3: TLabel
          Left = 137
          Top = 19
          Width = 31
          Height = 13
          Caption = 'Label3'
        end
        object Label4: TLabel
          Left = 137
          Top = 35
          Width = 31
          Height = 13
          Caption = 'Label3'
        end
        object Label5: TLabel
          Left = 137
          Top = 54
          Width = 266
          Height = 92
          AutoSize = False
          Caption = 'Label3'
          WordWrap = True
        end
        object Button1: TButton
          Left = 11
          Top = 115
          Width = 120
          Height = 25
          Caption = 'Query Skin Info'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'AIMP Skins|*.acs2;*.acs3;'
    Left = 8
    Top = 24
  end
end
