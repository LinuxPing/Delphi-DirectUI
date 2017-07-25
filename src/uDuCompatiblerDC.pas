//=============================================================================
//
// 描述： 内存DC
// 作者： sgao
// 日期： 2012-07-06
//
//=============================================================================

unit uDuCompatiblerDC;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Dialogs,uMemCounter;

type
TDuCompatiblerDC = class(TObject)
private
  m_hMemDC: HDC;                    //内存DC
  m_rcBounds: TRect;                //绘制区域(在目标DC上的)
  m_bmNew: HBITMAP;                 //新位图对象
  m_bmOld: HBITMAP;                 //原有位图对象
  m_nWidth:Integer;                 //宽度(内存DC)
  m_nHeight:Integer;                //高度(内存DC)
public
  //构造函数
  constructor Create(DC: HDC);reintroduce;overload;
  //构造函数
  constructor Create(DC: HDC; const ABoundsRect:TRect);reintroduce;overload;
  //析构函数
  destructor Destroy(); override;
  //设置绘制区域
  procedure SetBounds(DC:HDC; const ABoundsRect:TRect);
  //将内存DC绘制到目标DC
  procedure Blt(DC:HDC);overload;
  //将内存DC绘制到目标DC的指定区域上(要保证AInvalidateRect和m_rcBounds在一个坐标系上)
  procedure Blt(DC:HDC; AInvalidateRect : TRect);overload;
  //内存DC
  property DC: HDC read m_hMemDC;
  //绘制区域
  //property Bounds : TRect read m_rcBounds;
end;

implementation

//构造函数
constructor TDuCompatiblerDC.Create(DC: HDC);
begin
  inherited Create;
  //创建和目标DC兼容的内存DC
  m_hMemDC := CreateCompatibleDC(DC);
end;

//构造函数
constructor TDuCompatiblerDC.Create(DC: HDC; const ABoundsRect: TRect);
begin
  inherited Create;
  //创建和目标DC兼容的内存DC
  m_hMemDC := CreateCompatibleDC(DC);
  //边界范围
  m_rcBounds := ABoundsRect;
  m_nWidth := ABoundsRect.Right - ABoundsRect.Left;
  m_nHeight := ABoundsRect.Bottom - ABoundsRect.Top;
  m_bmNew := CreateCompatibleBitmap(DC, m_nWidth, m_nHeight);
  m_bmOld := SelectObject(m_hMemDC, m_bmNew);
end;

//析构函数
destructor TDuCompatiblerDC.Destroy;
begin
  if m_hMemDC <> 0 then
  begin
    SelectObject(m_hMemDC, m_bmOld);
    DeleteDC(m_hMemDC);
  end;
  if m_bmNew <> 0 then
    DeleteObject(m_bmNew);
  inherited;
end;

//设置绘制区域
procedure TDuCompatiblerDC.SetBounds(DC:HDC; const ABoundsRect: TRect);
begin
  //检查区域是否为空
  if IsRectEmpty(ABoundsRect) then
  begin
    Exit;
  end;
  //如果已有区域大于新区域，则不重新创建
  if (m_nWidth >= (ABoundsRect.Right - ABoundsRect.Left)) and (m_nHeight >= (ABoundsRect.Bottom - ABoundsRect.Top))
   then
  begin
     m_rcBounds := ABoundsRect;
     Exit;
  end;
  //需重新设定
  if m_bmNew <> 0 then
  begin
    DeleteObject(m_bmNew);
    //还原oldbitmap
    if m_bmOld <> 0 then
    begin
      SelectObject(m_hMemDC, m_bmOld);
    end;
  end;

  m_nWidth := ABoundsRect.Right - ABoundsRect.Left;
  m_nHeight := ABoundsRect.Bottom - ABoundsRect.Top;
  m_bmNew := CreateCompatibleBitmap(DC, m_nWidth, m_nHeight);
  m_rcBounds := ABoundsRect;
  m_bmOld := SelectObject(m_hMemDC, m_bmNew);
end;

//将内存DC绘制到目标DC
procedure TDuCompatiblerDC.Blt(DC:HDC);
begin
  BitBlt(DC, m_rcBounds.Left, m_rcBounds.Top,
    m_rcBounds.Right - m_rcBounds.Left, m_rcBounds.Bottom - m_rcBounds.Top, m_hMemDC, 0, 0, SRCCOPY);
end;

//将内存DC绘制到目标DC的指定区域上(要保证AInvalidateRect和m_rcBounds在一个坐标系上)
procedure TDuCompatiblerDC.Blt(DC: HDC; AInvalidateRect: TRect);
begin
  BitBlt(DC, AInvalidateRect.Left, AInvalidateRect.Top,
    AInvalidateRect.Right - AInvalidateRect.Left, AInvalidateRect.Bottom - AInvalidateRect.Top, m_hMemDC,
    AInvalidateRect.Left - m_rcBounds.Left,  AInvalidateRect.Top - m_rcBounds.Top, SRCCOPY);
end;

end.
