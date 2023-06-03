object FormAdd: TFormAdd
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FormAdd'
  ClientHeight = 319
  ClientWidth = 583
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
  object ImageCover: TImage
    Left = 384
    Top = 8
    Width = 193
    Height = 305
    ParentShowHint = False
    Picture.Data = {}
    Proportional = True
    ShowHint = False
    Stretch = True
  end
  object EditTitle: TEdit
    Left = 8
    Top = 8
    Width = 169
    Height = 21
    TabOrder = 0
    TextHint = 'Title'
  end
  object EditAuthor: TEdit
    Left = 8
    Top = 35
    Width = 169
    Height = 21
    TabOrder = 1
    TextHint = 'Author'
  end
  object EditGenre: TEdit
    Left = 8
    Top = 62
    Width = 169
    Height = 21
    TabOrder = 2
    TextHint = 'Genre'
  end
  object EditPublisher: TEdit
    Left = 8
    Top = 89
    Width = 169
    Height = 21
    TabOrder = 3
    TextHint = 'Publisher'
  end
  object EditPages: TEdit
    Left = 8
    Top = 160
    Width = 169
    Height = 21
    TabOrder = 4
    Text = '0'
    TextHint = 'Pages'
  end
  object EditDate: TDateTimePicker
    Left = 8
    Top = 134
    Width = 169
    Height = 20
    Date = 44668.000000000000000000
    Time = 0.770673622682807000
    TabOrder = 5
  end
  object TextDate: TStaticText
    Left = 8
    Top = 116
    Width = 76
    Height = 17
    Caption = 'Date of publish'
    TabOrder = 6
  end
  object ButtonOpenCover: TButton
    Left = 8
    Top = 187
    Width = 169
    Height = 20
    Hint = 'Open|Opens an existing file'
    Caption = 'Open Cover'
    ImageIndex = 7
    TabOrder = 7
    OnClick = ButtonOpenCoverClick
  end
  object ListLang: TComboBox
    Left = 8
    Top = 213
    Width = 169
    Height = 21
    AutoCloseUp = True
    Style = csDropDownList
    ParentShowHint = False
    ShowHint = False
    TabOrder = 8
    TextHint = 'Language'
    Items.Strings = (
      'English'
      'Russian'
      'Belarussian')
  end
  object EditEdition: TEdit
    Left = 8
    Top = 266
    Width = 169
    Height = 21
    TabOrder = 9
    TextHint = 'Edition'
  end
  object ButtonAdd: TButton
    Left = 8
    Top = 293
    Width = 169
    Height = 20
    Caption = 'Add book'
    TabOrder = 10
    OnClick = ButtonAddClick
  end
  object ListBinding: TComboBox
    Left = 8
    Top = 240
    Width = 169
    Height = 21
    Style = csDropDownList
    TabOrder = 11
    TextHint = 'Binding'
    Items.Strings = (
      'Saddle stitch'
      'PUR'
      'Hardcover'
      'Singer sewn'
      'Section sewn'
      'Coptic stitch'
      'Wiro, comb or spiral'
      'Interscrew')
  end
  object MemoDescription: TMemo
    Left = 183
    Top = 8
    Width = 185
    Height = 305
    Hint = 'Description'
    Lines.Strings = (
      'MemoDescription')
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 12
  end
  object ActionList1: TActionList
    Left = 416
    Top = 264
    object FileOpen1: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 528
    Top = 264
  end
end
