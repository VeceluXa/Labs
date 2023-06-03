object Form_Main: TForm_Main
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Bookify'
  ClientHeight = 619
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ImageCover: TImage
    Left = 8
    Top = 387
    Width = 162
    Height = 217
    Center = True
    Picture.Data = {}
    Proportional = True
    Stretch = True
  end
  object Book_Add: TBitBtn
    Left = 8
    Top = 35
    Width = 162
    Height = 25
    Action = Action_Book_Add
    Caption = 'Add book'
    TabOrder = 0
  end
  object Book_Edit: TBitBtn
    Left = 8
    Top = 66
    Width = 162
    Height = 25
    Action = Action_Book_Edit
    Caption = 'Edit book'
    TabOrder = 1
  end
  object Book_Remove: TBitBtn
    Left = 8
    Top = 97
    Width = 162
    Height = 25
    Action = Action_Book_Remove
    Caption = 'Remove book'
    TabOrder = 2
  end
  object Library_Import: TBitBtn
    Left = 8
    Top = 159
    Width = 162
    Height = 25
    Action = Action_Database_Import
    Caption = 'Import library'
    TabOrder = 3
  end
  object Library_Export: TBitBtn
    Left = 8
    Top = 128
    Width = 162
    Height = 25
    Action = Action_Database_Export
    Caption = 'Export library'
    TabOrder = 4
  end
  object StringGrid: TStringGrid
    Left = 186
    Top = 35
    Width = 589
    Height = 576
    ColCount = 9
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goColMoving, goFixedColDefAlign]
    TabOrder = 5
    OnDblClick = StringGridDblClick
    OnDrawCell = StringGridDrawCell
    OnSelectCell = StringGridSelectCell
  end
  object MemoDescription: TMemo
    Left = 8
    Top = 203
    Width = 162
    Height = 161
    Lines.Strings = (
      'MemoDescription')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object Edit_Item: TEdit
    Left = 186
    Top = 8
    Width = 589
    Height = 21
    ReadOnly = True
    TabOrder = 7
    Text = 'Select item'
  end
  object Edit_Search: TEdit
    Left = 8
    Top = 8
    Width = 114
    Height = 21
    TabOrder = 8
    TextHint = 'Seacrh'
    OnChange = Edit_SearchChange
  end
  object Button_Up: TButton
    Left = 120
    Top = 8
    Width = 26
    Height = 21
    ImageAlignment = iaCenter
    ImageIndex = 0
    Images = ImageList1
    TabOrder = 9
    OnClick = Button_UpClick
  end
  object Button_Down: TButton
    Left = 144
    Top = 8
    Width = 26
    Height = 21
    ImageAlignment = iaCenter
    ImageIndex = 1
    Images = ImageList1
    TabOrder = 10
    OnClick = Button_DownClick
  end
  object MainMenu: TMainMenu
    Left = 48
    Top = 571
    object ads1: TMenuItem
      Caption = '&File'
      object Addbook1: TMenuItem
        Action = Action_Book_Add
      end
      object Importbookdatabase1: TMenuItem
        Action = Action_Database_Import
      end
      object Exportbookdatabase1: TMenuItem
        Action = Action_Database_Export
        ShortCut = 16467
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = FileExit1
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object Editbook1: TMenuItem
        Action = Action_Book_Edit
      end
      object Removebook1: TMenuItem
        Action = Action_Book_Remove
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object MenuItemHelp: TMenuItem
        Action = Action1
        Caption = '&About'
        ShortCut = 16456
      end
    end
  end
  object ActionList1: TActionList
    Left = 8
    Top = 571
    object FileOpen1: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
    end
    object FileExit1: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
    object Action_Book_Add: TAction
      Category = 'File'
      Caption = 'Add book'
      ShortCut = 16462
      OnExecute = Action_Book_AddExecute
    end
    object Action_Book_Edit: TAction
      Category = 'File'
      Caption = 'Edit book'
      ShortCut = 16453
      OnExecute = Action_Book_EditExecute
    end
    object Action_Book_Remove: TAction
      Category = 'File'
      Caption = 'Remove book'
      ShortCut = 16466
      OnExecute = Action_Book_RemoveExecute
    end
    object Action_Database_Import: TAction
      Category = 'File'
      Caption = 'Import library'
      ShortCut = 16463
      OnExecute = Action_Database_ImportExecute
    end
    object Action_Database_Export: TAction
      Category = 'File'
      Caption = 'Export library'
      ShortCut = 16462
      OnExecute = Action_Database_ExportExecute
    end
    object Action1: TAction
      Caption = 'Action1'
      OnExecute = Action1Execute
    end
  end
  object Library_OpenDialog: TOpenDialog
    Left = 168
    Top = 579
  end
  object Library_SaveDialog: TSaveDialog
    Left = 144
    Top = 579
  end
  object ImageList1: TImageList
    Left = 200
    Top = 576
    Bitmap = {}
  end
end
