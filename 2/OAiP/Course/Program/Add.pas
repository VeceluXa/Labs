unit Add;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus,
  System.Actions, Vcl.ActnList, Vcl.ExtDlgs, Vcl.StdActns, Vcl.ExtCtrls, Database,
  Vcl.Imaging.jpeg;

type
  TFormAdd = class(TForm)
    EditTitle: TEdit;
    EditAuthor: TEdit;
    EditGenre: TEdit;
    EditPublisher: TEdit;
    EditPages: TEdit;
    EditDate: TDateTimePicker;
    TextDate: TStaticText;
    ButtonOpenCover: TButton;
    ActionList1: TActionList;
    FileOpen1: TFileOpen;
    ImageCover: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    ListLang: TComboBox;
    EditEdition: TEdit;
    ButtonAdd: TButton;
    ListBinding: TComboBox;
    MemoDescription: TMemo;
    procedure ButtonOpenCoverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    function GetItem(): TItem;
    constructor EditCreate(Item: TItem);
    constructor AddCreate();


  private
    { Private declarations }
  public
    { Public declarations }
    Item: TItem;

  end;

var
  FormAdd: TFormAdd;

implementation

{$R *.dfm}

procedure TFormAdd.ButtonOpenCoverClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    ImageCover.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TFormAdd.ButtonAddClick(Sender: TObject);
begin
  Item.Title := EditTitle.Text;
  Item.Author := EditAuthor.Text;
  Item.Genre := EditGenre.Text;
  Item.Description := MemoDescription.Lines.Text;
  Item.Publisher := EditPublisher.Text;
  Item.Date := EditDate.Date;
  Item.Pages := StrToInt(EditPages.Text);
  Item.Cover := OpenPictureDialog1.FileName;
  Item.Language := ListLang.Text;
  Item.Edition := EditEdition.Text;
  Item.Binding := ListBinding.Text;

  Close;
end;

procedure TFormAdd.FormCreate(Sender: TObject);
begin
  Item := TItem.Create;

//  ImageCover.Picture.LoadFromFile('\Covers\Cover.jpg');
//  Item.Cover := '\Covers\Cover.jpg';
end;

function TFormAdd.GetItem(): TItem;
begin
  Result := Item;
end;

constructor TFormAdd.EditCreate(Item: TItem);
begin
  self := TFormAdd.Create(nil);
  self.Caption := 'Edit book';
  self.ButtonAdd.Caption := 'Save edit';

  EditPages.NumbersOnly := true;

  self.EditTitle.Text := Item.Title;
  self.EditAuthor.Text := Item.Author;
  self.EditGenre.Text := Item.Genre;
  self.EditPublisher.Text := Item.Publisher;
  self.EditPages.Text := IntToStr(Item.Pages);
  self.EditDate.Date := Item.Date;
  if Item.Cover <> '' then
    self.ImageCover.Picture.LoadFromFile(Item.Cover)
  else
    self.ImageCover.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\Cover.jpg');
  self.MemoDescription.Lines.Text := Item.Description;
  self.EditEdition.Text := Item.Edition;
end;



constructor TFormAdd.AddCreate();
begin
  self := TFormAdd.Create(nil);
  self.Caption := 'Add book';
  MemoDescription.Lines.Clear;

  EditPages.NumbersOnly := true;

  self.ImageCover.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\Cover.jpg');
end;

end.
