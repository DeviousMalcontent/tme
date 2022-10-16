; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    ; __UNICODE__ equ 1           ; uncomment to enable UNICODE build

    .386
    .model flat, stdcall        ; 32 bit memory model
    option casemap :none        ; case sensitive

  ; -------------------------------------------------------------
  ; equates for controlling the toolbar button size and placement
  ; -------------------------------------------------------------
    rbht     equ <64>           ; rebar height in pixels
    tbbW     equ <48>           ; toolbar button width in pixels
    tbbH     equ <48>           ; toolbar button height in pixels
    vpad     equ <16>           ; vertical button padding in pixels
    hpad     equ <12>           ; horizontal button padding in pixels
    lind     equ  <5>           ; left side initial indent in pixels

    bColor   equ  <00999999h>   ; client area brush colour

    include TileMapEditor.inc   ; local includes for this file

.code

start:

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

  ; ------------------
  ; set global values
  ; ------------------
    invoke GetModuleHandle, NULL
    mov hInstance, eax

    invoke GetCommandLine
    mov CommandLine, eax

    invoke LoadIcon,hInstance,500
    mov hIcon, eax

    invoke LoadCursor,NULL,IDC_ARROW
    mov hCursor, eax

    invoke LoadCursor,NULL,IDC_ARROW
    mov hCursor, eax

    invoke GetSystemMetrics,SM_CXSCREEN
    mov sWid, eax

    invoke GetSystemMetrics,SM_CYSCREEN
    mov sHgt, eax

  ; -------------------------------------------------
  ; load the toolbar button strip at its default size
  ; -------------------------------------------------
    invoke LoadImage,hInstance,700,IMAGE_BITMAP,0,0, \
           LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS
    mov hBitmap, eax

  ; ----------------------------------------------------------------
  ; load the rebar background tile stretching it to the rebar height
  ; ----------------------------------------------------------------
    invoke LoadImage,hInstance,800,IMAGE_BITMAP,sWid,rbht,LR_DEFAULTCOLOR
    mov tbTile, eax

    call Main

    invoke ExitProcess,eax

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

Main proc

    LOCAL Wwd:DWORD,Wht:DWORD,Wtx:DWORD,Wty:DWORD,mWid:DWORD
    LOCAL wc:WNDCLASSEX
    LOCAL icce:INITCOMMONCONTROLSEX

  ; --------------------------------------
  ; comment out the styles you don't need.
  ; --------------------------------------
    mov icce.dwSize, SIZEOF INITCOMMONCONTROLSEX            ; set the structure size
    xor eax, eax                                            ; set EAX to zero
    or eax, ICC_WIN95_CLASSES
    or eax, ICC_BAR_CLASSES                                 ; comment out the rest
    ; or eax, ICC_TREEVIEW_CLASSES
    ; or eax, ICC_LISTVIEW_CLASSES
    ; or eax, ICC_COOL_CLASSES
    ; or eax, ICC_DATE_CLASSES
    ; or eax, ICC_PROGRESS_CLASS
    ; or eax, ICC_TAB_CLASSES
    ; or eax, ICC_HOTKEY_CLASS
    ; or eax, ICC_INTERNET_CLASSES
    ; or eax, ICC_PAGESCROLLER_CLASS
    ; or eax, ICC_UPDOWN_CLASS
    ; or eax, ICC_ANIMATE_CLASS                               ; OR as many styles as you need to it
    ; or eax, ICC_USEREX_CLASSES
    mov icce.dwICC, eax
    invoke InitCommonControlsEx,ADDR icce                   ; initialise the common control library
  ; --------------------------------------

  ; ---------------------------------------------------
  ; set window class attributes in WNDCLASSEX structure
  ; ---------------------------------------------------
    mov wc.cbSize,         sizeof WNDCLASSEX
    mov wc.style,          CS_BYTEALIGNCLIENT or CS_BYTEALIGNWINDOW
    m2m wc.lpfnWndProc,    OFFSET WndProc
    mov wc.cbClsExtra,     NULL
    mov wc.cbWndExtra,     NULL
    m2m wc.hInstance,      hInstance
    m2m wc.hbrBackground,  COLOR_BTNFACE+1
    mov wc.lpszMenuName,   NULL
    mov wc.lpszClassName,  OFFSET szClassName
    m2m wc.hIcon,          hIcon
    m2m wc.hCursor,        hCursor
    m2m wc.hIconSm,        hIcon

  ; ------------------------------------
  ; register class with these attributes
  ; ------------------------------------
    invoke RegisterClassEx, ADDR wc

  ; ---------------------------------------------
  ; set width and height as percentages of screen
  ; ---------------------------------------------
    invoke GetPercent,sWid,70
    mov Wwd, eax
    invoke GetPercent,sHgt,70
    mov Wht, eax

  ; ----------------------
  ; set aspect ratio limit
  ; ----------------------
    FLOAT4 aspect_ratio, 1.4    ; set the maximum startup aspect ratio

    fild Wht                    ; load source
    fld aspect_ratio            ; load multiplier
    fmul                        ; multiply source by multiplier
    fistp mWid                  ; store result in variable

    mov eax, Wwd
    .if eax > mWid              ; if the default window width is > aspect ratio
      m2m Wwd, mWid             ; set the width to the maximum aspect ratio
    .endif

  ; ------------------------------------------------
  ; Top X and Y co-ordinates for the centered window
  ; ------------------------------------------------
    mov eax, sWid
    sub eax, Wwd                ; sub window width from screen width
    shr eax, 1                  ; divide it by 2
    mov Wtx, eax                ; copy it to variable

    mov eax, sHgt
    sub eax, Wht                ; sub window height from screen height
    shr eax, 1                  ; divide it by 2
    mov Wty, eax                ; copy it to variable

  ; -----------------------------------------------------------------
  ; create the main window with the size and attributes defined above
  ; -----------------------------------------------------------------
    invoke CreateWindowEx,WS_EX_LEFT or WS_EX_ACCEPTFILES,
                          ADDR szClassName,
                          ADDR szDisplayName,
                          WS_OVERLAPPEDWINDOW,
                          Wtx,Wty,Wwd,Wht,
                          NULL,NULL,
                          hInstance,NULL
    mov hWnd,eax

    invoke LoadMenu,hInstance,600
    invoke SetMenu,hWnd,eax

    invoke ShowWindow,hWnd, SW_SHOWNORMAL
    invoke UpdateWindow,hWnd

    call MsgLoop
    ret

Main endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

MsgLoop proc

    LOCAL msg:MSG

    push ebx
    lea ebx, msg
    jmp getmsg

  msgloop:
    invoke TranslateMessage, ebx
    invoke DispatchMessage,  ebx
  getmsg:
    invoke GetMessage,ebx,0,0,0
    test eax, eax
    jnz msgloop

    pop ebx
    ret

MsgLoop endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

WndProc proc hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD

    LOCAL var    :DWORD
    LOCAL caW    :DWORD
    LOCAL caH    :DWORD
    LOCAL fname  :DWORD
    LOCAL opatn  :DWORD
    LOCAL spatn  :DWORD
    LOCAL rct    :RECT
    LOCAL buffer1[260]:BYTE  ; these are two spare buffers
    LOCAL buffer2[260]:BYTE  ; for text manipulation etc..

    Switch uMsg
      Case WM_COMMAND
      ; -------------------------------------------------------------------
        Switch wParam
          case 50
            invoke MsgboxI,hWin,ADDR ButtonID50,ADDR szDisplayName,MB_OK,500

          case 51
            invoke MsgboxI,hWin,ADDR ButtonID51,ADDR szDisplayName,MB_OK,500

          case 52
            invoke MsgboxI,hWin,ADDR ButtonID52,ADDR szDisplayName,MB_OK,500

          case 53
            invoke MsgboxI,hWin,ADDR ButtonID53,ADDR szDisplayName,MB_OK,500

          case 54
            invoke MsgboxI,hWin,ADDR ButtonID54,ADDR szDisplayName,MB_OK,500

          case 55
            invoke MsgboxI,hWin,ADDR ButtonID55,ADDR szDisplayName,MB_OK,500

          case 56
            invoke MsgboxI,hWin,ADDR ButtonID56,ADDR szDisplayName,MB_OK,500

          case 57
            invoke MsgboxI,hWin,ADDR ButtonID57,ADDR szDisplayName,MB_OK,500

          case 58
            invoke MsgboxI,hWin,ADDR ButtonID58,ADDR szDisplayName,MB_OK,500

          case 1010
            sas opatn, "All files",0,"*.*",0
			invoke OpenFileDialog,hWin,hInstance,Addr OpenFileText,opatn
            mov fname, eax
            cmp BYTE PTR [eax], 0
            jne @F
            return 0
            @@:
          ; ---------------------------------
          ; perform your file open code here
          ; ---------------------------------
            invoke MsgboxI,hWin,fname,ADDR szDisplayName,MB_OK,500

          case 1020
            sas spatn, "All files",0,"*.*",0
			invoke SaveFileDialog,hWin,hInstance,ADDR SaveFileText,spatn
            mov fname, eax
            cmp BYTE PTR [eax], 0
            jne @F
            return 0
            @@:
          ; ---------------------------------
          ; perform your file save code here
          ; ---------------------------------
            invoke MsgboxI,hWin,fname,ADDR szDisplayName,MB_OK,500

          case 1090
          app_close:
            invoke SendMessage,hWin,WM_SYSCOMMAND,SC_CLOSE,NULL

          case 10000
            invoke DialogBoxParam,hInstance,5000,hWin,ADDR AboutProc,0

        Endsw
      ; -------------------------------------------------------------------

      case WM_DROPFILES
      ; --------------------------
      ; process dropped files here
      ; --------------------------
        mov fname, DropFileName(wParam)
        invoke MsgboxI,hWin,fname,ADDR DropFilesText,MB_OK,500
        return 0
		
	  case WM_PAINT
	  invoke CreateSolidBrush, CanvasColour
	  
	  invoke TileDef2DIB,DIB_WIDTH,DIB_HEIGHT
	  
	    invoke wmPaint, hWin
		xor eax, eax
      case WM_CREATE
        invoke rebar,hInstance,hWin,rbht  ; create the rebar control
        mov hRebar, eax
        
        invoke addband,hInstance,hRebar ; add the toolbar band to it
        mov hToolBar, eax
        
        invoke StatusBar,hWin ; create the status bar
        mov hStatus, eax


      case WM_SIZE
        invoke MoveWindow,hStatus,0,0,0,0,TRUE

      case WM_CLOSE
      ; -----------------------------
      ; perform any required cleanups
      ; here before closing.
      ; -----------------------------

      case WM_DESTROY
        invoke PostQuitMessage,NULL
        return 0

    Endsw

    invoke DefWindowProc,hWin,uMsg,wParam,lParam

    ret

WndProc endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

wmPaint proc uses ebx esi edi hWin:DWORD
	local ps 	:PAINTSTRUCT 
	local hBmpMem :HBITMAP

	;Canvas
	invoke BeginPaint,hWin,ADDR ps
	xchg eax,ebx
	invoke CreateCompatibleDC, ebx
	xchg eax,esi
	invoke CreateCompatibleBitmap,ebx,512,512
	invoke SelectObject,esi,eax
	mov hBmpMem, eax
	
	;Tile
	invoke CreateCompatibleDC, ebx
	xchg eax,edi
	invoke SelectObject,edi,hBmp2
	push eax
	xor ecx,ecx
	mov edx,Tile.bottom
	mov eax,Tile.right
	sub edx,Tile.top
	sub eax,Tile.left
	invoke BitBlt,esi,Tile.left,Tile.top,eax,edx,edi,ecx,ecx,SRCCOPY
	push edi
	invoke DeleteDC,edi

	mov ecx,ps.rcPaint.right
	mov edx,ps.rcPaint.bottom
	mov eax,ps.rcPaint.left
	mov edi,ps.rcPaint.top
	sub ecx,eax
	sub edx,edi
	
	invoke BitBlt,ebx,eax,edi,ecx,edx,esi,eax,edi, SRCCOPY
	
	invoke SelectObject,esi,hBmpMem
	invoke DeleteObject,eax
	invoke DeleteDC,esi
	
    invoke EndPaint,hWin,ADDR ps
    ;mov eax, 0
    ret
wmPaint endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

TBcreate proc parent:DWORD

  ; -----------------------------
  ; run to toolbar creation macro
  ; -----------------------------
    ToolbarInit tbbW, tbbH, parent

  ; -----------------------------------
  ; Add toolbar buttons and spaces here
  ; arg1 bmpID (zero based)
  ; arg2 cmdID (1st is 50)
  ; -----------------------------------
    TBbutton  0,  50
    TBbutton  1,  51
    TBbutton  2,  52
    TBspace
    TBbutton  3,  53
    TBbutton  4,  54
    TBbutton  5,  55
    TBspace
    TBbutton  6,  56
    TBbutton  7,  57
    TBbutton  8,  58
  ; -----------------------------------

    mov eax, tbhandl

    ret

TBcreate endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

StatusBar proc hParent:DWORD

    LOCAL handl :DWORD
    LOCAL sbParts[4] :DWORD

    invoke CreateStatusWindow,WS_CHILD or WS_VISIBLE or SBS_SIZEGRIP,NULL,hParent,200
    mov handl, eax

  ; --------------------------------------------
  ; set the width of each part, -1 for last part
  ; --------------------------------------------
    mov [sbParts+0], 100
    mov [sbParts+4], 200
    mov [sbParts+8], 300
    mov [sbParts+12],-1

    invoke SendMessage,handl,SB_SETPARTS,4,ADDR sbParts

    mov eax, handl

    ret

StatusBar endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

end start
