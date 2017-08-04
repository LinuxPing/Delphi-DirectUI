unit uDuButton;

interface

uses Classes, uDuControl, Windows, Graphics;

type

TDuButton= class(TDuControl)
private
  FDisabledBmp, //按钮无效时使用的图片
  FDownBmp,    //按钮按下时使用的图片
  FUpBmp,      //按钮弹起时使用的图片
  FUpAndFocusedBmp: TBitmap;  //按钮弹起并拥有焦点时使用的图片

  m_Focused, //是否拥有焦点
  FDown,    //是否按下
  FEnabled: Boolean; //是否可用
protected
  //绘制内容
  procedure PaintContent(DC: HDC; AControlRect, AInvalidateRect: TRect);override;

  //当鼠标左键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
  function DoOnLButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //当鼠标左键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
  function DoOnLButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //当鼠标右键按下时触发的事件(全框架响应，AMousePt在框架坐标系)
  function DoOnRButtonDown(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //当鼠标右键抬起时触发的事件(全框架响应，AMousePt在框架坐标系)
  function DoOnRButtonUp(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //当鼠标移动时触发的事件(全框架响应，AMousePt在框架坐标系)
  function DoOnMouseMove(AFlags: UINT; var AMousePt: TPoint): Boolean; override;
  //鼠标进入事件
  procedure DoOnMouseEnter(Sender: TObject); override;
  //鼠标离开事件
  procedure DoOnMouseLeave(Sender: TObject); override;
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy;override;
published
  property DisabledBmp: TBitmap read FDisabledBmp;//按钮无效时使用的图片
  property DownBmp: TBitmap read FDownBmp;    //按钮按下时使用的图片
  property UpBmp: TBitmap read FUpBmp;     //按钮弹起时使用的图片
  property UpAndFocusedBmp: TBitmap read FUpAndFocusedBmp;  //按钮弹起并拥有焦点时使用的图片

  property Down:Boolean read FDown write FDown;
  property Enabled:Boolean read FEnabled write FEnabled;
end;

implementation

{ TDuButton }

constructor TDuButton.Create(AOwner: TComponent);
begin
  inherited;
  FDisabledBmp:= TBitmap.Create; //按钮无效时使用的图片
  FDownBmp:= TBitmap.Create;   //按钮按下时使用的图片
  FUpBmp:= TBitmap.Create;     //按钮弹起时使用的图片
  FUpAndFocusedBmp:= TBitmap.Create;  //按钮弹起并拥有焦点时使用的图片
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
