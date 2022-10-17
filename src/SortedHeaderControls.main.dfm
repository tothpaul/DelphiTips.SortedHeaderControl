object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 96
    Top = 96
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object HeaderControl1: THeaderControl
    Left = 0
    Top = 0
    Width = 624
    Height = 17
    HotTrack = True
    Sections = <
      item
        ImageIndex = -1
        Text = 'First column'
        Width = 200
      end
      item
        ImageIndex = -1
        Text = 'Second columns'
        Width = 150
      end
      item
        AutoSize = True
        ImageIndex = -1
        Text = 'last column'
        Width = 200
      end>
  end
end
