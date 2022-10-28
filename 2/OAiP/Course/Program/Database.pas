unit Database;

interface

uses vcl.Graphics, system.SysUtils, system.Classes;

type

  TItemExport = record
      Title, Author, Genre, Publisher, Language, Edition, Binding: String[255];
      Date: String[255];
      Pages: Integer;
      Cover: String[255];
  end;

  TItem = class
      Title, Author, Genre, Publisher, Language, Edition, Binding: String;
      Description: String;
      Date: TDate;
      Pages: Integer;
      Cover: String;

      constructor Create;

      public
      function IsEmpty: Boolean;
      function toRecord(): TItemExport;
      procedure fromRecord(ItemRecord: TItemExport);
    End;
implementation

  constructor TItem.Create;
  begin
    self.Title := '';
    self.Author := '';
    self.Genre := '';
    self.Description := '';
    self.Publisher := '';
    self.Date := 0;
    self.Pages := 0;
    self.Cover := '';
    self.Language := '';
    self.Edition := '';
    self.Binding := '';
  end;

  function TItem.toRecord(): TItemExport;
  begin
    Result.Title       := self.Title;
    Result.Author      := self.Author;
    Result.Genre       := self.Genre;
    Result.Publisher   := self.Publisher;
    Result.Language    := self.Language;
    Result.Edition     := self.Edition;
    Result.Binding     := self.Binding;
    Result.Date        := DateToStr(self.Date);
    Result.Pages       := self.Pages;
    Result.Cover       := self.Cover;
  end;

  procedure TItem.fromRecord(ItemRecord: TItemExport);
  begin
    self.Title       := ItemRecord.Title;
    self.Author      := ItemRecord.Author;
    self.Genre       := ItemRecord.Genre;
    self.Publisher   := ItemRecord.Publisher;
    self.Language    := ItemRecord.Language;
    self.Edition     := ItemRecord.Edition;
    self.Binding     := ItemRecord.Binding;
    self.Date        := StrToDate(ItemRecord.Date);
    self.Pages       := ItemRecord.Pages;
    self.Cover       := ItemRecord.Cover;
  end;

  function TItem.IsEmpty: Boolean;
  begin
    Result := false;

    if self.Title            <> '' then
      Result := true;
    if self.Author           <> '' then
      Result := true;
    if self.Genre            <> '' then
      Result := true;
    if self.Publisher        <> '' then
      Result := true;
    if self.Language         <> '' then
      Result := true;
    if self.Edition          <> '' then
      Result := true;
    if self.Binding          <> '' then
      Result := true;
    if DateToStr(self.Date)  <> '' then
      Result := true;
    if self.Pages            <> 0  then
      Result := true;
    if self.Description      <> '' then
      Result := true;
    if self.Cover            <> '' then

  end;
end.
