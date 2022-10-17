unit SortedHeaderControls.main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Execute.SortedHeaderControl, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    HeaderControl1: THeaderControl;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    procedure OnSort(Sender: TObject);
    procedure OnCanSort(Sender: TObject; Index: Integer; var CanSort: Boolean);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  HeaderControl1.OnSort := OnSort;
  HeaderControl1.OnCanSort := OnCanSort;
end;

procedure TForm1.OnCanSort(Sender: TObject; Index: Integer;
  var CanSort: Boolean);
begin
  CanSort := Index <> 3;
end;

procedure TForm1.OnSort(Sender: TObject);
begin
  Label1.Caption := 'SortIndex = ' + HeaderControl1.SortIndex.ToString;
end;

end.
