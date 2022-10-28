object FormHelp: TFormHelp
  Left = 0
  Top = 0
  Caption = 'Help'
  ClientHeight = 455
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MemoHelp: TMemo
    Left = 0
    Top = 0
    Width = 505
    Height = 455
    Align = alClient
    Lines.Strings = (
      'MemoHelp')
    TabOrder = 0
    ExplicitLeft = 136
    ExplicitTop = 104
    ExplicitWidth = 185
    ExplicitHeight = 100
  end
end
