unit Execute.SortedHeaderControl;

{

  Add this unit in the uses of your form to change THeaderControl behavior

  - SortIndex is the column index where an arrow is displayed
  - negative SortIndex for descending order
  - OnCanSort let you disable a column sorting
  - OnSort is called when SortIndex changes

}

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.UITypes,
  System.Types,
  System.Classes,
  Vcl.Graphics,
  Vcl.GraphUtil,
  Vcl.ComCtrls;

type
  TCanSortEvent = procedure(Sender: TObject; Index: Integer; var CanSort: Boolean) of object;

  THeaderControl = class(Vcl.ComCtrls.THeaderControl)
  private
    FSortIndex: Integer; // 0 = None, -1/+1 = First Column...
    FOnSort: TNotifyEvent;
    FOnCanSort: TCanSortEvent;
    procedure SetSortIndex(Value: Integer);
  protected
    procedure DrawSection(Section: THeaderSection; const Rect: TRect;
      Pressed: Boolean); override;
    procedure SectionClick(Section: THeaderSection); override;
    procedure Loaded; override;
    function CanSort(Index: Integer): Boolean; virtual;
    procedure SectionResize(Section: THeaderSection); override;
  public
    property SortIndex: Integer read FSortIndex write SetSortIndex;
    property OnSort: TNotifyEvent read FOnSort write FOnSort;
    property OnCanSort: TCanSortEvent read FOnCanSort write FOnCanSort;
  end;

implementation

{ THeaderControl }

function THeaderControl.CanSort(Index: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnCanSort) then
    FOnCanSort(Self, Index, Result);
end;

procedure THeaderControl.DrawSection(Section: THeaderSection; const Rect: TRect;
  Pressed: Boolean);
var
  p: array[0..2] of TPoint;
begin
  with Canvas do
  begin
    if Section.Index < Sections.Count - 1 then
    begin
      Pen.Color := clWhite;
      MoveTo(Rect.Right, Rect.Top);
      LineTo(Rect.Right, Rect.Bottom);
      Pen.Color := clSilver;
      MoveTo(Rect.Right - 1, Rect.Top);
      LineTo(Rect.Right - 1, Rect.Bottom);
    end;
    var S := Section.Text;
    var R := Rect;
    Inc(R.Left, 5);
    Dec(R.Right, 5);
    if Abs(FSortIndex) = Section.Index + 1 then
    begin
      Dec(R.Right, 8 + 5);
      p[0].X := R.Right + 5;
      P[1].X := P[0].X + 8;
      P[2].X := P[0].X + 4;
      p[0].Y := R.Top + (R.Height - 4) div 2;
      if FSortIndex < 0 then
      begin
        P[2].Y := P[0].Y + 4;
      end else begin
        P[2].Y := P[0].Y;
        P[0].Y := P[0].Y + 4;
      end;
      P[1].Y := P[0].Y;
      var CL := Brush.Color;
      Brush.Color := clBlack;
      Pen.Color := clBlack;
      Polygon(P);
      Brush.Color := CL;
    end;
    TextRect(R, S, [tfSingleLine, tfVerticalCenter, tfEndEllipsis]);
  end;
//  inherited;
end;

procedure THeaderControl.Loaded;
begin
  inherited;
  FSortIndex := 1;
  for var I := 0 to Sections.Count - 1 do
    Sections[I].Style := THeaderSectionStyle.hsOwnerDraw;
end;

procedure THeaderControl.SectionClick(Section: THeaderSection);
begin
  if Abs(FSortIndex) = Section.Index + 1 then
    SortIndex := - FSortIndex
  else
    SortIndex := Section.Index + 1;
end;

procedure THeaderControl.SectionResize(Section: THeaderSection);
begin
  Perform(WM_SIZE, 0, MAKELONG(Height, Width));  // required for AutoSize
  inherited;
end;

procedure THeaderControl.SetSortIndex(Value: Integer);
begin
  if (Value <> FSortIndex) and CanSort(Value) then
  begin
    FSortIndex := Value;
    if Assigned(FOnSort) then
      FOnSort(Self);
    Invalidate;
  end;
end;

end.