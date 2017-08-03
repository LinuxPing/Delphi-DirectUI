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
  //��Ӧ����״̬�ı���Ϣ
  procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
  //��Ӧ��С�ı���Ϣ
  procedure WMSize(var Message: TWMSize); message WM_SIZE;
  //��Ӧ������Ϣ
  procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  //��Ӧ����������Ϣ
  procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  //���������Ϣ��Ӧ
  procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  //���̧����Ϣ��Ӧ
  procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
  //˫�������Ϣ��Ӧ
  procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
  //�Ҽ�������Ϣ��Ӧ
  procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
  //�Ҽ�̧����Ϣ��Ӧ
  procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
  //����ƶ���Ϣ��Ӧ
  procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  //��������Ϣ��Ӧ
  procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
  //����������Ϣ��Ӧ
  procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
  //����̧����Ϣ��Ӧ
  procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
  //���ÿ�ܵ�������Ϣ����
  procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
public
  //���캯��
  constructor Create(AOwner: TComponent); override;
  //��������
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
  //��ʼ��MouseMove��ӦƵ�ʿ�����
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
  //��ӦMouseMove
  if (Abs(m_ptMouseLast.X - m_ptMousePos.X) > 2) or (Abs(m_ptMouseLast.Y - m_ptMousePos.Y) > 2) then
  begin
    //��¼��ǰ���λ��
    m_ptMouseLast := m_ptMousePos;
    //����ƶ��ˣ�����״̬ȡ��
    //m_bLButtonClick := False;
  end
  else    //����ƶ���Χ��С������Ӧ����ֹ��궶��
    Exit;

    //��ǰ���λ��
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
    //�����ڴ�DC
    if not Assigned(m_MemoryDC) then
      m_MemoryDC := TDuCompatibleDC.Create(LPs.hdc);
    //�����ڴ�DC����
    m_MemoryDC.SetBounds(LPs.hdc, GetClientRect);

    //ѭ�����������
    for I := 0 to Self.ComponentCount - 1 do
    begin
      if not(Self.Components[I] is TDuControl) then Continue;

      LControl := TDuControl(self.Components[I]);
      //���ɼ����󲻻���
      if not LControl.Visible then
        Continue;
      LControl.Paint(m_MemoryDC.DC, LPs.rcPaint);
    end;
  finally
    //�ָ�����ϵΪ�������ϵ
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
