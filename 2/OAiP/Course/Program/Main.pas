unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.IOUtils, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdActns, Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.JumpList, Data.DB, Vcl.DBGrids, Vcl.DBCtrls, Vcl.DBCGrids, Add, List, Database,
  Vcl.Imaging.jpeg, Help, System.ImageList, Vcl.ImgList;

type
  TMoveSG = class(TCustomGrid);

  TForm_Main = class(TForm)
    MainMenu: TMainMenu;
    ads1: TMenuItem;
    Edit1: TMenuItem;
    Help1: TMenuItem;
    ActionList1: TActionList;
    FileOpen1: TFileOpen;
    FileExit1: TFileExit;
    Book_Add: TBitBtn;
    Book_Edit: TBitBtn;
    Book_Remove: TBitBtn;
    Library_Import: TBitBtn;
    Library_Export: TBitBtn;
    Action_Book_Add: TAction;
    Action_Book_Edit: TAction;
    Action_Database_Import: TAction;
    Action_Database_Export: TAction;
    Addbook1: TMenuItem;
    Action_Book_Remove: TAction;
    Importbookdatabase1: TMenuItem;
    Exportbookdatabase1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Editbook1: TMenuItem;
    Removebook1: TMenuItem;
    StringGrid: TStringGrid;
    ImageCover: TImage;
    Library_OpenDialog: TOpenDialog;
    Library_SaveDialog: TSaveDialog;
    MemoDescription: TMemo;
    Edit_Item: TEdit;
    Action1: TAction;
    MenuItemHelp: TMenuItem;
    Edit_Search: TEdit;
    Button_Up: TButton;
    Button_Down: TButton;
    ImageList1: TImageList;
    procedure Action_Book_EditExecute(Sender: TObject);
    procedure Action_Book_AddExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateGrid(List: TList);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGridDblClick(Sender: TObject);

    // Sort string grid by column
    procedure SortGridByCols(Grid: TStringGrid; Col: Integer; Flag: Boolean);
    procedure Action_Database_ExportExecute(Sender: TObject);
    procedure Action_Database_ImportExecute(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Action_Book_RemoveExecute(Sender: TObject);

    procedure RemoveAttributes(StringGrid: TStringGrid);
    procedure Action1Execute(Sender: TObject);
    procedure Edit_SearchChange(Sender: TObject);

    procedure SearchUp(StringGrid: TStringGrid; Text: String);
    procedure SearchDown(StringGrid: TStringGrid; Text: String);
    procedure Button_UpClick(Sender: TObject);
    procedure Button_DownClick(Sender: TObject);

  private
    { Private declarations }
    SearchI, SearchJ: Integer;
  public
    { Public declarations }
    Item: TItem;
    List: TList;
  end;

var
  Form_Main: TForm_Main;

implementation

{$R *.dfm}


// Procedure to run when form is created
procedure TForm_Main.FormCreate(Sender: TObject);
begin
  // Initialize List
  List := TList.Create;

  // Set Memo parent
  MemoDescription.Parent := self;
  MemoDescription.Lines.Clear;

  // Set fixed row values
  StringGrid.Cells[0,0] := 'Title';
  StringGrid.Cells[1,0] := 'Author';
  StringGrid.Cells[2,0] := 'Genre';
  StringGrid.Cells[3,0] := 'Publisher';
  StringGrid.Cells[4,0] := 'Date of publish';
  StringGrid.Cells[5,0] := 'Pages';
  StringGrid.Cells[6,0] := 'Language';
  StringGrid.Cells[7,0] := 'Edition';
  StringGrid.Cells[8,0] := 'Binding';
end;

procedure TForm_Main.Action1Execute(Sender: TObject);
begin
  with TFormHelp.Create(self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TForm_Main.Action_Book_AddExecute(Sender: TObject);
begin
  with TFormAdd.AddCreate() do

    // Open form
    try
      ShowModal;
    finally


      // Get item from created form
      Self.Item := GetItem();

      if Item.IsEmpty then
        List.Add(Item);

      Free;
    end;



  UpdateGrid(List);
  RemoveAttributes(StringGrid);
end;

procedure TForm_Main.Action_Book_EditExecute(Sender: TObject);
begin
  if StringGrid.RowCount > 1 then
  begin
    with TFormAdd.EditCreate(List.GetById(StringGrid.Row-1)) do

      // Open form
      try
        ShowModal;
      finally

        // Get item from created form
        Self.Item := GetItem();
        Free;
      end;

      // Update list entry
      List.SetById(StringGrid.Row-1, Item);

      // Update grid
      UpdateGrid(List);
      RemoveAttributes(StringGrid);
  end;

end;

// If Row is not fixed remove it from list and update grid
procedure TForm_Main.Action_Book_RemoveExecute(Sender: TObject);
begin
  if StringGrid.Row > 0 then
  begin
    List.RemoveById(StringGrid.Row - 1);
    UpdateGrid(List);
  end;

  RemoveAttributes(StringGrid);
end;

// Event when 'Export library' is clicked
procedure TForm_Main.Action_Database_ExportExecute(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  FileLibrary: File of TItemExport;
  FileDescriptions: File;
  NameLibrary: String;
  Item: TItemExport;
  ItemClass: TItem;
  i, writeLength: Integer;
  FileName, SavedCover: String;
begin

  Library_SaveDialog.Title := 'Save Library';
  Library_SaveDialog.InitialDir := GetCurrentDir;

  if Library_SaveDialog.Execute then
  begin

    // Create folder for library and move to it
    TDirectory.CreateDirectory(Library_SaveDialog.FileName);
    SetCurrentDir(Library_Savedialog.FileName);
    NameLibrary := ExtractFileName(Library_SaveDialog.FileName);

    // Create library file
    AssignFile(FileLibrary, NameLibrary +'.lb');
    Rewrite(FileLibrary);

    // Create descritions file
    AssignFile(FileDescriptions, NameLibrary+'.lbd');
    Rewrite(FileDescriptions, 1);
//    FileDescriptions := TFile.Create(NameLibrary+'.lbd', fmCreate);

    SavedCover := ExtractFilePath(Application.ExeName) + '\Cover.jpg';

    // Create dir for covers
    CreateDir('Covers');

    // Iterate through list and add each record to file
    for i := 1 to List.length do
    begin

      // Get Item from List
      ItemClass := List.GetById(i-1);
      Item := ItemClass.toRecord;

      //
      FileName := GetCurrentDir + '\Covers\Cover-' + IntToStr(i) + '.jpg';

      // Save Cover to folder
      if Item.Cover <> '' then
        TFile.Copy(Item.Cover, FileName)
      else
        TFile.Copy(SavedCover, FileName);

      // Append record to file
      Item.Cover := FileName;

      Write(FileLibrary, Item);

      writeLength := ItemClass.Description.Length;

      BlockWrite(FileDescriptions, writeLength, SizeOf(Integer));
      BlockWrite(FileDescriptions, ItemClass.Description[1], writeLength*SizeOf(Char));

//      BlockWrite(FileDescriptions, writeLength, SizeOf(Integer));
//      BlockWrite(FileDescriptions, ItemClass.Description, writeLength);
//      FileDescriptions.Write(writeLength, SizeOf(Integer));
//      FileDescriptions.Write(ItemClass.Description, writeLength);
    end;

    // Close file
    CloseFile(FileLibrary);
    CloseFile(FileDescriptions);
  end;
end;


// Event when 'Import library' is clicked
procedure TForm_Main.Action_Database_ImportExecute(Sender: TObject);
var
  FileLibrary: File of TItemExport;
  FileDescriptions: File;
  Item: TItem;
  ItemRecord: TItemExport;
  i, Offset, Length: Integer;
  FilePath, Description: String;
begin

  // Configure Library_OpenDialog
  Library_OpenDialog.Title := 'Open Library';
  Library_OpenDialog.InitialDir := GetCurrentDir;
  Library_OpenDialog.Filter := 'Library file|*.lb';

  // After opened
  if Library_OpenDialog.Execute then
  begin

    SetCurrentDir(ExtractFileDir(Library_OpenDialog.FileName));
    FilePath := ExtractFileName(Library_OpenDialog.FileName);

    // Open library file
    AssignFile(FileLibrary, FilePath);
    //FileMode := fmOpenRead;
    Reset(FileLibrary);

    // Open descriptions file

    AssignFile(FileDescriptions, FilePath + 'd');
    Reset(FileDescriptions, 1);

    // Create new list
    List := List.Create();

    i := 1;
    Offset := 0;
    // Add records to list while not end of file
    while not EOF(FileLibrary) do
    begin

      // Read to record
      Read(FileLibrary, ItemRecord);

      // Create Item and add record items to it
      Item := TItem.Create;
      Item.fromRecord(ItemRecord);

      // Get path of image cover and add it to Item
      FilePath := ExtractFileDir(Library_OpenDialog.FileName)
                          + '\Covers\Cover-' + IntToStr(i) + '.jpg';
      Item.Cover := FilePath;

      // Get Description and add it to Item
      // Read Length of string

//      Length := 0;
//      Description := '';

      BlockRead(FileDescriptions, Length, SizeOf(Integer));
      //Set length of string
      SetLength(Description, Length);
      // Read string
      if Length > 0 then
        BlockRead(FileDescriptions, Description[1], Length*SizeOf(Char));

      Offset := Offset + SizeOf(Integer) + Length*SizeOf(Char);
      Seek(FileDescriptions, Offset);

      Item.Description := Description;

      // Add Item to List
      List.Add(Item);

      i := i + 1;
    end;

    // Close files
    CloseFile(FileLibrary);
    CloseFile(FileDescriptions);

    // Update grid after importing list
    UpdateGrid(List);
  end;
end;



procedure TForm_Main.Button_DownClick(Sender: TObject);
begin
  SearchDown(StringGrid, Edit_Search.Text);
end;

procedure TForm_Main.Button_UpClick(Sender: TObject);
begin
  SearchUp(StringGrid, Edit_Search.Text);
end;

procedure TForm_Main.Edit_SearchChange(Sender: TObject);
begin
  SearchI := -1;
  SearchJ := 1;
  SearchDown(StringGrid, Edit_Search.Text);
end;

procedure TForm_Main.SearchUp(StringGrid: TStringGrid; Text: String);
var
  i, j: Integer;
  NotFound: Boolean;
begin

  if SearchI = 0 then
  begin
    i := StringGrid.ColCount - 1;
    j := SearchJ - 1;
  end else
  begin
    i := SearchI - 1;
    j := SearchJ;
  end;

  NotFound := True;
  while (NotFound) and (j >= 1) do
  begin

    while (NotFound) and (i >= 0) do
    begin

      if StringGrid.Cells[i, j].Contains(Text) then
      begin
        NotFound := False;
        SearchI := i;
        SearchJ := j;
      end;

      i := i - 1;
    end;
    i := StringGrid.ColCount - 1;
    j := j - 1;
  end;

  if not NotFound then
  begin
    StringGrid.Col := SearchI;
    StringGrid.Row := SearchJ;
  end;
end;

procedure TForm_Main.SearchDown(StringGrid: TStringGrid; Text: String);
var
  i, j: Integer;
  NotFound: Boolean;
begin

  if SearchI = StringGrid.ColCount - 1 then
  begin
    i := 0;
    j := SearchJ + 1;
  end else
  begin
    i := SearchI + 1;
    j := SearchJ;
  end;

  NotFound := True;
  while (NotFound) and (j <= StringGrid.RowCount) do
  begin
    while (NotFound) and (i <= StringGrid.ColCount) do
    begin

      if StringGrid.Cells[i, j].Contains(Text) then
      begin
        NotFound := False;
        SearchI := i;
        SearchJ := j;
      end;

      i := i + 1;
    end;
    i := 0;
    j := j + 1;
  end;

  if not NotFound then
  begin
    StringGrid.Col := SearchI;
    StringGrid.Row := SearchJ;
  end;


end;

// Change MemoDescription and ImageCover when cell is selected
procedure TForm_Main.StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  Item: TItem;
begin

  Edit_Item.Text := StringGrid.Cells[ACol, ARow];
  if (ARow > 0) then
  begin

    // Get record of book
    Item := List.GetById(ARow-1);

    // Set description
    MemoDescription.Lines.Clear;
    MemoDescription.Lines.Text := Item.Description;

    // Set ImageCover
    if Item.Cover <> '' then
      ImageCover.Picture.LoadFromFile(Item.Cover)
    else
      self.ImageCover.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\Cover.jpg');
  end
  else
  begin
    MemoDescription.Text := 'Select book';
    self.ImageCover.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\Cover.jpg');
  end;
end;


// Update grid from list
procedure TForm_Main.UpdateGrid(List: TList);
var
  i, j: Integer;
  Item: TItem;
begin

  StringGrid.RowCount := 1;
  for i := 1 to List.length do
  begin
    StringGrid.RowCount := StringGrid.RowCount + 1;

    Item := List.GetById(i-1);

    StringGrid.Cells[0,i] := Item.Title;
    StringGrid.Cells[1,i] := Item.Author;
    StringGrid.Cells[2,i] := Item.Genre;
    StringGrid.Cells[3,i] := Item.Publisher;
    StringGrid.Cells[4,i] := DateToStr(Item.Date);
    StringGrid.Cells[5,i] := IntToStr(Item.Pages);
    StringGrid.Cells[6,i] := Item.Language;
    StringGrid.Cells[7,i] := Item.Edition;
    StringGrid.Cells[8,i] := Item.Binding;

  end;
end;


// Sort when stringgrid header is double-clicked
procedure TForm_Main.StringGridDblClick(Sender: TObject);
var
  Cell: String;
begin
  if StringGrid.Row = 0 then
  begin
    Cell := StringGrid.Cells[StringGrid.Col, StringGrid.Row];
    if Cell.Contains('(+)') then
    begin
      RemoveAttributes(StringGrid);
      Cell := Cell.Remove(Cell.Length - 4);
      Cell := Cell + ' (-)';
      SortGridByCols(StringGrid, StringGrid.Col, False);
    end
    else if Cell.Contains('(-)') then
    begin
      RemoveAttributes(StringGrid);
      Cell := Cell.Remove(Cell.Length - 4);
      Cell := Cell + ' (+)';
      SortGridByCols(StringGrid, StringGrid.Col, True);
    end
    else
    begin
      RemoveAttributes(StringGrid);
      Cell := Cell + ' (+)';
      SortGridByCols(StringGrid, StringGrid.Col, True);
    end;

    StringGrid.Cells[StringGrid.Col, StringGrid.Row] := Cell;
    Edit_Item.Text := Cell;
  end;
end;

procedure TForm_Main.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
        // bebra
end;

procedure TForm_Main.SortGridByCols(Grid: TStringGrid; Col: Integer; Flag: Boolean);
var
  i, j, MaxInd: Integer;

procedure Swap(Row1, Row2: Integer);
var
  Temp: String;
  i: Integer;
begin
  for i := 0 to Grid.ColCount do
  begin
    Temp := StringGrid.Cells[i, Row1];
    Grid.Cells[i, Row1] := Grid.Cells[i, Row2];
    Grid.Cells[i, Row2] := Temp;
  end;
end;

begin
  for i := 1 to StringGrid.RowCount do
  begin

    MaxInd := i;

    for j := i + 1 to StringGrid.RowCount-1 do
      if Flag xor (Grid.Cells[Col, j] > Grid.Cells[Col, i]) then
        maxInd := j;

    Swap(i, MaxInd);

  end;
  Grid.Refresh;
end;

procedure TForm_Main.RemoveAttributes(StringGrid: TStringGrid);
var
  i: Integer;
  Cell: String;
begin
  for i := 0 to StringGrid.ColCount do
  begin
    Cell := StringGrid.Cells[i, StringGrid.Row];
    if Cell.EndsWith(')') then
      Cell := Cell.Remove(Cell.Length - 4);
    StringGrid.Cells[i, StringGrid.Row] := Cell;
  end;

end;
end.
