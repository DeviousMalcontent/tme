; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

;     include files
;     ~~~~~~~~~~~~~
      include \masm32\INCLUDE\windows.inc
      include \masm32\INCLUDE\masm32.inc
      include \masm32\INCLUDE\gdi32.inc
      include \masm32\INCLUDE\user32.inc
      include \masm32\INCLUDE\kernel32.inc
      include \masm32\INCLUDE\Comctl32.inc
      include \masm32\INCLUDE\comdlg32.inc
      include \masm32\INCLUDE\shell32.inc
      include \masm32\INCLUDE\oleaut32.inc
      include \masm32\INCLUDE\msvcrt.inc

      include \masm32\macros\macros.asm

;     libraries
;     ~~~~~~~~~
      includelib \masm32\LIB\masm32.lib
      includelib \masm32\LIB\gdi32.lib
      includelib \masm32\LIB\user32.lib
      includelib \masm32\LIB\kernel32.lib
      includelib \masm32\LIB\Comctl32.lib
      includelib \masm32\LIB\comdlg32.lib
      includelib \masm32\LIB\shell32.lib
      includelib \masm32\LIB\oleaut32.lib
      includelib \masm32\LIB\msvcrt.lib

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

      ; -----------------
      ; Local prototypes
      ; -----------------
        WndProc          PROTO :DWORD,:DWORD,:DWORD,:DWORD
        MsgLoop          PROTO
        Main             PROTO
		wmPaint PROTO :HWND
        rebar            PROTO :DWORD,:DWORD,:DWORD
        addband          PROTO :DWORD,:DWORD
        TBcreate         PROTO :DWORD
        AboutProc        PROTO :DWORD,:DWORD,:DWORD,:DWORD
        MsgboxI          PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
        StatusBar        PROTO :DWORD

; ÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-

      IFNDEF cgv                     ;; include this macro if not defined elsewhere
        cgv MACRO args:VARARG
          LOCAL hndl
          .data?
            hndl dd ?
          .code
            invoke args
            mov hndl, eax
          EXITM < EQU <hndl>>
        ENDM
      ENDIF

    ; ---------------------------
    ; macros for creating toolbar
    ; ---------------------------

      TBbutton MACRO bID, cID
        mov tbb.iBitmap,   bID  ;; button  ID number
        mov tbb.idCommand, cID  ;; command ID number
        mov tbb.fsStyle,   TBSTYLE_BUTTON
        invoke SendMessage,tbhandl,TB_ADDBUTTONS,1,ADDR tbb
      ENDM

    ; ------------------------------

      TBspace MACRO
        mov tbb.iBitmap,   0
        mov tbb.idCommand, 0
        mov tbb.fsStyle,   TBSTYLE_SEP
        invoke SendMessage,tbhandl,TB_ADDBUTTONS,1,ADDR tbb
      ENDM

    ; ------------------------------

      mLOCAL equ <LOCAL>

      ToolbarInit MACRO Wd, Ht, parent

        mLOCAL tbhandl   :DWORD
        mLOCAL bSize     :DWORD
        mLOCAL tbab      :TBADDBITMAP
        mLOCAL tbb       :TBBUTTON

        invoke CreateWindowEx,0,ADDR ToolbarWindow32, \
                          ADDR szDisplayName, \
                          WS_CHILD or WS_VISIBLE or TBSTYLE_FLAT or \
                          TBSTYLE_TRANSPARENT or CCS_NODIVIDER, \
                          0,0,500,40, \
                          parent,NULL, \
                          hInstance,NULL
        mov tbhandl, eax

      ; ------------------------------------------------------------------
      ; set vertical and horizontal padding for buttons (units are pixels)
      ; ------------------------------------------------------------------
        mov ax, vpad            ; vertical padding
        rol eax, 16
        mov ax, hpad            ; horizontal padding
        invoke SendMessage,tbhandl,TB_SETPADDING,0,eax

        invoke SendMessage,tbhandl,TB_BUTTONSTRUCTSIZE,sizeof TBBUTTON,0
    
      ; ---------------------------------------
      ; Put width & height of bitmap into DWORD
      ; ---------------------------------------
        mov  ecx,Wd  ;; loword = bitmap Width
        mov  eax,Ht  ;; hiword = bitmap Height
        shl  eax,16
        mov  ax, cx

        mov bSize, eax

        invoke SendMessage,tbhandl,TB_SETBITMAPSIZE,0,bSize
        invoke SendMessage,tbhandl,TB_SETBUTTONSIZE,0,bSize

      ; --------------------------------------------------------
      ; set left side indent for first button (units are pixels)
      ; --------------------------------------------------------
        invoke SendMessage,tbhandl,TB_SETINDENT,lind,0
        
        mov tbab.hInst, 0
        m2m tbab.nID,   hBitmap
        invoke SendMessage,tbhandl,TB_ADDBITMAP,12,ADDR tbab

        mov tbb.fsState,   TBSTATE_ENABLED
        mov tbb.dwData,    0
        mov tbb.iString,   0

      ENDM

; ÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-÷-

  ; -----------------------------
  ; uninitialised data allocation
  ; -----------------------------
    .data?
        hInstance   dd ?
        hWnd        dd ?
        hIcon       dd ?
        hCursor     dd ?
        CommandLine dd ?
        sWid        dd ?
        sHgt        dd ?
        hBitmap     dd ?
        tbTile      dd ?
        hRebar      dd ?
        hToolBar    dd ?
        hStatus     dd ?
		hBmp	HBITMAP ?

IF 0  ; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

    insert additional code files within the .CODE section

ENDIF ; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

  ; ---------------------------
  ; initialised data allocation
  ; ---------------------------
	.list
	;Tile position
	DIB_POSX EQU 0
	DIB_POSY EQU 64
	
	;TileB2 position
	DIB2_POSX EQU 8
    DIB2_POSY EQU 72
	
	; Tile Width and Hight 
	DIB_WIDTH EQU 8
	DIB_HEIGHT EQU 8
	
	CanvasColour EQU 07F00FFh
  
    .data
	ButtonID50 db "Button ID  50 ",0
    ButtonID51 db "Button ID  51 ",0
    ButtonID52 db "Button ID  52 ",0
    ButtonID53 db "Button ID  53 ",0
    ButtonID54 db "Button ID  54 ",0
    ButtonID55 db "Button ID  55 ",0
    ButtonID56 db "Button ID  56 ",0
    ButtonID57 db "Button ID  57 ",0
    ButtonID58 db "Button ID  58 ",0
	DropFilesText db  "WM_DROPFILES",0
	OpenFileText db "Open File",0
	SaveFileText db "Save File As ...",0
	Arial db "Arial",0
    ToolbarWindow32 db "ToolbarWindow32",0
  	ReBarWindow32   db "ReBarWindow32",0
	szClassName     db "TileMapEditor_Class",0
	szDisplayName   db "Tile Map Editor",0
    TileA1          RECT <DIB_POSX,DIB_POSY,DIB_WIDTH+DIB_POSX,DIB_HEIGHT+DIB_POSY>
	TileB2          RECT <DIB2_POSX,DIB2_POSY,DIB_WIDTH+DIB2_POSX,DIB_HEIGHT+DIB2_POSY>

  .code
    include misc.asm

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤