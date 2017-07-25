//=============================================================================
//
// ������ �ڴ�DC
// ���ߣ� sgao
// ���ڣ� 2012-07-06
//
//=============================================================================

unit uDuCompatiblerDC;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Dialogs,uMemCounter;

type
TDuCompatiblerDC = class(TObject)
private
  m_hMemDC: HDC;                    //�ڴ�DC
  m_rcBounds: TRect;                //��������(��Ŀ��DC�ϵ�)
  m_bmNew: HBITMAP;                 //��λͼ����
  m_bmOld: HBITMAP;                 //ԭ��λͼ����
  m_nWidth:Integer;                 //���(�ڴ�DC)
  m_nHeight:Integer;                //�߶�(�ڴ�DC)
public
  //���캯��
  constructor Create(DC: HDC);reintroduce;overload;
  //���캯��
  constructor Create(DC: HDC; const ABoundsRect:TRect);reintroduce;overload;
  //��������
  destructor Destroy(); override;
  //���û�������
  procedure SetBounds(DC:HDC; const ABoundsRect:TRect);
  //���ڴ�DC���Ƶ�Ŀ��DC
  procedure Blt(DC:HDC);overload;
  //���ڴ�DC���Ƶ�Ŀ��DC��ָ��������(Ҫ��֤AInvalidateRect��m_rcBounds��һ������ϵ��)
  procedure Blt(DC:HDC; AInvalidateRect : TRect);overload;
  //�ڴ�DC
  property DC: HDC read m_hMemDC;
  //��������
  //property Bounds : TRect read m_rcBounds;
end;

implementation

//���캯��
constructor TDuCompatiblerDC.Create(DC: HDC);
begin
  inherited Create;
  //������Ŀ��DC���ݵ��ڴ�DC
  m_hMemDC := CreateCompatibleDC(DC);
end;

//���캯��
constructor TDuCompatiblerDC.Create(DC: HDC; const ABoundsRect: TRect);
begin
  inherited Create;
  //������Ŀ��DC���ݵ��ڴ�DC
  m_hMemDC := CreateCompatibleDC(DC);
  //�߽緶Χ
  m_rcBounds := ABoundsRect;
  m_nWidth := ABoundsRect.Right - ABoundsRect.Left;
  m_nHeight := ABoundsRect.Bottom - ABoundsRect.Top;
  m_bmNew := CreateCompatibleBitmap(DC, m_nWidth, m_nHeight);
  m_bmOld := SelectObject(m_hMemDC, m_bmNew);
end;

//��������
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

//���û�������
procedure TDuCompatiblerDC.SetBounds(DC:HDC; const ABoundsRect: TRect);
begin
  //��������Ƿ�Ϊ��
  if IsRectEmpty(ABoundsRect) then
  begin
    Exit;
  end;
  //�������������������������´���
  if (m_nWidth >= (ABoundsRect.Right - ABoundsRect.Left)) and (m_nHeight >= (ABoundsRect.Bottom - ABoundsRect.Top))
   then
  begin
     m_rcBounds := ABoundsRect;
     Exit;
  end;
  //�������趨
  if m_bmNew <> 0 then
  begin
    DeleteObject(m_bmNew);
    //��ԭoldbitmap
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

//���ڴ�DC���Ƶ�Ŀ��DC
procedure TDuCompatiblerDC.Blt(DC:HDC);
begin
  BitBlt(DC, m_rcBounds.Left, m_rcBounds.Top,
    m_rcBounds.Right - m_rcBounds.Left, m_rcBounds.Bottom - m_rcBounds.Top, m_hMemDC, 0, 0, SRCCOPY);
end;

//���ڴ�DC���Ƶ�Ŀ��DC��ָ��������(Ҫ��֤AInvalidateRect��m_rcBounds��һ������ϵ��)
procedure TDuCompatiblerDC.Blt(DC: HDC; AInvalidateRect: TRect);
begin
  BitBlt(DC, AInvalidateRect.Left, AInvalidateRect.Top,
    AInvalidateRect.Right - AInvalidateRect.Left, AInvalidateRect.Bottom - AInvalidateRect.Top, m_hMemDC,
    AInvalidateRect.Left - m_rcBounds.Left,  AInvalidateRect.Top - m_rcBounds.Top, SRCCOPY);
end;

end.
