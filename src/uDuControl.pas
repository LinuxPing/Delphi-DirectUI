unit uDuControl;

interface

uses Classes, Windows, Types;

type

  //������������ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  TOnLButtonDown = function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
  //��������̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  TOnLButtonUp =function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
  //������Ҽ�����ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  TOnRButtonDown=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
  //������Ҽ�̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  TOnRButtonUp=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
  //������ƶ�ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  TOnMouseMove=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
  //������������ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
  TOnLButtonClick=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
  //��������˫��ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
  TOnLButtonDblClk=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
  //��������ʱ�������¼�--�н������Ӧ
  TOnMouseWheel=function (AIsDown: Boolean): Boolean of object;
  //�����¼�
  TOnKey= function (ACharCode: Word; Shift: TShiftState): Boolean of object;


TDuControl=class(TComponent)
private
  FLeft, FTop, FWidth, FHeight: Integer;
  FVisible: Boolean;

  //�������С�ı�󴥷����¼�
  FOnSizeChanged: TNotifyEvent;

  //������������ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  FOnLButtonDown: TOnLButtonDown;
  //��������̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  FOnLButtonUp:TOnLButtonUp;
  //������Ҽ�����ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  FOnRButtonDown:TOnRButtonDown;
  //������Ҽ�̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  FOnRButtonUp:TOnRButtonUp;
  //������ƶ�ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  FOnMouseMove:TOnMouseMove;
  //������������ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
  FOnLButtonClick:TOnLButtonClick;
  //��������˫��ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
  FOnLButtonDblClk:TOnLButtonDblClk;
  //��������ʱ�������¼�--�н������Ӧ
  FOnMouseWheel: TOnMouseWheel;
  //�����¼�
  FOnKeyDown,
  FOnKeyUp:TOnKey;
  //�������¼�
  FOnMouseEnter,
  //����뿪�¼�
  FOnMouseLeave: TNotifyEvent;

  function GetBounds: TRect;
  procedure SetVisible(const Value: Boolean);
protected
    //���ƻ��汳��
    procedure PaintBkg(DC: HDC; AControlRect, AInvalidateRect: TRect);virtual;
    //��������
    procedure PaintContent(DC: HDC; AControlRect, AInvalidateRect: TRect);virtual;
    //����ǰ��
    procedure PaintForeground(DC: HDC; AControlRect, AInvalidateRect: TRect);virtual;
    //���Ʊ߿�
    procedure DrawBorder(DC: HDC; AControlRect: TRect);virtual;
public
    constructor Create(AOwner: TDuControl); reintroduce;
    //�����ɿ������ϵת�������ϵ
    function FrameToControlRect(const AFrameRect: TRect): TRect;
    //�������������ϵת�������ϵ
    function ControlToFrameRect(const AControlRect: TRect): TRect;
    //������ɿ������ϵת�������ϵ
    function FrameToControlPoint(const AFramePoint: TPoint): TPoint;
    //��������������ϵת�������ϵ
    function ControlToFramePoint(const AControlPoint: TPoint): TPoint;

    //�������
    //����1�����DC
    //����2��ˢ������(�ڿ������ϵ��)
    procedure Paint(DC: HDC; AInvalidateRect: TRect); virtual;

    //�������С�ı�󴥷����¼�
    procedure DoOnSizeChanged(Sender: TObject); virtual;
    //������������ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function DoOnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //��������̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function DoOnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //������Ҽ�����ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function DoOnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //������Ҽ�̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function DoOnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //������ƶ�ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function DoOnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //������������ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
    function DoOnLButtonClick(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //��������˫��ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
    function DoOnLButtonDblClk(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //��������ʱ�������¼�--�н������Ӧ
    function DoOnMouseWheel(AIsDown: Boolean): Boolean; virtual;
    //��������ʱ�������¼�--�н������Ӧ
    function DoOnKeyDown(ACharCode: Word; Shift: TShiftState): Boolean; virtual;
    //����̧��ʱ�������¼�--�н������Ӧ
    function DoOnKeyUp(ACharCode: Word; Shift: TShiftState): Boolean; virtual;
    //�������¼�
    procedure DoOnMouseEnter(Sender: TObject);
    //����뿪�¼�
    procedure DoOnMouseLeave(Sender: TObject);
    //�ؼ��Ƿ�ɼ�
    property Visible:Boolean read FVisible write SetVisible;
    property Bounds: TRect read GetBounds;
published
    //�������С�ı�󴥷����¼�
    property OnSizeChanged: TNotifyEvent read FOnSizeChanged write FOnSizeChanged;
    //������������ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    property OnLButtonDown: TOnLButtonDown read FOnLButtonDown write FOnLButtonDown;
    //��������̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    property OnLButtonUp:TOnLButtonUp read FOnLButtonUp write FOnLButtonUp;
    //������Ҽ�����ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    property OnRButtonDown:TOnRButtonDown read FOnRButtonDown write FOnRButtonDown;
    //������Ҽ�̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    property OnRButtonUp:TOnRButtonUp read FOnRButtonUp write FOnRButtonUp;
    //������ƶ�ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    property OnMouseMove:TOnMouseMove read FOnMouseMove write FOnMouseMove;
    //������������ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
    property OnLButtonClick:TOnLButtonClick read FOnLButtonClick write FOnLButtonClick;
    //��������˫��ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
    property OnLButtonDblClk:TOnLButtonDblClk read FOnLButtonDblClk write FOnLButtonDblClk;
    //��������ʱ�������¼�--�н������Ӧ
    property OnMouseWheel: TOnMouseWheel read FOnMouseWheel write FOnMouseWheel;
    //�����¼�
    property OnKeyDown:TOnKey  read FOnKeyDown write FOnKeyDown;
    property OnKeyUp:TOnKey read FOnKeyUp write FOnKeyUp;
    //�������¼�
    property OnMouseEnter:TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    //����뿪�¼�
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
end;

implementation

{ TDuControl }

function TDuControl.ControlToFramePoint(const AControlPoint: TPoint): TPoint;
begin
  Result.X := AControlPoint.X + FLeft;
  Result.Y := AControlPoint.Y + FTop;
end;

function TDuControl.ControlToFrameRect(const AControlRect: TRect): TRect;
begin
  Result := AControlRect;
  OffsetRect(Result, FLeft, FTop);
end;

constructor TDuControl.Create(AOwner: TDuControl);
begin
  inherited Create(AOwner);
  FVisible := False;
end;

procedure TDuControl.DrawBorder(DC: HDC; AControlRect: TRect);
begin

end;

function TDuControl.FrameToControlPoint(const AFramePoint: TPoint): TPoint;
begin
  Result.X := AFramePoint.X - FLeft;
  Result.Y := AFramePoint.Y - FTop;
end;

function TDuControl.FrameToControlRect(const AFrameRect: TRect): TRect;
begin
  Result := AFrameRect;
  OffsetRect(Result, -FLeft, -FTop);
end;

function TDuControl.GetBounds: TRect;
begin
  Result := Rect(FLeft, FTop, FLeft + FWidth, FTop + FHeight);
end;

function TDuControl.DoOnKeyDown(ACharCode: Word; Shift: TShiftState): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnKeyDown) then Result := FOnKeyDown(ACharCode, Shift);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnKeyDown) then
      begin
        Result := TDuControl(Self.Components[I]).FOnKeyDown(ACharCode, Shift);
        if Result then Exit;
      end;
  end;
end;

function TDuControl.DoOnKeyUp(ACharCode: Word; Shift: TShiftState): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnKeyUp) then Result := FOnKeyUp(ACharCode, Shift);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnKeyUp) then
      begin
        Result := TDuControl(Self.Components[I]).FOnKeyUp(ACharCode, Shift);
        if Result then Exit;
      end;
  end;
end;

function TDuControl.DoOnLButtonClick(AFlags: UINT; var AMousePt: TPoint): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnLButtonClick) then Result := FOnLButtonClick(AFlags, AMousePt);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnLButtonClick) then
      begin
        Result := TDuControl(Self.Components[I]).FOnLButtonClick(AFlags, AMousePt);
        if Result then Exit;
      end;
  end;
end;

function TDuControl.DoOnLButtonDblClk(AFlags: UINT;
  var AMousePt: TPoint): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnLButtonClick) then Result := FOnLButtonClick(AFlags, AMousePt);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnLButtonClick) then
      begin
        Result := TDuControl(Self.Components[I]).FOnLButtonClick(AFlags, AMousePt);
        if Result then Exit;
      end;
  end;
end;

function TDuControl.DoOnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnLButtonDown) then Result := FOnLButtonDown(AFlags, AMousePt);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnLButtonDown) then
      begin
        Result := TDuControl(Self.Components[I]).FOnLButtonDown(AFlags, AMousePt);
        if Result then Exit;
      end;
  end;
end;

function TDuControl.DoOnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnLButtonUp) then Result := FOnLButtonUp(AFlags, AMousePt);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnLButtonUp) then
      begin
        Result := TDuControl(Self.Components[I]).FOnLButtonUp(AFlags, AMousePt);
        if Result then Exit;
      end;
  end;
end;

procedure TDuControl.DoOnMouseEnter(Sender: TObject);
begin

end;

procedure TDuControl.DoOnMouseLeave(Sender: TObject);
begin

end;

function TDuControl.DoOnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnMouseMove) then Result := FOnMouseMove(AFlags, AMousePt);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnMouseMove) then
      begin
        Result := TDuControl(Self.Components[I]).FOnMouseMove(AFlags, AMousePt);
        if Result then Exit;
      end;
  end;
end;

function TDuControl.DoOnMouseWheel(AIsDown: Boolean): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnMouseWheel) then Result := FOnMouseWheel(AIsDown);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnMouseWheel) then
      begin
        Result := TDuControl(Self.Components[I]).FOnMouseWheel(AIsDown);
        if Result then Exit;
      end;
  end;
end;

function TDuControl.DoOnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnRButtonDown) then Result := FOnRButtonDown(AFlags, AMousePt);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnRButtonDown) then
      begin
        Result := TDuControl(Self.Components[I]).FOnRButtonDown(AFlags, AMousePt);
        if Result then Exit;
      end;
  end;
end;

function TDuControl.DoOnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean;
var
  I : Integer;
begin
  Result := False;
  if Assigned(FOnRButtonUp) then Result := FOnRButtonUp(AFlags, AMousePt);
  if Result then Exit;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnRButtonUp) then
      begin
        Result := TDuControl(Self.Components[I]).FOnRButtonUp(AFlags, AMousePt);
        if Result then Exit;
      end;
  end;
end;

procedure TDuControl.DoOnSizeChanged(Sender: TObject);
var
  I : Integer;
begin
  if Assigned(FOnSizeChanged) then FOnSizeChanged(Sender);

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TDuControl then
      if Assigned(TDuControl(Self.Components[I]).FOnSizeChanged) then
      begin
        TDuControl(Self.Components[I]).FOnSizeChanged(Components[I]);
      end;
  end;
end;

procedure TDuControl.Paint(DC: HDC; AInvalidateRect: TRect);
var
  LCompRect, LInvalidateRect: TRect;
  I : Integer;
begin
  if not Visible then Exit;

  //����ˢ������͸���������Ƿ����ص�������������
  if Types.IntersectRect(LInvalidateRect, Bounds, AInvalidateRect) then
  begin
    //���豸����ӳ�䵽��ǰ�������ϵ
    SetViewportOrgEx(DC, FLeft, FTop, nil);
    LCompRect := FrameToControlRect(Bounds);
    LInvalidateRect := FrameToControlRect(LInvalidateRect);
    //���ƻ��汳��
    PaintBkg(DC, LCompRect, LInvalidateRect);
    //��������
    PaintContent(DC, LCompRect, LInvalidateRect);
    //����ǰ��
    PaintForeground(DC, LCompRect, LInvalidateRect);
    //���Ʊ߿�
    DrawBorder(DC, LCompRect);
    //�����ӿռ�
    for I := 0 to ComponentCount - 1 do
    begin
      if Components[I] is TDuControl then
        TDuControl(Components[I]).Paint(DC, AInvalidateRect);
    end;
  end;
end;

procedure TDuControl.PaintBkg(DC: HDC; AControlRect, AInvalidateRect: TRect);
begin
end;

procedure TDuControl.PaintContent(DC: HDC; AControlRect, AInvalidateRect: TRect);
begin
end;

procedure TDuControl.PaintForeground(DC: HDC; AControlRect, AInvalidateRect: TRect);
begin
end;

procedure TDuControl.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

end.
