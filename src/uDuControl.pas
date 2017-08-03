unit uDuControl;

interface

uses Classes, Windows, Types, Controls;

type

//当鼠标左键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
TOnLButtonDown = function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
//当鼠标左键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
TOnLButtonUp =function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
//当鼠标右键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
TOnRButtonDown=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
//当鼠标右键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
TOnRButtonUp=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
//当鼠标移动时触发的事件(全框架响应，AMousePt在框架坐标系)
TOnMouseMove=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
//当鼠标左键单击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
TOnLButtonClick=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
//当鼠标左键双击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
TOnLButtonDblClk=function (AFlags: UINT; var AMousePt: TPoint): Boolean of object;
//当鼠标滚轮时触发的事件--有焦点才响应
TOnMouseWheel=function (AIsDown: Boolean): Boolean of object;
//按键事件
TOnKey= function (ACharCode: Word; Shift: TShiftState): Boolean of object;


TDuControl=class(TComponent)
private
  FLeft, FTop, FWidth, FHeight: Integer;
  FVisible: Boolean;
  FAlign : TAlign;
  m_Owner: TComponent;

  //当组件大小改变后触发的事件
  FOnSizeChanged: TNotifyEvent;

  //当鼠标左键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
  FOnLButtonDown: TOnLButtonDown;
  //当鼠标左键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
  FOnLButtonUp:TOnLButtonUp;
  //当鼠标右键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
  FOnRButtonDown:TOnRButtonDown;
  //当鼠标右键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
  FOnRButtonUp:TOnRButtonUp;
  //当鼠标移动时触发的事件(全框架响应，AMousePt在框架坐标系)
  FOnMouseMove:TOnMouseMove;
  //当鼠标左键单击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
  FOnLButtonClick:TOnLButtonClick;
  //当鼠标左键双击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
  FOnLButtonDblClk:TOnLButtonDblClk;
  //当鼠标滚轮时触发的事件--有焦点才响应
  FOnMouseWheel: TOnMouseWheel;
  //按键事件
  FOnKeyDown,
  FOnKeyUp:TOnKey;
  //鼠标进入事件
  FOnMouseEnter,
  //鼠标离开事件
  FOnMouseLeave: TNotifyEvent;

  function GetBounds: TRect;
  procedure SetVisible(const Value: Boolean);
  procedure SetAlign(const Value: TAlign);
  procedure SetHeight(const Value: Integer);
  procedure SetLeft(const Value: Integer);
  procedure SetTop(const Value: Integer);
  procedure SetWidth(const Value: Integer);

  procedure RealignChildControls;
protected
    //绘制缓存背景
    procedure PaintBkg(DC: HDC; AControlRect, AInvalidateRect: TRect);virtual;
    //绘制内容
    procedure PaintContent(DC: HDC; AControlRect, AInvalidateRect: TRect);virtual;
    //绘制前景
    procedure PaintForeground(DC: HDC; AControlRect, AInvalidateRect: TRect);virtual;
    //绘制边框
    procedure PaintBorder(DC: HDC; AControlRect: TRect);virtual;
public
    constructor Create(AOwner: TComponent); reintroduce;
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
    procedure DoOnSizeChanged(Sender: TObject); virtual;
    //当鼠标左键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
    function DoOnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标左键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
    function DoOnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标右键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
    function DoOnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标右键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
    function DoOnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标移动时触发的事件(全框架响应，AMousePt在框架坐标系)
    function DoOnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标左键单击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
    function DoOnLButtonClick(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标左键双击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
    function DoOnLButtonDblClk(AFlags: UINT; var AMousePt: TPoint): Boolean; virtual;
    //当鼠标滚轮时触发的事件--有焦点才响应
    function DoOnMouseWheel(AIsDown: Boolean): Boolean; virtual;
    //当键按下时触发的事件--有焦点才响应
    function DoOnKeyDown(ACharCode: Word; Shift: TShiftState): Boolean; virtual;
    //当键抬起时触发的事件--有焦点才响应
    function DoOnKeyUp(ACharCode: Word; Shift: TShiftState): Boolean; virtual;
    //鼠标进入事件
    procedure DoOnMouseEnter(Sender: TObject);
    //鼠标离开事件
    procedure DoOnMouseLeave(Sender: TObject);
    //控件是否可见
    property Visible:Boolean read FVisible write SetVisible;
    property Bounds: TRect read GetBounds;
published
    //当组件大小改变后触发的事件
    property OnSizeChanged: TNotifyEvent read FOnSizeChanged write FOnSizeChanged;
    //当鼠标左键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
    property OnLButtonDown: TOnLButtonDown read FOnLButtonDown write FOnLButtonDown;
    //当鼠标左键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
    property OnLButtonUp:TOnLButtonUp read FOnLButtonUp write FOnLButtonUp;
    //当鼠标右键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
    property OnRButtonDown:TOnRButtonDown read FOnRButtonDown write FOnRButtonDown;
    //当鼠标右键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
    property OnRButtonUp:TOnRButtonUp read FOnRButtonUp write FOnRButtonUp;
    //当鼠标移动时触发的事件(全框架响应，AMousePt在框架坐标系)
    property OnMouseMove:TOnMouseMove read FOnMouseMove write FOnMouseMove;
    //当鼠标左键单击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
    property OnLButtonClick:TOnLButtonClick read FOnLButtonClick write FOnLButtonClick;
    //当鼠标左键双击时触发的事件(鼠标所在的组件响应，AMousePt在框架坐标系)
    property OnLButtonDblClk:TOnLButtonDblClk read FOnLButtonDblClk write FOnLButtonDblClk;
    //当鼠标滚轮时触发的事件--有焦点才响应
    property OnMouseWheel: TOnMouseWheel read FOnMouseWheel write FOnMouseWheel;
    //按键事件
    property OnKeyDown:TOnKey  read FOnKeyDown write FOnKeyDown;
    property OnKeyUp:TOnKey read FOnKeyUp write FOnKeyUp;
    //鼠标进入事件
    property OnMouseEnter:TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    //鼠标离开事件
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;

    property Align : TAlign read FAlign write SetAlign;
    property Left : Integer read FLeft write SetLeft;
    property Top : Integer read FTop write SetTop;
    property Width : Integer read FWidth write SetWidth;
    property Height : Integer read FHeight write SetHeight;
end;

implementation

uses uDuFrame, TypInfo;

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

constructor TDuControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVisible := False;
  FAlign := alNone;
  m_Owner := AOwner;
end;

procedure TDuControl.PaintBorder(DC: HDC; AControlRect: TRect);
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
        Result := TDuControl(Self.Components[I]).DoOnKeyDown(ACharCode, Shift);
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
        Result := TDuControl(Self.Components[I]).DoOnKeyUp(ACharCode, Shift);
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
        Result := TDuControl(Self.Components[I]).DoOnLButtonClick(AFlags, AMousePt);
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
        Result := TDuControl(Self.Components[I]).DoOnLButtonDblClk(AFlags, AMousePt);
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
        Result := TDuControl(Self.Components[I]).DoOnLButtonDown(AFlags, AMousePt);
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
        Result := TDuControl(Self.Components[I]).DoOnLButtonUp(AFlags, AMousePt);
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
        Result := TDuControl(Self.Components[I]).DoOnMouseMove(AFlags, AMousePt);
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
        Result := TDuControl(Self.Components[I]).DoOnMouseWheel(AIsDown);
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
        Result := TDuControl(Self.Components[I]).DoOnRButtonDown(AFlags, AMousePt);
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
        Result := TDuControl(Self.Components[I]).DoOnRButtonUp(AFlags, AMousePt);
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
        TDuControl(Self.Components[I]).DoOnSizeChanged(Components[I]);
      end;
  end;

  SetAlign(FAlign);
end;

procedure TDuControl.Paint(DC: HDC; AInvalidateRect: TRect);
var
  LCompRect, LInvalidateRect: TRect;
  I : Integer;
begin
  if not Visible then Exit;

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
    PaintBorder(DC, LCompRect);
    //绘制子控件
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

procedure TDuControl.RealignChildControls;
var
  I : Integer;
  LCtrl: TDuControl;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I]  is TDuControl then
    begin
      LCtrl :=TDuControl(Components[I]);
      LCtrl.SetAlign(LCtrl.Align);
    end;
  end;
end;

procedure TDuControl.SetAlign(const Value: TAlign);
var
  LLeft, LTop, LWidth, LHeight: Integer;
begin
  FAlign := Value;
  if not( (m_Owner is TDuControl) or (m_Owner is TDuFrame) )then Exit;

  LLeft := GetPropValue(m_Owner, 'Left');
  LTop:=  GetPropValue(m_Owner, 'Top');
  LWidth:= GetPropValue(m_Owner, 'Width');
  LHeight := GetPropValue(m_Owner, 'Height');

  case Value of
    alNone: ;
    alTop:
    begin
      FLeft := LLeft;
      FTop := LTop;
      FWidth := LWidth;
    end;

    alBottom:
    begin
      FLeft := LLeft;
      FTop := LTop + LHeight - FHeight;
      FWidth := LWidth;
    end;

    alLeft:
    begin
      FLeft := LLeft;
      FTop := LTop;
      FHeight := LHeight;
    end;

    alRight:
    begin
      FLeft := LLeft + LWidth - FWidth;
      FTop := LTop;
      FHeight := LHeight;
    end;

    alClient:
    begin
      FLeft := LLeft;
      FTop := LTop;
      FWidth := LWidth;
      FHeight := LHeight;
    end;
    alCustom: ;
  end;

end;

procedure TDuControl.SetHeight(const Value: Integer);
begin
  if Value = FHeight then Exit;
  if Align in [alClient, alLeft, alRight] then Exit;
  FHeight := Value;
  RealignChildControls;
end;

procedure TDuControl.SetLeft(const Value: Integer);
begin
  if Value = FLeft then Exit;
  if Align in [alLeft, alTop, alBottom, alClient] then Exit;
  FLeft := Value;
  RealignChildControls;
end;

procedure TDuControl.SetTop(const Value: Integer);
begin
  if Value = FTop then Exit;
  if Align in [alTop, alLeft, alClient] then Exit;
  FTop := Value;
  RealignChildControls;
end;

procedure TDuControl.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

procedure TDuControl.SetWidth(const Value: Integer);
begin
  if Value = FWidth then Exit;
  if Align in [alClient, alTop, alBottom] then Exit;
  FWidth := Value;
  RealignChildControls;
end;

end.
