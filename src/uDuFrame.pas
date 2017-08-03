unit uDuFrame;

interface

uses Classes, Controls, Windows, Messages, uDuCompatibleDC, ExtCtrls;

type
TDuFrame=class(TWinControl)
private
  m_MemoryDC: TDuCompatibleDC;
  m_ptMouseLast, m_ptMousePos : TPoint;
  m_nMouseKey: Integer;

  m_timerMouse: TTimer;
  procedure OnMouseMoveTimer(Sender: TObject);
  //响应可视状态改变消息
  procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
  //响应大小改变消息
  procedure WMSize(var Message: TWMSize); message WM_SIZE;
  //响应绘制消息
  procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  //响应背景擦除消息
  procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  //左键按下消息响应
  procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  //左键抬起消息响应
  procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
  //双击左键消息响应
  procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
  //右键按下消息响应
  procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
  //右键抬起消息响应
  procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
  //鼠标移动消息响应
  procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  //鼠标滚轮消息响应
  procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
  //按键按下消息响应
  procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
  //按键抬起消息响应
  procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
  //设置框架的输入消息处理
  procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
public
  //构造函数
  constructor Create(AOwner: TComponent); override;
  //析构函数
  destructor Destroy; override;
end;


implementation

uses uDuControl, Forms;

{ TDuMainWindow }

procedure TDuFrame.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
end;

constructor TDuFrame.Create(AOwner: TComponent);
begin
  inherited;
  //初始化MouseMove响应频率控制器
  m_timerMouse := TTimer.Create(Self);
  m_timerMouse.Enabled := False;
  m_timerMouse.Interval := 20;
  m_timerMouse.OnTimer := OnMouseMoveTimer;
end;

destructor TDuFrame.Destroy;
begin
  if Assigned(m_MemoryDC) then m_MemoryDC.Free;
  m_timerMouse.Free;
  inherited;
end;

procedure TDuFrame.OnMouseMoveTimer(Sender: TObject);
var
  LCurPos: TPoint;
  I : Integer;
begin
  m_timerMouse.Enabled := False;
  //响应MouseMove
  if (Abs(m_ptMouseLast.X - m_ptMousePos.X) > 2) or (Abs(m_ptMouseLast.Y - m_ptMousePos.Y) > 2) then
  begin
    //记录当前鼠标位置
    m_ptMouseLast := m_ptMousePos;
    //鼠标移动了，单击状态取消
    //m_bLButtonClick := False;
  end
  else    //如果移动范围过小，则不响应，防止鼠标抖动
    Exit;

    //当前鼠标位置
  LCurPos := m_ptMousePos;

  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
      if TDuControl(Components[I]).DoOnMouseMove(m_nMouseKey, LCurPos) then
        Break;
  end;
end;

procedure TDuFrame.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TDuFrame.WMGetDlgCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS or DLGC_WANTTAB;
end;

procedure TDuFrame.WMKeyDown(var Message: TWMKeyDown);
var
  I : Integer;
begin
  inherited;
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
      if TDuControl(Components[I]).DoOnKeyDown(Message.CharCode, KeyDataToShiftState(Message.KeyData)) then
        Break;
  end;
end;

procedure TDuFrame.WMKeyUp(var Message: TWMKeyUp);
var
  I : Integer;
begin
  inherited;
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
      if TDuControl(Components[I]).DoOnKeyUp(Message.CharCode, KeyDataToShiftState(Message.KeyData)) then
        Break;
  end;
end;

procedure TDuFrame.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  I : Integer;
  LCurPos : TPoint;
begin
  inherited;
  LCurPos.X := Message.XPos;
  LCurPos.Y := Message.YPos;
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
      if TDuControl(Components[I]).DoOnLButtonDown(Message.Keys, LCurPos) then
        Break;
  end;
end;

procedure TDuFrame.WMLButtonDown(var Message: TWMLButtonDown);
var
  I : Integer;
  LCurPos : TPoint;
begin
  inherited;
  if Self.CanFocus and not Self.Focused  then
    Self.SetFocus;

  LCurPos.X := Message.XPos;
  LCurPos.Y := Message.YPos;

  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
      if TDuControl(Components[I]).DoOnLButtonDown(Message.Keys, LCurPos) then
        Break;
  end;
end;

procedure TDuFrame.WMLButtonUp(var Message: TWMLButtonUp);
var
  I : Integer;
  LCurPos : TPoint;
begin
  inherited;
  if Self.CanFocus and not Self.Focused  then
    Self.SetFocus;

  LCurPos.X := Message.XPos;
  LCurPos.Y := Message.YPos;

  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
      if TDuControl(Components[I]).DoOnLButtonUp(Message.Keys, LCurPos) then
        Break;
  end;
end;

procedure TDuFrame.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  m_ptMousePos.X := Message.XPos;
  m_ptMousePos.Y := Message.YPos;
  m_nMouseKey := Message.Keys;
  m_timerMouse.Enabled := True;
end;

procedure TDuFrame.WMMouseWheel(var Message: TWMMouseWheel);
var
  I : Integer;
begin
  inherited;
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
      if TDuControl(Components[I]).DoOnMouseWheel(Message.WheelDelta < 0) then
        Break;
  end;
end;

procedure TDuFrame.WMPaint(var Message: TWMPaint);
var
  LControl: TDuControl;
  I: Integer;
  LPs: PAINTSTRUCT;
begin
  BeginPaint(Handle, LPs);
  try
    //创建内存DC
    if not Assigned(m_MemoryDC) then
      m_MemoryDC := TDuCompatibleDC.Create(LPs.hdc);
    //设置内存DC区域
    m_MemoryDC.SetBounds(LPs.hdc, GetClientRect);

    //循环绘制子组件
    for I := 0 to Self.ComponentCount - 1 do
    begin
      if not(Self.Components[I] is TDuControl) then Continue;

      LControl := TDuControl(self.Components[I]);
      //不可见对象不绘制
      if not LControl.Visible then
        Continue;
      LControl.Paint(m_MemoryDC.DC, LPs.rcPaint);
    end;
  finally
    //恢复坐标系为框架坐标系
    SetViewportOrgEx(m_MemoryDC.DC, 0, 0, nil);
    m_MemoryDC.Blt(LPs.hdc, LPs.rcPaint);
    EndPaint(Handle, LPs);
  end;
end;

procedure TDuFrame.WMRButtonDown(var Message: TWMRButtonDown);
var
  I : Integer;
  LCurPos : TPoint;
begin
  inherited;
  if Self.CanFocus and not Self.Focused  then
    Self.SetFocus;

  LCurPos.X := Message.XPos;
  LCurPos.Y := Message.YPos;

  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
      if TDuControl(Components[I]).DoOnRButtonDown(Message.Keys, LCurPos) then
        Break;
  end;
end;

procedure TDuFrame.WMRButtonUp(var Message: TWMRButtonUp);
var
  I : Integer;
  LCurPos : TPoint;
begin
  inherited;
  if Self.CanFocus and not Self.Focused  then
    Self.SetFocus;

  LCurPos.X := Message.XPos;
  LCurPos.Y := Message.YPos;

  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
      if TDuControl(Components[I]).DoOnRButtonUp(Message.Keys, LCurPos) then
        Break;
  end;
end;

procedure TDuFrame.WMSize(var Message: TWMSize);
var
  I : Integer;
begin
  inherited;
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TDuControl then
     TDuControl(Components[I]).DoOnSizeChanged(TDuControl(Components[I]));
  end;
end;

end.
