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
    //绘制缓存背景
    procedure PaintBkg(DC: HDC; AControlRect, AInvalidateRect: TRect);virtual;
    //绘制内容
    procedure PaintContent(DC: HDC; AControlRect, AInvalidateRect: TRect);virtual;
    //绘制前景
    procedure PaintForeground(DC: HDC; AControlRect, AInvalidateRect: TRect);virtual;
    //绘制边框
    procedure DrawBorder(DC: HDC; AControlRect: TRect);virtual;


public
    //区域由框架坐标系转组件坐标系
    function FrameToControlRect(const AFrameRect: TRect): TRect;
    //区域由组件坐标系转框架坐标系
    function ControlToFrameRect(const AControlRect: TRect): TRect;
    //坐标点由框架坐标系转组件坐标系
    function FrameToControlPoint(const AFramePoint: TPoint): TPoint;
    //坐标点由组件坐标系转框架坐标系
    function ControlToFramePoint(const AControlPoint: TPoint): TPoint;

    //组件绘制
    //参数1：框架DC
    //参数2：刷新区域(在框架坐标系下)
    procedure Paint(DC: HDC; AInvalidateRect: TRect); virtual;

    //当组件大小改变后触发的事件
    procedure OnSizeChanged; virtual;
    //分配空间后显示前调用是否触发Show事件
    procedure OnInnerShow;
    //当鼠标左键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
    function OnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标左键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
    function OnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标右键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
    function OnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标右键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
    function OnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标移动时触发的事件(全框架响应，AMousePt在框架坐标系)
    function OnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标左键单击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
    function OnLButtonClick(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标左键双击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
    function OnLButtonDblClk(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标滚轮时触发的事件--有焦点才响应
    function OnMouseWheel(AIsDown: Boolean): Boolean; virtual;
    //当键按下时触发的事件--有焦点才响应
    function OnKeyDown(ACharCode: Word; Shift: TShiftState): Boolean; virtual;
    //当键抬起时触发的事件--有焦点才响应
    function OnKeyUp(ACharCode: Word; Shift: TShiftState): Boolean; virtual;

    property Visible:Boolean read FVisible write SetVisible;
    property Bounds: TRect read GetBounds;
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

function TDuControl.OnKeyDown(ACharCode: Word; Shift: TShiftState): Boolean;
begin
  Result := False;
end;

function TDuControl.OnKeyUp(ACharCode: Word; Shift: TShiftState): Boolean;
begin
  Result := False;
end;

function TDuControl.OnLButtonClick(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  Result := False;
end;

function TDuControl.OnLButtonDblClk(AFlags: UINT;
  var AMousePt: TPoint): Boolean;
begin
  Result := False;
end;

function TDuControl.OnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  Result := False;
end;

function TDuControl.OnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  Result := False;
end;

function TDuControl.OnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  Result := False;
end;

function TDuControl.OnMouseWheel(AIsDown: Boolean): Boolean;
begin
  Result := False;
end;

function TDuControl.OnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  Result := False;
end;

function TDuControl.OnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  Result := False;
end;

procedure TDuControl.OnSizeChanged;
begin
end;

procedure TDuControl.Paint(DC: HDC; AInvalidateRect: TRect);
var
  LCompRect, LInvalidateRect: TRect;
  I : Integer;
begin
  //计算刷新区域和该组件区域是否有重叠，有则绘制组件
  if Types.IntersectRect(LInvalidateRect, Bounds, AInvalidateRect) then
  begin
    //将设备坐标映射到当前组件坐标系
    SetViewportOrgEx(DC, FLeft, FTop, nil);
    LCompRect := FrameToControlRect(Bounds);
    LInvalidateRect := FrameToControlRect(LInvalidateRect);
    //绘制缓存背景
    PaintBkg(DC, LCompRect, LInvalidateRect);
    //绘制内容
    PaintContent(DC, LCompRect, LInvalidateRect);
    //绘制前景
    PaintForeground(DC, LCompRect, LInvalidateRect);
    //绘制边框
    DrawBorder(DC, LCompRect);
    //绘制子空间
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
