unit uDuControl;

interface

uses Classes, Windows, Types;

type
TDuControl=class(TComponent)
private
  FLeft, FTop, FWidth, FHeight: Integer;
  FVisible: Boolean;
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
    //�����ɿ������ϵת�������ϵ
    function FrameToControlRect(const AFrameRect: TRect): TRect;
    //�������������ϵת�������ϵ
    function ControlToFrameRect(const ACompRect: TRect): TRect;
    //������ɿ������ϵת�������ϵ
    function FrameToControlPoint(const AFramePoint: TPoint): TPoint;
    //��������������ϵת�������ϵ
    function ControlToFramePoint(const ACompPoint: TPoint): TPoint;

    //�������
    //����1�����DC
    //����2��ˢ������(�ڿ������ϵ��)
    procedure Paint(DC: HDC; AInvalidateRect: TRect); virtual;

    //�������С�ı�󴥷����¼�
    procedure OnSizeChanged; virtual;
    //����ռ����ʾǰ�����Ƿ񴥷�Show�¼�
    procedure OnInnerShow;
    //������������ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function OnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //��������̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function OnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //������Ҽ�����ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function OnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //������Ҽ�̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function OnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //������ƶ�ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
    function OnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //������������ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
    function OnLButtonClick(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //��������˫��ʱ�������¼�(������ڵ������Ӧ��AMousePt�ڿ������ϵ)
    function OnLButtonDblClk(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //��������ʱ�������¼�--�н������Ӧ
    function OnMouseWheel(AIsDown: Boolean): Boolean; virtual;
    //��������ʱ�������¼�--�н������Ӧ
    function OnKeyDown(ACharCode: Word; AKeyData: LongInt): Boolean; virtual;
    //����̧��ʱ�������¼�--�н������Ӧ
    function OnKeyUp(ACharCode: Word; AKeyData: LongInt): Boolean; virtual;

    property Visible:Boolean read FVisible write SetVisible;
    property Bounds: TRect read GetBounds;
end;

implementation

{ TDuControl }

function TDuControl.ControlToFramePoint(const ACompPoint: TPoint): TPoint;
begin
  Result.X := ACompPoint.X + FLeft;
  Result.Y := ACompPoint.Y + FTop;
end;

function TDuControl.ControlToFrameRect(const ACompRect: TRect): TRect;
begin
  Result := ACompRect;
  OffsetRect(Result, FLeft, FTop);
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

procedure TDuControl.OnInnerShow;
begin

end;

function TDuControl.OnKeyDown(ACharCode: Word; AKeyData: Integer): Boolean;
begin

end;

function TDuControl.OnKeyUp(ACharCode: Word; AKeyData: Integer): Boolean;
begin

end;

function TDuControl.OnLButtonClick(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin

end;

function TDuControl.OnLButtonDblClk(AFlags: UINT;
  var AMousePt: TPoint): Boolean;
begin

end;

function TDuControl.OnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin

end;

function TDuControl.OnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin

end;

function TDuControl.OnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin

end;

function TDuControl.OnMouseWheel(AIsDown: Boolean): Boolean;
begin

end;

function TDuControl.OnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin

end;

function TDuControl.OnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin

end;

procedure TDuControl.OnSizeChanged;
begin

end;

procedure TDuControl.Paint(DC: HDC; AInvalidateRect: TRect);
var
  LCompRect, LInvalidateRect: TRect;
begin
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
