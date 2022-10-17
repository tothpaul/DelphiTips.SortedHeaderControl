program SortedHeaderControls;

uses
  Vcl.Forms,
  SortedHeaderControls.main in 'SortedHeaderControls.main.pas' {Form1},
  Execute.SortedHeaderControl in '..\lib\Execute.SortedHeaderControl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
