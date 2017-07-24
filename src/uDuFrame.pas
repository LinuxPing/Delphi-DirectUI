unit uDuFrame;

interface

uses Classes, Controls, Windows, Messages, uDuMemoryDC;

type
TDuFrame=class(TWinControl)
private
   m_MemoryDC: TDuMemoryDC;

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

uses uDuControl;

{ TDuMainWindow }

procedure TDuFrame.CMVisibleChanged(var Message: TMessage);
begin

end;

constructor TDuFrame.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TDuFrame.Destroy;
begin

  inherited;
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
begin

end;

procedure TDuFrame.WMKeyUp(var Message: TWMKeyUp);
begin

end;

procedure TDuFrame.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin

end;

procedure TDuFrame.WMLButtonDown(var Message: TWMLButtonDown);
begin

end;

procedure TDuFrame.WMLButtonUp(var Message: TWMLButtonUp);
begin

end;

procedure TDuFrame.WMMouseMove(var Message: TWMMouseMove);
begin

end;

procedure TDuFrame.WMMouseWheel(var Message: TWMMouseWheel);
begin

end;

procedure TDuFrame.WMPaint(var Message: TWMPaint);
var
  LControl: TDuControl;
  I: Integer;
  LCompatibleDC: HDC;
  LPs: PAINTSTRUCT;
begin
  BeginPaint(Handle, LPs);
  try
    //创建内存DC
    if not Assigned(m_MemoryDC) then
      m_MemoryDC := TDuMemoryDC.Create(LPs.hdc);
    //设置内存DC区域
    m_MemoryDC.SetBounds(LPs.hdc, GetClientRect);

    //循环绘制浮动组件
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
begin

end;

procedure TDuFrame.WMRButtonUp(var Message: TWMRButtonUp);
begin

end;

procedure TDuFrame.WMSize(var Message: TWMSize);
begin

end;

end.
