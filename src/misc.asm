; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

TileDef2DIB proc uses edi dwDibWidth:DWORD,dwDibHeight:DWORD
	LOCAL dibHeader 	:BITMAPINFOHEADER
	
	xor edi, edi
	mov edx, dwDibHeight 
	mov eax,dwDibWidth
	
	mov dibHeader.biSize,sizeof BITMAPINFOHEADER
	mov dibHeader.biWidth,eax
	mov dibHeader.biHeight,edx
	mov dibHeader.biPlanes,1
	mov dibHeader.biBitCount,24
	mov dibHeader.biCompression,edi
	mov dibHeader.biSizeImage,eax
	mov dibHeader.biXPelsPerMeter,edi
	mov dibHeader.biYPelsPerMeter,edi
	mov dibHeader.biClrUsed,edi
	mov dibHeader.biClrImportant,edi

	push edi
	
	invoke GetDC,edi
	xchg eax, edi
	mov edx,esp
	invoke CreateDIBSection,edi,addr dibHeader,DIB_PAL_COLORS,edx,eax,eax
	push eax
	invoke ReleaseDC,HWND_DESKTOP,edi
	pop eax
	pop edx
	
	mov hBmp2,eax
	
	mov dword ptr [edx],0FF0000h
	mov dword ptr [edx+3],0FF0000h
	mov dword ptr [edx+6],07F0000h
	mov dword ptr [edx+9],07F0000h
	mov dword ptr [edx+12],0FF0000h
	mov dword ptr [edx+15],0FF0000h
	mov dword ptr [edx+18],07F0000h

	mov ecx, DIB_WIDTH

	mov dword ptr [edx+21],07F0000h
	mov dword ptr [edx+24],07F0000h
	mov dword ptr [edx+27],0FF0000h
	mov dword ptr [edx+30],0FF0000h
	mov dword ptr [edx+33],07F0000h
	mov dword ptr [edx+36],07F0000h
	mov dword ptr [edx+39],0FF0000h
	mov dword ptr [edx+42],0FF0000h

	mov ecx, DIB_WIDTH

	mov dword ptr [edx+45],07F0000h
	mov dword ptr [edx+48],07F0000h
	mov dword ptr [edx+51],07F0000h
	mov dword ptr [edx+54],0FF0000h
	mov dword ptr [edx+57],0FF0000h
	mov dword ptr [edx+60],07F0000h
	mov dword ptr [edx+63],07F0000h
	mov dword ptr [edx+66],0FF0000h

	mov ecx, DIB_WIDTH

	mov dword ptr [edx+69],0FF0000h
	mov dword ptr [edx+72],0FF0000h
	mov dword ptr [edx+75],07F0000h
	mov dword ptr [edx+78],07F0000h
	mov dword ptr [edx+81],0FF0000h
	mov dword ptr [edx+84],0FF0000h
	mov dword ptr [edx+87],07F0000h
	mov dword ptr [edx+90],07F0000h

	mov ecx, DIB_WIDTH

	mov dword ptr [edx+93],0FF0000h
	mov dword ptr [edx+96],0FF0000h
	mov dword ptr [edx+99],0FF0000h
	mov dword ptr [edx+102],07F0000h
	mov dword ptr [edx+105],07F0000h
	mov dword ptr [edx+108],0FF0000h
	mov dword ptr [edx+111],0FF0000h
	mov dword ptr [edx+114],07F0000h

	mov ecx, DIB_WIDTH

	mov dword ptr [edx+117],07F0000h
	mov dword ptr [edx+120],07F0000h
	mov dword ptr [edx+123],0FF0000h
	mov dword ptr [edx+126],0FF0000h
	mov dword ptr [edx+129],07F0000h
	mov dword ptr [edx+132],07F0000h
	mov dword ptr [edx+135],0FF0000h
	mov dword ptr [edx+138],0FF0000h

	mov ecx, DIB_WIDTH

	mov dword ptr [edx+141],07F0000h
	mov dword ptr [edx+144],07F0000h
	mov dword ptr [edx+147],07F0000h
	mov dword ptr [edx+150],0FF0000h
	mov dword ptr [edx+153],0FF0000h
	mov dword ptr [edx+156],07F0000h
	mov dword ptr [edx+159],07F0000h
	mov dword ptr [edx+162],0FF0000h

	mov ecx, DIB_WIDTH

	mov dword ptr [edx+165],0FF0000h
	mov dword ptr [edx+168],0FF0000h
	mov dword ptr [edx+171],07F0000h
	mov dword ptr [edx+174],07F0000h
	mov dword ptr [edx+177],0FF0000h
	mov dword ptr [edx+180],0FF0000h
	mov dword ptr [edx+183],07F0000h
	mov dword ptr [edx+186],07F0000h
	mov dword ptr [edx+189],0FF0000h

	
	ret

TileDef2DIB endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい
rebar proc instance:DWORD,hParent:DWORD,htrebar:DWORD

    LOCAL hrbar :DWORD

    invoke CreateWindowEx,WS_EX_LEFT,ADDR ReBarWindow32,NULL, \
                      WS_VISIBLE or WS_CHILD or \
                      WS_CLIPCHILDREN or WS_CLIPSIBLINGS or \
                      RBS_VARHEIGHT or CCS_NOPARENTALIGN or CCS_NODIVIDER, \
                      0,0,sWid,htrebar,hParent,NULL,instance,NULL
    mov hrbar, eax

    invoke ShowWindow,hrbar,SW_SHOW
    invoke UpdateWindow,hrbar

    mov eax, hrbar

    ret

rebar endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

addband proc instance:DWORD,hrbar:DWORD

    LOCAL tbhandl   :DWORD
    LOCAL rbbi      :REBARBANDINFO

    invoke TBcreate,hrbar
    mov tbhandl, eax

    mov rbbi.cbSize,      sizeof REBARBANDINFO
    mov rbbi.fMask,       RBBIM_ID or RBBIM_STYLE or \
                          RBBIM_BACKGROUND or RBBIM_CHILDSIZE or RBBIM_CHILD
    mov rbbi.wID,         125
    mov rbbi.fStyle,      RBBS_FIXEDBMP
    m2m rbbi.hbmBack,     tbTile
    mov rbbi.cxMinChild,  0
    m2m rbbi.cyMinChild,  rbht
    m2m rbbi.hwndChild,   tbhandl

    invoke SendMessage,hrbar,RB_INSERTBAND,0,ADDR rbbi

    mov eax, tbhandl

    ret

addband endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

MsgboxI proc hParent:DWORD,pText:DWORD,pTitle:DWORD,mbStyle:DWORD,IconID:DWORD

    LOCAL mbp   :MSGBOXPARAMS

    or mbStyle, MB_USERICON

    mov mbp.cbSize,             SIZEOF mbp
    m2m mbp.hwndOwner,          hParent
    invoke GetModuleHandle,0
	mov mbp.hInstance,eax
    m2m mbp.lpszText,           pText
    m2m mbp.lpszCaption,        pTitle
    m2m mbp.dwStyle,            mbStyle
    m2m mbp.lpszIcon,           IconID
    mov mbp.dwContextHelpId,    NULL
    mov mbp.lpfnMsgBoxCallback, NULL
    mov mbp.dwLanguageId,       NULL

    invoke MessageBoxIndirect,ADDR mbp

    ret

MsgboxI endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

AboutProc proc hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD

    LOCAL hStat     :DWORD
    LOCAL hImage    :DWORD
    LOCAL hbmp      :DWORD
    LOCAL hDC       :DWORD
    LOCAL hOld      :DWORD
    LOCAL hFont     :DWORD
    LOCAL rct       :RECT
    LOCAL banner    :DWORD
    LOCAL ttext     :DWORD

      ; ------------------------------------
      ; adjust the text formatting rectangle
      ; here for the banner text below.
      ; ------------------------------------
        aTl equ <10>        ; top left
        aTr equ <10>        ; top right
        aLl equ <400>       ; lower left
        aLr equ <40>        ; lower right
        bHt equ <48>        ; set the bitmap height here

        sas banner,"Mark's Tile Map Editor Application",13,10,13,10

        IFNDEF __UNICODE__
          sas ttext,"Built with the MASM32 SDK 1998-2011",13,10,13,10,"ANSI Build"
        ELSE
          sas ttext,"Built with the MASM32 SDK 1998-2011",13,10,13,10,"UNICODE Build"
        ENDIF

    switch uMsg
      case WM_INITDIALOG
	    invoke GetDlgItem,hWin,999
        mov hImage, eax
		invoke GetDlgItem,hWin,997
        mov hStat, eax


        invoke SetWindowText,hStat,ttext

      ; --------------------------------------------------------
      ; set the static control style so it will display a bitmap
      ; --------------------------------------------------------
        invoke SetWindowLong,hImage,GWL_STYLE,WS_VISIBLE or SS_BITMAP

      ; ---------------------------------------------------------
      ; reuse the toolbar bitmap as the display banner background
      ; ---------------------------------------------------------
        invoke LoadImage,hInstance,800,IMAGE_BITMAP,600,bHt,LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS
		mov hbmp, eax

      ; -------------------------------------
      ; set the image into the static control
      ; -------------------------------------
        invoke SendMessage,hImage,STM_SETIMAGE,IMAGE_BITMAP,hbmp

      ; ---------------------------------------------------------------
      ; post a WM_PAINT message to the window so it updates the display
      ; ---------------------------------------------------------------
        invoke PostMessage,hWin,WM_PAINT,0,0

      case WM_PAINT
	    invoke GetDC,hWin
        mov hDC, eax
        invoke SetBkMode,hDC,TRANSPARENT

        invoke CreateFont,20,10,0,0,800,FALSE,FALSE,FALSE, \
                      ANSI_CHARSET,0,0,PROOF_QUALITY,DEFAULT_PITCH,ADDR Arial
        mov hFont, eax

        invoke SelectObject,hDC,hFont
        mov hOld, eax

      ; --------------------
      ; draw the shadow text
      ; --------------------
        mov rct.left, aTl+2
        mov rct.top, aTr+2
        mov rct.right, aLl+2
        mov rct.bottom, aLr+2
        invoke SetTextColor,hDC,00000000h
        invoke DrawText,hDC,banner,-1,ADDR rct,DT_LEFT or DT_VCENTER or DT_SINGLELINE

      ; ----------------------
      ; draw the highlite text
      ; ----------------------
        mov rct.left, aTl
        mov rct.top, aTr
        mov rct.right, aLl
        mov rct.bottom, aLr
        invoke SetTextColor,hDC,00FFFFFFh
        invoke DrawText,hDC,banner,-1,ADDR rct,DT_LEFT or DT_VCENTER or DT_SINGLELINE

        invoke SelectObject,hDC,hOld

        invoke ReleaseDC,hWin,hDC

        xor eax, eax
        ret

      case  WM_COMMAND
        switch wParam
          case IDOK
            invoke EndDialog,hWin,0
        endsw
    endsw

    xor eax, eax
    ret

AboutProc endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい
