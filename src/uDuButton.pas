unit uDuButton;

interface

uses Classes, uDuControl, Windows, Graphics;

type

TDuButton= class(TDuControl)
private
  FDisabledBmp, //��ť��Чʱʹ�õ�ͼƬ
  FDownBmp,    //��ť����ʱʹ�õ�ͼƬ
  FUpBmp,      //��ť����ʱʹ�õ�ͼƬ
  FUpAndFocusedBmp: TBitmap;  //��ť����ӵ�н���ʱʹ�õ�ͼƬ

  m_Focused, //�Ƿ�ӵ�н���
  FDown,    //�Ƿ���
  FEnabled: Boolean; //�Ƿ����
protected
  //��������
  procedure PaintContent(DC: HDC; AControlRect, AInvalidateRect: TRect);override;

  //������������ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  function DoOnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //��������̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  function DoOnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //������Ҽ�����ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  function DoOnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //������Ҽ�̧��ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  function DoOnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //������ƶ�ʱ�������¼�(ȫ�����Ӧ��AMousePt�ڿ������ϵ)
  function DoOnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //�������¼�
  procedure DoOnMouseEnter(Sender: TObject); override;
  //����뿪�¼�
  procedure DoOnMouseLeave(Sender: TObject); override;
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy;override;
published
  property DisabledBmp: TBitmap read FDisabledBmp;//��ť��Чʱʹ�õ�ͼƬ
  property DownBmp: TBitmap read FDownBmp;    //��ť����ʱʹ�õ�ͼƬ
  property UpBmp: TBitmap read FUpBmp;     //��ť����ʱʹ�õ�ͼƬ
  property UpAndFocusedBmp: TBitmap read FUpAndFocusedBmp;  //��ť����ӵ�н���ʱʹ�õ�ͼƬ

  property Down:Boolean read FDown write FDown;
  property Enabled:Boolean read FEnabled write FEnabled;
end;

implementation

{ TDuButton }

constructor TDuButton.Create(AOwner: TComponent);
begin
  inherited;
  FDisabledBmp:= TBitmap.Create; //��ť��Чʱʹ�õ�ͼƬ
  FDownBmp:= TBitmap.Create;   //��ť����ʱʹ�õ�ͼƬ
  FUpBmp:= TBitmap.Create;     //��ť����ʱʹ�õ�ͼƬ
  FUpAndFocusedBmp:= TBitmap.Create;  //��ť����ӵ�н���ʱʹ�õ�ͼƬ
  FDown := False;
  m_Focused := False;
  FEnabled := True;
end;

destructor TDuButton.Destroy;
begin
  FDisabledBmp.Free;
  FDownBmp.Free;
  FUpBmp.Free;
  FUpAndFocusedBmp.Free;
  inherited;
end;

function TDuButton.DoOnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  inherited;
  if FEnabled then
  begin
     m_Focused := True;
     FDown := True;
  end;
end;

function TDuButton.DoOnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  inherited;
  if FEnabled then
  begin
     m_Focused := True;
     FDown := False;
  end;
end;

procedure TDuButton.DoOnMouseEnter(Sender: TObject);
begin
  inherited;
end;

procedure TDuButton.DoOnMouseLeave(Sender: TObject);
begin
  inherited;
end;

function TDuButton.DoOnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  inherited;
end;

function TDuButton.DoOnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  inherited;
  if FEnabled then
  begin
     m_Focused := True;
     FDown := True;
  end;
end;

function TDuButton.DoOnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean;
begin
  inherited;
  if FEnabled then
  begin
     m_Focused := True;
     FDown := False;
  end;
end;

procedure TDuButton.PaintContent(DC: HDC; AControlRect, AInvalidateRect: TRect);
var
  LBitmap : TBitmap;
begin
  LBitmap := nil;
  if not FEnabled then
    LBitmap := FDisabledBmp
  else if m_Focused and not FDown then
    LBitmap := FUpAndFocusedBmp
  else if m_Focused and FDown then
    LBitmap := FDownBmp
  else
    LBitmap:= FUpBmp;

  if LBitmap.Empty then Exit;

  BitBlt(DC, Left, Top, Width, Height, LBitmap.Canvas.Handle, 0, 0, SRCCOPY);
end;

end.
