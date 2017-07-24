unit uDuFrame;

interface

uses Classes, Controls, Windows, Messages, uDuMemoryDC;

type
TDuFrame=class(TWinControl)
private
   m_MemoryDC: TDuMemoryDC;

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
    //�����ڴ�DC
    if not Assigned(m_MemoryDC) then
      m_MemoryDC := TDuMemoryDC.Create(LPs.hdc);
    //�����ڴ�DC����
    m_MemoryDC.SetBounds(LPs.hdc, GetClientRect);

    //ѭ�����Ƹ������
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
begin

end;

procedure TDuFrame.WMRButtonUp(var Message: TWMRButtonUp);
begin

end;

procedure TDuFrame.WMSize(var Message: TWMSize);
begin

end;

end.
