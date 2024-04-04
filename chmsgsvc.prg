*
*  Note: This is a modified version of MsgSvc tailored for ChilkatVFP.
*  I needed a bit more than MsgSvc - the ability to translate the field
*  to be converted is contained in public domain INTL.PRG, but it also
*  brings much more than I needed.
*
*  I added a somewhat kludgey 4th parameter to MsgSvc. That parameter
*  will hold the ChilkatVFP object. For what it was worth, I coded 
*  it as backward compatibile as possible to MsgSvc but I haven't 
*  checked to see if it really worked.
*
*  There's a new MsgSvc array property to hold the supported languages.
* 
*  The MsgSvc function has some code to support the new parameter
*  and a variable to hold the language from the ChilkatVFP object.
*
*  If the passed language is in the array, then the correct field is 
*  swapped into the SCATTER ARRAY loMsgSpec.cOriginal field, 
*  and everything gets processed as normal.
*
*  The real work is done by the authors below, I'm just
*  standing on the shoulders of giants. WAA 02/18/2024
*
*  Program...........: MSGSVC.PRG
*************************************************************************
*                      Public Domain Edition
*************************************************************************
*  Version...........: 7.03 August 4 2004
#DEFINE MSGSVCVERSION  "7.03 August 4 2004"
*  Latest Version....: Check http://www.stevenblack.com/SBCPublicDomain.asp
*  Description.......: Central Square for Messages.
*  Author............: Steven M. Black - email: steveb@stevenblack.com
*  Special thanks to.: Albert Ballanger
*                      Art Bergquist
*                      Frank Cazabon
*                      Steve Dingle
*                      Mike and Toni Feltman
*                      Sebastien Fluke
*                      Kirsten Frieﬂnegg
*                      Mark Giesen
*                      John Harbour
*                      Rick Hodder
*                      Dale Kiefling
*                      Ken Levy
*                      Andrew MacNeill
*                      Kevin McNeish
*                      Gene Pasquini
*                      Barbara Peisch
*                      Alan Schwartz
*                      Paul Slate
*                      Steve Smith
*                      Drew Speedie
*                      Trish Swift
*                      Anthony L. Testi
*                      John Vahlberg
*                      ...and many other great folks too.
*
*} Project...........: INTL
*  Created...........: 09/22/93
*  Copyright.........: None (Public Domain)
*)
*] Dependencies......: Assumes that if MsgSvc.DBF is open, it is
*]                     ORDER()'d properly
*
*  Calling Samples
*          Typical...: msgsvc( "Some Key Expression")
*                    : msgsvc( "This is a new message|This on line 2|This on line 3")   (multiline)
*     String Swaps...: msgvvc( "SomeKey", "Two~three~ain't bad"]
*  Thermometer bar...: msgsvc( "in-bar message", "Therm", 30)
*
*  Parameter List....: tcMessageKey
*                      txVariable
*                      tnHowFar
*  Returns...........: Either Character, Numeric, or Logical depending
*                      on the cRetType field in MSGSVC.DBF
*
#DEFINE ccCr_Lf         CHR( 13) + CHR( 10)
#DEFINE ccParseDelim    "~"
#DEFINE ccTABLE         "MsgSvc.DBF"
#DEFINE ccALIAS         JUSTSTEM( ccTABLE)   && See proc JUSTSTEM() below for pre-VFP 5 versions
#DEFINE cnSideMargin    18
#DEFINE ccForceTextReturn  "((TEXT))"

* These define the delimiters for dynamic substitition
#DEFINE ccMERGEOPEN  "{{"
#DEFINE ccMERGECLOSE "}}"

*==============================================================
* If your development language is NOT English, then modify
* the lines below and specify your own native language terms
* for OK, Cancel, Yes, No, etc...
#DEFINE ccOK     "Ok"
#DEFINE ccCANCEL "Cancel"
#DEFINE ccABORT  "Abort"
#DEFINE ccRETRY  "Retry"
#DEFINE ccIGNORE "Ignore"
#DEFINE ccYES    "Yes"
#DEFINE ccNO     "No"

*-- Tip of the day localizations
#DEFINE ccDIDYOUKNOW    "Did you know..."
#DEFINE ccSHOWTIPS      "\<Show Tips at Startup"
#DEFINE ccHELP          "\<Help"
#DEFINE ccMORETIPS      "\<More Tips"
#DEFINE ccNEXTTIP       "\<Next Tip..."
#DEFINE ccTOD           "Tip Of The Day"

*-- This is new in Version 6: Default title is _SCREEN.Caption
#DEFINE ccDEFAULTDIALOGCAPTION  _SCREEN.Caption

*-- Used to reckon system colors (new in Version 6)
#DEFINE COLOR_SCROLLBAR         0
#DEFINE COLOR_BACKGROUND        1
#DEFINE COLOR_ACTIVECAPTION     2
#DEFINE COLOR_INACTIVECAPTION   3
#DEFINE COLOR_MENU              4
#DEFINE COLOR_WINDOW            5
#DEFINE COLOR_WINDOWFRAME       6
#DEFINE COLOR_MENUTEXT          7
#DEFINE COLOR_WINDOWTEXT        8
#DEFINE COLOR_CAPTIONTEXT       9
#DEFINE COLOR_ACTIVEBORDER      10
#DEFINE COLOR_INACTIVEBORDER    11
#DEFINE COLOR_APPWORKSPACE      12
#DEFINE COLOR_HIGHLIGHT         13
#DEFINE COLOR_HIGHLIGHTTEXT     14
#DEFINE COLOR_BTNFACE           15
#DEFINE COLOR_BTNSHADOW         16
#DEFINE COLOR_GRAYTEXT          17
#DEFINE COLOR_BTNTEXT           18
#DEFINE COLOR_INACTIVECAPTIONTEXT 19
#DEFINE COLOR_BTNHIGHLIGHT      20
#DEFINE COLOR_3DDKSHADOW        21
#DEFINE COLOR_3DLIGHT           22
#DEFINE COLOR_INFOTEXT          23
#DEFINE COLOR_INFOBK            24
#DEFINE COLOR_DESKTOP           COLOR_BACKGROUND
#DEFINE COLOR_3DFACE            COLOR_BTNFACE
#DEFINE COLOR_3DSHADOW          COLOR_BTNSHADOW
#DEFINE COLOR_3DHIGHLIGHT       COLOR_BTNHIGHLIGHT
#DEFINE COLOR_3DHILIGHT         COLOR_BTNHIGHLIGHT
#DEFINE COLOR_BTNHILIGHT        COLOR_BTNHIGHLIGHT

*== E N T E R   H E R E ========================================
LPARAMETERS txPara1, txPara2, txPara3, txPara4)

PRIVATE lcSystemFont, lxRetValm, loMsgSvc

** No fourth parameter (i.e. prior MsgSvc behavior) test
IF PCOUNT() < 4

  lcSystemFont= GetSystemFont()
  IF TYPE("_Screen.oMsgSvc")="U"
    _SCREEN.AddObject("oMsgSvc", "cMsgSvc")
  ENDIF

  *-- Take Note! If there is a problem, we return .F.
  IF TYPE("_Screen.oMsgSvc.Name")<> "C"
    lxRetVal= .F.
  ELSE
    lxRetVal= _Screen.oMsgSvc.MsgSvc( txPara1, txPara2, txPara3)
    IF ! _Screen.oMsgSvc.lPersist
      _Screen.oMsgSvc.Release()
    ENDIF
  ENDIF

ELSE

  lxRetVal = .F.

  loMsgSvc = NEWOBJECT([cMsgSvc])

  ** Have an object test
  IF TYPE([loMsgSvc.Name]) = [C]

    lxRetVal = loMsgSvc.MsgSvc(txPara1, txPara2, txPara3, txPara4)

  ENDIF TYPE([loMsgSvc.Name]) = [C]
  ** End have an object test

  loMsgSvc = NULL

ENDIF PCOUNT() < 4
** End no fourth parameter (i.e. prior MsgSvc behavior) test

RETURN lxRetVal

*== E X I T   H E R E ==========================================

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c A b s t r a c t D i r e c t o r
* Version..: February 27 1997
*-- Roles of the message "director"
*--    Created by client
*--    Creates/Maintains builders
*--    Notifies builders
*--    Retrieves results from builder and displays the result
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cAbstractDirector AS LightweightCustom

  cDefaultBuilder = .NULL.
  *-- Supported sorts of PROPER(message ID) and the dialog builder class
  DIMENSION aBuilders[1,2]
  aBuilders[1,1]= "Unknown Index"
  aBuilders[1,2]= "Unknown Class"

  *====================================
  *-- cAbstractDirector::GetBuilder()
  *====================================
  * Retrieve items from the aBuilders array
  *
  FUNCTION GetBuilder( tcID)
  IF ISNULL( tcID)
    RETURN .NULL.
  ENDIF

  LOCAL lcFunction, lnHit, lcRetVal
  lcRetVal= This.cDefaultBuilder

  IF TYPE( "tcID") <> "C"
    RETURN lcRetVal
  ENDIF

  tcID= tokennum(tcID,1)
  lcFunction= PROPER( ALLTRIM( tcID))

  lnHit= ASCAN( This.aBuilders, lcFunction)
  IF lnHit> 0
    RETURN This.aBuilders[ lnHit+1]
  ELSE
    lnHit= ASCAN( This.aBuilders, "Default")
    IF lnHit> 0
      RETURN This.aBuilders[ lnHit+1]
    ELSE
      RETURN lcRetVal
    ENDIF
  ENDIF

  *====================================
  *-- cAbstractDirector::SetBuilder
  *====================================
  * Add items to the aBuilders array
  *
  FUNCTION SetBuilder( tcID, tcClass)

  IF ISNULL( tcID) OR ISNULL( tcClass)
    RETURN .NULL.
  ENDIF

  LOCAL llRetVAal
  llRetVal= .F.

  IF EMPTY( tcID) OR ;
      EMPTY( tcClass) OR ;
      TYPE( "tcId") <> "C" OR ;
      TYPE( "tcClass") <> "C"

    RETURN llRetVal
  ENDIF

  llRetVal= .T.

  LOCAL lnFound, lntemp
  lnFound=ASCAN( This.aBuilders, tcID)
  IF lnFound > 0
    This.aBuilders( lnFound+1)= ALLTRIM(tcClass)
  ELSE
    lntemp= ALEN(This.aBuilders)
    DIMENSION This.aBuilders[ lnTemp+ 2]
    This.aBuilders[ lnTemp+ 1]= PROPER( tcID)
    This.aBuilders[ lnTemp+ 2]= PROPER( tcClass)
  ENDIF
  RETURN llRetVal

  *====================================
  *-- cAbstractDirector::Release()
  *====================================
  * Release this object
  *
  FUNCTION RELEASE
  Release THIS

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c M e s s a g e D i r e c t o r
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cMessageDirector AS cAbstractDirector

  cDefaultBuilder= "cDialogBuilder"

  *-- The name of the message resource file.
  cTable= ccTABLE

  *-- The alias of the message resource file
  cAlias= ccALIAS

  *-- The index tag to make active
  cTag= "cKey"

  *-- Global switch for optional icon animation on slower systems.
  *-- Set to .F. to disable all animation
  lAnimateIcons= .T.

  *-- The return value from the message or dialog we will build.
  ReturnValue= ''

  *-- Supported sorts of PROPER(message ID) and the dialog builder class
  DIMENSION aBuilders[1,2]
  aBuilders[1,1]= "Default"
  aBuilders[1,2]= "cDialogBuilder"

  *-- Array of currently active dialogs.  Messages get put on this
  *-- stack so more than one message can be up at one time.
  DIMENSION aDialogs[1]
  aDialogs[1]= .NULL.
  *-- Do you want the director object to persist between hits?
  lPersist= .T.

  *-- Do you want the director object to update the MscSvc table when faced with new messages?
  lUpdateTable= .T.

  *-- For ChilkatVFP - property to hold the language to use for displays.
  cLanguage = [cOriginal]
  
  *-- For ChilkatVFP - Array to hold the supported languages (outside of "Original")
  DIMENSION aLanguages[4,1]
  aLanguages[1,1] = [French]
  aLanguages[2,1] = [German]
  aLanguages[3,1] = [Spanish]
  aLanguages[4,1] = [Test]
  
  *-- Abstract Methods of this class
  FUNCTION GetDialogHandle(c)
  FUNCTION MsgSvc( x1, x2, x3, x4)
  FUNCTION OpenTable
  FUNCTION CloseTable

  *====================================
  *-- cAbstractDirector::cdx_msgsvc()
  *====================================
  * Reindex the resource file.
  *
  FUNCTION cdx_msgsvc

  LOCAL lnOldArea, lcOldError, lnError

  lnError= 0
  lcOldError= ON("Error")
  ON ERROR lnError=1

  lnOldArea = SELECT(0)

  IF ! USED( This.cAlias)
    USE (This.cTable) IN 0 EXCLUSIVE ALIAS (This.cAlias)
  ELSE
    SELECT ( This.cAlias)
  ENDIF

  IF lnError= 0
    DELETE TAG ALL
    INDEX ON UPPER( cKey) TAG (This.cTag)
  ENDIF

  SELECT (lnOldArea)
  ON ERROR &lcOldError

  RETURN lnError==0

  *====================================
  *-- cAbstractDirector::GetDialogHandle(c)
  *====================================
  * Retrieve the LIFO dialog of a given type
  * from the dialog stack
  *
  FUNCTION GetDialogHandle( tcType)
  LOCAL loRetVal, lnI
  loRetVal= .NULL.
  IF TYPE( "tcType")= "C"
    FOR lnI= ALEN( This.aDialogs) TO 1 STEP -1
      IF TYPE( "This.aDialogs[ lnI]") = "O" AND ;
          ! ISNULL( This.aDialogs[ lnI])
        IF UPPER( ALLTRIM( This.aDialogs[ lni].Type))== UPPER( ALLTRIM( tcType))
          loRetVal= This.aDialogs[ lni]
        ENDIF
      ENDIF
    ENDFOR
  ENDIF
  RETURN loRetVal


  *====================================
  *-- cAbstractDirector::Init()
  *====================================
  *
  FUNCTION INIT
  *-- Used to reckon system colors
  DECLARE INTEGER GetSysColor in User32.dll Integer
  *-- Used to reckon fonts
  DECLARE INTEGER SystemParametersInfo IN Win32API ;
  INTEGER, INTEGER, STRING @, INTEGER

  RETURN
  *====================================
  *-- cAbstractDirector::Destroy()
  *====================================
  *
  FUNCTION Destroy
    This.GarbageCollect()
    DODEFAULT()
    RETURN

  *====================================
  *-- cAbstractDirector::Release()
  *====================================
  *
  FUNCTION Release()
    This.GarbageCollect()
    DODEFAULT()
    RETURN


  *====================================
  *-- cAbstractDirector::Garbagecollect()
  *====================================
  *
  FUNCTION GarbageCollect()
  This.aDialogs= .NULL.
  THIS.aLanguages = NULL
  RETURN


ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c M s g S v c ( class cMessageDirector)
*          : Concrete implementation of the abstract message director.
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cMsgSvc AS cMessageDirector

  *-- Horizontal and vertical offsets
  nOffsetHorizontal= 0
  nOffsetVertical  = 0
  *===========================================
  *-- cMsgSvc::CookieSwap(tcText,tcCookieText)
  *  (e.g. tcText =  "almost done, %C1%")
  *  (e.g. tcCookieText = "Louise")
  *===========================================
  FUNCTION CookieSwap(tcText,tcCookieText)
  LOCAL lcWorkPiece, lnNumToSwap, lcCounter, lcVariable
  lcWorkPiece = tcText

  DO CASE
  CASE TYPE( [tcCookieText]) = [C]
    *-- We may have more than one string to swap-in
    lnNumToSwap = tokens( tcCookieText, ccParseDelim, .T.)
    FOR lnCounter = 1 TO lnNumToSwap
      lcCounter = STR(lnCounter,1)
      *-- What's our variable "word"?
      lcVariable = tokennum( tcCookieText, lnCounter, ccParseDelim, .T.)

      *-- Accept n occurrences of %C% and %Cn% for first (perhaps only) swap
      DO CASE
        *-- uppercase
      CASE [%C]+lcCounter+[%] $ lcWorkPiece
        lcWorkPiece = STRTRANC( lcWorkPiece, ;
          [%c]+lcCounter+[%], ;
          lcVariable)
        *-- lowercase
      CASE [%c]+lcCounter+[%] $ lcWorkPiece
        lcWorkPiece = STRTRANC( lcWorkPiece, ;
          [%c]+lcCounter+[%], ;
          lcVariable)
        *-- uppercase
      CASE "%C%" $ UPPER(lcWorkPiece)
        lcWorkPiece = STRTRANC( lcWorkPiece, [%C%], lcVariable, 1)
        *-- lowercase
      CASE "%c%" $ UPPER(lcWorkPiece)
        lcWorkPiece = STRTRANC( lcWorkPiece, [%c%], lcVariable, 1)
      ENDCASE
    ENDFOR

    IF "%C" $ UPPER(lcWorkPiece)
      *-- Here we've stripped all tokens except unfulfilled suffix ones.  Cleanup.
      FOR lnCounter = 1 TO 9
        lcCounter = STR(lnCounter,1)
        IF !"%C" $ UPPER(lcWorkPiece)
          EXIT
        ENDIF

        DO CASE
          *-- uppercase
        CASE [%C]+lcCounter+[%] $ lcWorkPiece
          lcWorkPiece = STRTRANC( lcWorkPiece, ;
            [%c]+lcCounter+[%], '')
          *-- lowercase
        CASE [%c]+lcCounter+[%] $ lcWorkPiece
          lcWorkPiece = STRTRANC( lcWorkPiece, ;
            [%c]+lcCounter+[%], '')
          *-- uppercase
        CASE "%C%" $ UPPER(lcWorkPiece)
          lcWorkPiece = STRTRANC( lcWorkPiece, [%C%], '' )
          *-- lowercase
        CASE "%c%" $ UPPER(lcWorkPiece)
          lcWorkPiece = STRTRANC( lcWorkPiece, [%c%], '')
        ENDCASE
      ENDFOR
    ENDIF
  ENDCASE
  RETURN lcWorkPiece

  *===========================================
  *-- cMsgSvc::Init()
  *===========================================
  FUNCTION INIT()
  DoDefault()
  *-- Stock builder ID's and builders
  This.SetBuilder( "Default", "cDialogBuilder")
  This.SetBuilder( "Ok", "cDialogBuilder")
  This.SetBuilder( "Ync", "cDialogBuilder")
  This.SetBuilder( "Nyc", "cDialogBuilder")
  This.SetBuilder( "Ari", "cDialogBuilder")
  This.SetBuilder( "Yn", "cDialogBuilder")
  This.SetBuilder( "Ny", "cDialogBuilder")
  This.SetBuilder( "Text", "cTextBuilder")
  This.SetBuilder( "Oc", "cDialogBuilder")
  This.SetBuilder( "Rc", "cDialogBuilder")
  This.SetBuilder( "Cancel", "cDialogBuilder")
  This.SetBuilder( "Therm", "cThermBuilder")
  This.SetBuilder( "Wait", "cWaitWindBuilder")
  This.SetBuilder( "Nowait", "cWaitWindBuilder")
  This.SetBuilder( "Working", "cWorkingDialogBuilder")
  This.SetBuilder( "Tip", "cTipBuilder")

  *====================================
  *-- cMsgSvc::MsgSvc
  *====================================
  * Workhorse function -- message "director"
  *
  * Interface notes (by type)
  *   CLL - Lookup in MsgSvc
  *
  *   CCL - Lookup with cookie substitution
  *
  *   CCN - Text substitution with thermometer update
  *
  *   CNL - Lookup [IF therm THEN setPercent(n)
  *
  *   NCC - Text substitution with thermometer update
  *
  *   NLL - IF EXIST( Therm) THEN LIFO therm update
  *         ELSE QuickTherm+update
  *
  *   NCL - IF EXIST( Therm )THEN LIFO therm/message update
  *         ELSE QuickTherm+update+message
  *
  *   LLL - IF EXIST( Working) THEN LIFO Working.Release()
  *
  *
  FUNCTION MsgSvc( txPassed1, txPassed2, txPassed3, txPassed4)
  LOCAL ;
    lcLangField, ;
    lcRetVal, ;
    llSwap, ;
    lcFunction, ;
    lcWaitTime, ;
    llForceTextReturn, ;
    llTherm, ;
    llWaitWind, ;
    llWorking, ;
    loParameterPackage, ;
    loSpecPackage, ;
    loSetExact, ;
    lcPTypes, ;
    lnI, ;
    lcI, ;
    lxPassed1, ;
    lxPassed2, ;
    lxPassed3, ;
    loDialog, ;
    lxPassed4, ; && added for ChilkatVFP
    lcLanguage  && added for ChilkatVFP

  lxPassed1= txPassed1
  lxPassed2= txPassed2
  lxPassed3= txPassed3
  lxPassed4= txPassed4

  *-- We release "working" dialogs with empty calls, like this: MsgSvc()
  loDialog = This.GetDialogHandle("Working")
  IF !ISNULL(loDialog) AND TYPE("lxPassed1")="L" AND ! lxPassed1
    loDialog.Release()
  ELSE
    IF EMPTY(lxPassed1)
      WAIT CLEAR   && We may have a WAIT WINDOW UP
      RETURN
    ENDIF
  ENDIF

  loSetExact= CREATE("SetExact", "OFF")

  *-- Process case where the call requests a
  *-- text string returned rather than a dialog.
  llForceTextReturn= .F.
  IF TYPE( "lxPassed1")= "C" AND ;
      ccForceTextReturn $ UPPER( lxPassed1)

    llForceTextReturn= .T.
    lxPassed1= STRTRAN(UPPER(lxPassed1), ccForceTextReturn)
  ENDIF

  *-- Create a spec package to pass around as a parameter
  loSpecPackage= CREATE( "cPackage")

  *-- Package the parameters
  loParameterPackage= CREATE( "cPackage")
  loSpecPackage.AddItem("Call parameters", loParameterPackage)

  *-- Place the call parameters in the package
  FOR lnI= 1 TO 3
    lcI=STR( lnI,1)
    loParameterPackage.AddItem( "Parameter"+lcI, lxPassed&lcI.)
  ENDFOR

  *-- loParameterPackage is already stored within loSpecPackage
  *-- so delete it now... it's no longer needed.
  loParameterPackage=.NULL.


  lcPTypes= TYPE("lxPassed1")+ ;
    TYPE("lxPassed2")+ ;
    TYPE("lxPassed3")

  *##########################################
  * Parameter pre-processing and dispatching
  *##########################################
  LOCAL loDialog
  DO CASE

    *-- If there is a number in the call, assume we are
    *-- dealing with a thermometer.
  CASE "N" $ lcPTypes

    *-- Assume a thermometer
    llTherm= .T.

    *-- Text substitution required?
    IF (lcPTypes = "CCN") OR (lcPTypes = "NCC")
      llSwap = .T.
    ENDIF
    *-- If the numeric value is non-zero, then update
    *-- an existing therm.
    LOCAL lcZeroPos
    lcZeroPos= STR(AT("N", lcPTypes),1)

    IF lxPassed&lcZeroPos > 0
      *-- Is there a therm on the stack? If so,
      *-- update it and we're done.
      loDialog= This.GetDialogHandle("Therm")
      IF ! ISNULL( loDialog)
        LOCAL lnI, lcI, lxTest
        *-- Due to predicate dependency on nPercent,
        *-- process for percentage first
        FOR lnI= 1 to 3
          lcI= STR( lnI,1)
          lxTest= lxPassed&lcI
          IF TYPE( "lxtest")= "N"
            loDialog.SetPercent( lxTest)
            *-- ... which might kill loDialog...
            EXIT
          ENDIF
        ENDFOR
        LOCAL lxText

        *-- Process for Text next
        IF ! ISNULL( loDialog)
          FOR lnI= 1 to 3
            lcI= STR( lnI,1)
            lxTest= lxPassed&lcI
            IF TYPE( "lxtest")= "C"
              IF !(UPPER( lxTest)=="THERM")
                loDialog.SetText( lxTest)
              ENDIF
            ENDIF
          ENDFOR
        ENDIF
        *-- Done
        loSpecPackage.release( )  &&-- Added by Anthony L. Testi July-29-2004
        RETURN
      ENDIF
    ENDIF

    *-- If we get here, then we're talking of
    *-- a new Dialog... Proceed as normal, except...
    IF lcPTypes= "NLL"
      lxPassed2= lxPassed1
      lxPassed1= "Therm Default"
    ENDIF

    *-- Swap the order if the numeric is first
    IF lcPTypes= "NC"
      LOCAL lx
      lx= lxPassed2
      lxPassed2= lxPassed1
      lxPassed1= lx
    ENDIF

    *-- Text substitution with thermometer
    IF lcPTypes= "NCC"
      lxPassed2= lxPassed3
    ENDIF

    *-- Embedded cookie swapping
  CASE lcPTypes= "CC"
    llSwap = .T.

  CASE lcPTypes= "LLL"
    *-- Dismissing a Working message
    loDialog= This.GetDialogHandle("Working")
    IF ! ISNULL( loDialog)
      loDialog.Release( )
    ENDIF
    *-- A desired side effect, allowing msgsvc().
    *-- Open resource table.
    loSpecPackage.release( )  &&-- Added by Anthony L. Testi July-29-2004
    RETURN This.OpenTable()

  ENDCASE

  *-- Open MsgSvc
  IF ! This.OpenTable()
    loSpecPackage.release( )  &&-- Added by Anthony L. Testi July-29-2004
    RETURN ''
  ENDIF

  LOCAL lcOrig
  lcOrig= lxPassed1

  *-- Change to allow for Length
  IF TYPE("lxPassed1")= "C"
    LOCAL lcTestAlias
    lcTestAlias=  This.cAlias
    lxPassed1= UPPER( LEFT( lxPassed1, LEN(&lcTestAlias..cKey)))
  ENDIF

  *-- Default return is blank string
  lcRetVal= ''

  *-- Seek the cookie in the table
  IF NOT SEEK( lxPassed1, (This.cAlias))
    IF EMPTY( lxPassed2)
      lxPassed2= ''
    ENDIF

    IF This.lUpdateTable AND ok2insert( This.cAlias)
      INSERT INTO (This.cAlias) ( cKey, cfunction, cOriginal) ;
        VALUES ( lcOrig, ;
        IIF(llTherm,"THERM","Ok"), ;
        lcOrig)
    ENDIF
  ENDIF


  *-- Scatter to an object
  LOCAL loMsgSpec, lcOldAlias
  lcOldAlias=Alias()
  SELECT (This.cAlias)
  SCATTER NAME loMsgSpec MEMO

  loSpecPackage.AddItem( "Message spec", loMsgSpec)

  IF ! EMPTY(lcOldAlias)
    SELECT (lcOldAlias)
  ENDIF

  ** ChilkatVFP object as fourth parameter test
  IF TYPE([lxPassed4.Name]) == [C] ;
  AND PEMSTATUS(lxPassed4, [cMsgSvcLanguage], 5) 

    m.lcLanguage = lxPassed4.cMsgSvcLanguage

    ** If the cMsgSvcLanguage is set to "Original", there's nothing to do.
    ** If it's set to one of the suppported languages, we'll swap that 
    ** field into the loMsgSpec.cOriginal variable.

    ** Something to do test
    IF NOT (EMPTY(m.lcLanguage) OR UPPER(m.lcLanguage) == [ORIGINAL])

      ** Matched on the supported languages test
      IF ASCAN(THIS.aLanguages, m.lcLanguage, -1, -1, 1, 7) > 0

        ** Swap the field...
        loMsgSpec.cOriginal = EVALUATE([loMsgSpec.c] + m.lcLanguage)

      ENDIF ASCAN(THIS.aLanguages, m.lcLanguage, -1, -1, 1, 7) > 0
      ** End matched on the supported languages test

    ENDIF NOT (EMPTY(m.lcLanguage) OR UPPER(m.lcLanguage) == [ORIGINAL])
    ** End something to do test

  ENDIF TYPE([lxPassed4.Name]) == [C] ;
  AND PEMSTATUS(lxPassed4, [cMsgSvcLanguage], 5) 
  ** End ChilkatVFP object as fourth parameter test

  loMsgSpec.cOriginal= MsgEvlTXT( loMsgSpec.cOriginal)

  *-- Cookie substitution
  IF llSwap
    LOCAL lcWorkPiece
    lcWorkPiece= loMsgSpec.cOriginal
    *[eg] 12/11/1998 12:55:46 PM New function CookieSwap() called
    lcWorkPiece = This.CookieSwap(lcWorkPiece,lxPassed2)
    loMsgSpec.cOriginal= MsgEvlTXT(lcWorkPiece)

    DO CASE
    CASE TYPE( [lxPassed2]) = [N]
      loMsgSpec.cOriginal = STRTRAN( loMsgSpec.cOriginal, [%N%], ALLTRIM( STR( lxPassed2)))
    CASE TYPE( [lxPassed2]) = [D]
      loMsgSpec.cOriginal = STRTRAN( loMsgSpec.cOriginal, [%D%], DTOC( lxPassed2))
    ENDCASE
  ENDIF

  *-- A pipe symbol is akin to CR+LF
  loMsgSpec.cOriginal = STRTRAN( loMsgSpec.cOriginal, "|", ccCr_Lf)

  *-- Mangle the animation if globally required
  IF !EMPTY(loMsgSpec.cGuiVisual) AND ;
      ! This.lAnimateIcons  AND ;
      ATC("Animate",loMsgSpec.cGuiVisual )> 0

    loMsgSpec.cGuiVisual= LEFT(loMsgSpec.cGuiVisual, ;
      ATC("Animate",loMsgSpec.cGuiVisual )-1)
  ENDIF

  *-- Pass Object to an appropriate builder
  LOCAL loMsg, lcBuilderName, lcBuilderCookie

  loMsg= .NULL.
  lcBuilderCookie= MsgEvlTXT(loMsgSpec.cfunction)

  *-- Hook for TEXT return values
  IF UPPER( lcBuilderCookie)= "TEXT" OR ;
      llForceTextReturn
    loSpecPackage.release( )  &&-- Added by Anthony L. Testi July-29-2004
    RETURN ALLTRIM( loMsgSpec.cOriginal)
  ENDIF

  lcBuilderName= This.GetBuilder( lcBuilderCookie)
  loBuilder    = CREATE( lcBuilderName)

  ************!!!!!!!!!!!!*****************
  loBuilder.Build( @loMsg, loSpecPackage)
  ************!!!!!!!!!!!!*****************

  *-- Place MessageObject in aDialogs array
  IF !ISNULL( loMsg) AND TYPE( "loMsg")= "O"
    LOCAL lnThisDialog
    IF ALEN( This.aDialogs)= 1 AND ISNULL( This.aDialogs[1])
      lnThisDialog= 1
    ELSE
      DIMENSION This.aDialogs( ALEN( This.aDialogs)+ 1)
      lnThisDialog= ALEN( This.aDialogs)
    ENDIF
    This.aDialogs[ lnThisDialog]= loMsg
    This.aDialogs[ lnThisDialog].oReturnPointer= THIS

    LOCAL lcAlias
    lcAlias= This.cAlias

    IF EMPTY( &lcAlias..cRow + &lcAlias..cCol)
      This.aDialogs[ lnThisDialog].AutoCenter= .T.
    ENDIF

    *-- Add Horizontal and Vertical Offset properties (Kevin McNeish request)
    IF This.nOffsetHorizontal!=0 AND;
        This.nOffsetVertical!=0
      This.aDialogs[ lnThisDialog].TOP = This.aDialogs[ lnThisDialog].top+This.nOffsetHorizontal
      This.aDialogs[ lnThisDialog].Left= This.aDialogs[ lnThisDialog].left+This.nOffsetVertical
      This.aDialogs[ lnThisDialog].AutoCenter= .F.
    ENDIF
    *-------------------------------------------------------------------
    *-- This next line of code brought here because SetFocus() is
    *-- triggering premature visibility in VFP 5
    loBuilder.SetButtonFocus( This.aDialogs[ lnThisDialog], @loSpecPackage)
    *----------------------------------------------------------------

    *-- Release unneeded object references
    loBuilder.Release()
    Release loMsgSpec
    loSpecPackage.Release()

    *-- With thanks to Gene Pasquini
    IF upper(alltrim(&lcAlias..cBell)) = "Y"
      ?? chr(7)
    ENDIF

    This.aDialogs[ lnThisDialog].SHOW()

    *-- IF the dialog was modal, it's gone
    *-- so clean up the stack
    LOCAL lnMaxDialog
    lnMaxDialog= ALEN( This.aDialogs)
    DO WHILE lnMaxDialog > 1 AND ISNULL( This.aDialogs[ lnMaxDialog])
      lnMaxDialog= lnMaxDialog-1
      DIMENSION This.aDialogs[ lnMaxDialog]
    ENDDO
  ELSE
    loSpecPackage.release( )  &&-- Added by Anthony L. Testi July-29-2004
    RETURN This.ReturnValue

  ENDIF

  RETURN IIF( lnThisDialog <= ALEN(This.aDialogs) AND ;
    ! ISNULL(This.aDialogs[lnThisDialog]) AND ;
    TYPE( "This.aDialogs[lnThisDialog]")="O"  , ;
    This.aDialogs[lnThisDialog],;
    This.ReturnValue)

  *====================================
  *-- cMsgSvc::CloseTable
  *====================================
  * Close the class's resource table
  *
  FUNCTION CloseTable
  USE IN (This.cAlias)

  RETURN

  *====================================
  *-- cMsgSvc::OpenTable
  *====================================
  * Open the class's resource table
  *
  FUNCTION OpenTable

  LOCAL lcOldError, lnError
  lcOldError= ON( "Error")
  lnError= 0
  ON ERROR lnError= -1

  *-- make sure the table's open
  IF ! USED( This.cAlias)
    LOCAL lcTable
    lcTable= LOCFILE( This.cTable, [DBF], [Where is ]+ This.cTable+[?] )
    IF FILE(lcTable)
      USE (lcTable) ORDER TAG (This.cTag) ALIAS (This.cAlias)IN 0
    ELSE
      WAIT WINDOW "No table selected!"
      RETURN .F.
    ENDIF
  ENDIF
  IF EMPTY( ORDER( This.cAlias))
    SET ORDER TO TAG (This.cTag) IN (This.cAlias)
  ENDIF

  IF lnError= -1
    WAIT WINDOW "Cannot open "+ This.cAlias+ " table!"
  ENDIF
  ON ERROR &lcOldError
  RETURN USED( This.cAlias)

  *====================================
  *-- cMsgSvc::Version(n)
  *====================================
  * MsgSvc Version()
  *
  FUNCTION Version(n)
  RETURN MSGSVCVERSION

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: S E T E X A C T
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS SetExact AS Relation
  cOldExact= .NULL.

  *====================================
  *-- SetExact::Init( c)
  *====================================
  * Save and set SET EXACT
  *
  FUNCTION Init( tcNew)
  This.cOldExact= SET("Exact")
  IF TYPE( "tcNew")= "C"
    SET EXACT &tcNew
  ENDIF

  *====================================
  *-- SetExact::Init( c)
  *====================================
  * Reset SET EXACT
  *
  FUNCTION Destroy
  LOCAL lcString
  lcString= This.cOldExact
  SET EXACT &lcString

ENDDEFINE

*_BLD
*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c A b s t r a c t B u i l d e r
* Version..: Feb 27 1997
*-- Roles of a builder
*--   Created by the Director
*--   Handles build request from the director
*--   Passes it back to the director
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cAbstractBuilder AS Relation
  Visible= .F.

  *====================================
  *-- cAbstractBuilder::Build( oo)
  *====================================
  * Define the interface...
  *
  FUNCTION Build( to1, to2)

  RETURN

  *====================================
  *-- cAbstractBuilder::Release()
  *====================================
  * Release this object
  *
  FUNCTION RELEASE
  Release THIS
  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c A b s t r a c t M s g B u i l d e r
* Version..: April 5 1996
*-- Roles of a builder
*--   Created by the Director
*--   Handles request from the director
*--   Creates the appropriate dialog
*--   Passes it back to the director
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cAbstractMsgBuilder AS cAbstractBuilder
  cFormClass  =  ""
  cButtonClass=  ""
  cImageClass =  ""
  cTextClass  =  ""
  cThermClass=   ""
  cTimerClass =  ""
  cTable      =  ccTABLE

  cTitleProp  =  "cTitle"
  cErrorProp  =  "cErrNo"

  lButtons= .F.
  lText   = .F.
  lTitle  = .T.
  lImage  = .T.
  lArrange= .T.
  lTimer  = .T.

  FUNCTION AddButtons( toDialog, toSpecPackage)
  FUNCTION AddImage( toDialog, toSpecPackage)
  FUNCTION Addtext( toDialog, toSpecPackage)
  FUNCTION AddTherm( toDialog, toSpecPackage)
  FUNCTION AddTimer( toDialog, toSpecPackage)
  FUNCTION AddTitle( toDialog, toSpecPackage)
  FUNCTION Arrange( toDialogPackage)
  FUNCTION Build( toDialog, toSpecPackage)



  FUNCTION SetReturnType(toDialog, toSpecPackage)

  RETURN


  *====================================
  *-- cAbstractMsgBuilder::Destroy()
  *====================================
  *
  FUNCTION Destroy
    This.GarbageCollect()
    DODEFAULT()
    RETURN

  *====================================
  *-- cAbstractMsgBuilder::Release()
  *====================================
  *
  FUNCTION Release()
    This.GarbageCollect()
    DODEFAULT()
    RETURN


  *====================================
  *-- cAbstractMsgBuilder::Garbagecollect()
  *====================================
  *
  FUNCTION GarbageCollect()
  RETURN


ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c G e n e r i c M s g  B u i l d e r
* Version..: April 5 1996
* Assumes..: Image is to left of text
*            Buttons are below text
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cGenericMsgBuilder AS cAbstractMsgBuilder
  cFormClass  =  "cFrmMsgSvc"
  cButtonClass=  "cCtrCommandButton"
  cImageClass =  "cImgMsgSvc"
  cTextClass  =  "cEdtMsgSvc"
  cThermClass =  "cCtrTherm"
  cTimerClass =  "cTmrMsgSvc"

  lButtons= .T.
  lText   = .T.

  *====================================
  *-- cGenericMsgBuilder::Build(oo)
  *====================================
  *
  FUNCTION Build( toDialog, toSpecPackage)
  DODEFAULT( @toDialog, toSpecPackage)
  LOCAL loMessageSpec
  loMessageSpec= toSpecPackage.GetItem("Message Spec")
  loCallParameters = toSpecPackage.GetItem("Call parameters")

  *-- Process special cases
  *-- Go through the call parameters, looking for special
  *-- Button and Text cookies
  LOCAL lnI, lcI, lxTest

  FOR lnI= 1 TO loCallParameters.ItemCount
    lcI= STR( lnI, 1)
    lxTest= loCallParameters.GetItem( "Parameter"+lcI)

    IF TYPE("lxTest")<> "C"
      LOOP
    ELSE
      lxTest= UPPER( STRTRAN(lxTest," "))
    ENDIF

    IF "NOBUTTON" $ lxTest ;
        OR "NOBUTTON" $ UPPER( loMessageSpec.cfunction)
      This.lButtons= .F.
    ENDIF

    IF "NOTEXT" $ lxTest ;
        OR "NOTEXT" $ UPPER( loMessageSpec.cfunction)
      This.lText= .F.
    ENDIF

  ENDFOR

  *-- Create the dialog
  toDialog=CREATE( This.cFormClass)

  *-- Half-height titlebars
  IF "[HALFHEIGHT]" $ UPPER( loMessageSpec.cTitle)
    toDialog.HalfHeightCaption= .T.
  ENDIF

  *-- If [notitle] appears in cTitle, set Titlebar=0
  IF "[NOTITLE]" $ UPPER( loMessageSpec.cTitle)
    This.lTitle= .F.
    toDialog.Titlebar= 0
  ENDIF

  *-- Title details
  IF This.lTitle
    This.AddTitle( @toDialog, @toSpecPackage)
  ENDIF

  *-- Add an image
  IF This.lImage
    This.AddImage( @toDialog, @toSpecPackage)
  ENDIF

  *-- Add text - if "NOTEXT" option selected, create empty oText object
  This.Addtext( @toDialog, @toSpecPackage)

  *-- Thermometer
  IF "THERM" $ UPPER( loMessageSpec.cfunction)
    This.AddTherm( @toDialog, @toSpecPackage)
    loMessageSpec.cfunction= LEFT(loMessageSpec.cfunction, MAX(0,ATC("Therm",loMessageSpec.cfunction)-1))
  ENDIF

  *-- Buttons
  This.AddButtons( @toDialog, @toSpecPackage)

  *-- If "NOBUTTON" option selected, out-of-scope button added in order to process <Esc>
  IF !(This.lButtons)
    toDialog.oButtons.controls(1).top= 999
    toDialog.oButtons.controls(1).left= 999
  ENDIF

  *-- Timer
  IF This.lTimer
    This.AddTimer( @toDialog, @toSpecPackage)
  ENDIF

  *-- Return values
  This.SetReturnType( @toDialog, @toSpecPackage)

  *-- Position the dialog
  This.PositionDialog( @toDialog, @toSpecPackage)

  RETURN

  *====================================
  *-- cGenericMsgBuilder::Arrange(o)
  *====================================
  *
  FUNCTION Arrange( toDialog)
  IF ISNULL( toDialog)
    RETURN .NULL.
  ENDIF
  LOCAL lnI, lnOldMemoWidth, lnMaxWidth, lnMaxHeight, lnWidestLine, llDone

  *-- Position the graphic
  IF TYPE("toDialog.oImage")= "O"
    WITH toDialog.oImage
      .Top = 7* toDialog.nVDBU
      .Left= 7* toDialog.nHDBU
      .Visible= .T.
    ENDWITH
  ENDIF

  *-- Position the text
  IF TYPE("toDialog.oText")= "O"
    WITH toDialog.oText
      .Top = 7* toDialog.nVDBU

      IF TYPE("toDialog.oImage")="O"
        .Left= toDialog.oImage.Left+ toDialog.oImage.Width+ (4* toDialog.nHDBU)
      ELSE
        .Left= 7* toDialog.nHDBU
      ENDIF

      *-- Size the text portion
      lnOldMemoWidth= SET("MemoWidth")
      lnMaxWidth= toDialog.MaxWidth- (7* toDialog.nHDBU)- .Left
      lnMinWidth= toDialog.MinWidth- (7* toDialog.nHDBU)- .Left

      * Pick a reasonable widest maximum first Memowidth
      * 8 is the minimum memowidth in 3.0/5.0
      SET MEMOWIDTH TO MAX( 8, lnMaxWidth/ (FONTMETRIC( 6, .FontName, .FontSize)*0.85))


      DO WHILE .T.
        lnWidestLine= 0
        llDone = .T.   && DWS 11/14/98
        FOR lnI= 1 TO MEMLINES( .Value)
          lnWidestLine= MAX( lnWidestLine, ;
            TXTWIDTH( MLINE( .Value, lnI), ;
            .FontName, ;
            .FontSize)* FONTMETRIC(6, .FontName, .FontSize))

          IF lnWidestLine > lnMaxWidth
            SET MEMOWIDTH TO SET("MEMOWIDTH")- 1  && Slow
            llDone = .F.   && DWS 11/14/98
            EXIT
          ENDIF

        ENDFOR
        IF llDone                                         && DWS 11/14/98
          * if we make it to here, each MEMLINES(.Value)  && DWS 11/14/98
          * is no wider than lnMaxWidth                   && DWS 11/14/98
          EXIT                                            && DWS 11/14/98
        ENDIF                                             && DWS 11/14/98
      ENDDO

      .Width = MAX( toDialog.MinWidth, lnWidestLine+ .Margin+ 3)
      .Height= 18+ ( MAX( 2, MEMLINES( .VALUE))* (FONTMETRIC(1, .FontName, .FontSize)+ ;
        FONTMETRIC(5, .FontName, .FontSize)))

      *-- A final pass to adjust for the case of a single line
      IF MEMLINES( .VALUE)= 1
        .TOP= .TOP + 6 * toDialog.nVDBU
      ENDIF
      .Visible= .T.
      SET MEMOWIDTH to lnOldMemoWidth
    ENDWITH
  ENDIF

  *-- Position the therm bar
  IF TYPE("toDialog.oTherm")= "O"
    WITH toDialog.oTherm
      .Top= (4* toDialog.nVDBU)  && margin before buttons
      lnMaxHeight= 0
      FOR lnI= 1 TO toDialog.ControlCount
        IF toDialog.Controls( lnI).Name= .Name
          LOOP
        ENDIF
        lnMaxHeight= MAX( lnMaxHeight, toDialog.Controls( lnI).Top + toDialog.Controls( lnI).Height)
      ENDFOR
      .Top= .Top + lnMaxHeight
      .Visible= .T.
    ENDWITH
  ENDIF

  *-- Position the buttons
  IF TYPE("toDialog.oButtons")= "O"
    WITH toDialog.oButtons
      .Top= (4* toDialog.nVDBU)  && margin before buttons
      lnMaxHeight= 0
      FOR lnI= 1 TO toDialog.ControlCount
        IF toDialog.Controls( lnI).Name= .Name
          LOOP
        ENDIF
        lnMaxHeight= MAX( lnMaxHeight, toDialog.Controls( lnI).Top + toDialog.Controls( lnI).Height)
      ENDFOR
      .Top= .Top + lnMaxHeight
      .Visible= .T.
    ENDWITH
  ENDIF

  *-- Small hook here:  Make the text container the same width
  *-- as the button container if the button container is larger
  *-- than the text container.
  IF TYPE("toDialog.oButtons")= "O"
    IF toDialog.oButtons.Width>toDialog.oText.Width
      toDialog.oText.Width = toDialog.oButtons.Width
    ENDIF
  ENDIF

  IF ISNULL( toDialog)
    RETURN
  ENDIF

  *  LOCAL lnI, lnMaxHeight, lnMaxWidth
  WITH toDialog
    *-- Size the dialog
    lnMaxHeight= .MinHeight
    lnMaxWidth = .MinWidth

    FOR lnI= 1 TO toDialog.ControlCount
      lnMaxHeight= MAX( lnMaxHeight, .Controls( lnI).Top+  .Controls( lnI).Height)
      lnMaxWidth = MAX( lnMaxWidth,  .Controls( lnI).Left+ .Controls( lnI).Width)
    ENDFOR

    .Height= (7* .nVDBU)+ lnMaxHeight
    .Width = 2*(7* .nHDBU)+ lnMaxWidth

    *-- Final fine-tune of thermometer
    IF TYPE("toDialog.oTherm")= "O"
      .oTherm.Left= .Width/2 - .oTherm.Width/2
    ENDIF

    *-- Final fine-tune of buttons
    IF TYPE("toDialog.oButtons")= "O"
      .oButtons.Left= .Width/2 - .oButtons.Width/2
      .oButtons.Top= MAX( .oButtons.Top, .Height- (7* .nVDBU)- .oButtons.Height)
    ENDIF

    *-- Start the timer, if there's one
    IF TYPE("toDialog.oTimer")= "O"
      .oTimer.Enabled= .T.
    ENDIF

    RETURN

  ENDWITH

  *====================================
  *-- cGenericMsgBuilder::AddTitle(oo)
  *====================================
  *
  FUNCTION AddTitle( toDialog, toSpecPackage)
  LOCAL loMessageSpec, lcTitle, lnPos1, lcToken
  loMessageSpec= toSpecPackage.GetItem("Message Spec")

  LOCAL lcTitle
  lcTitle= "loMessageSpec."+ This.cTitleProp

  *-- Remove [halfheight] and [notitle] tokens
  IF "[HALFHEIGHT]" $ UPPER( &lcTitle)
    lnPos1= AT("[HALFHEIGHT]",UPPER( &lcTitle))
    lcToken= SUBSTR(&lcTitle,lnPos1,12)
    &lcTitle= STRTRAN(&lcTitle,lcToken,"")
  ENDIF

  IF "[NOTITLE]" $ UPPER( &lcTitle)
    lnPos1= AT("[NOTITLE]",UPPER(&lcTitle))
    lcToken= SUBSTR(&lcTitle,lnPos1,9)
    lcTitle= STRTRAN( &lcTitle,lcToken,"")
  ENDIF

  IF TYPE( "&lcTitle") <> "U"
    lcTitle= ALLTRIM(&lcTitle)
    IF !EMPTY( lcTitle)
      *-- "\" means never a title, even in Windows
      IF ALLTRIM( lcTitle) == "\"
        toDialog.Caption= ""
        RETURN
      ENDIF

      *-- Build the title, including error number...
      IF !EMPTY( lcTitle)
        toDialog.Caption = MsgEvlTXT( ALLTRIM( lcTitle))
      ENDIF
    ENDIF
  ENDIF

  LOCAL lcError
  lcError= "loMessageSpec."+ This.cErrorProp
  IF TYPE( "&lcError") <> "U"
    lcError= ALLTRIM(&lcError)
    IF !EMPTY( lcError)
      toDialog.Caption = IIF(EMPTY(toDialog.Caption), ;
        MsgEvlTXT(ccDEFAULTDIALOGCAPTION), ;
        toDialog.Caption) ;
        +  + [ Error No ]+ ALLTRIM( MsgEvlTxt(lcError))

    ENDIF
  ENDIF


  *-- In Windows all boxes have titles...
  IF EMPTY( toDialog.Caption)
    toDialog.Caption= MsgEvlTXT( ccDEFAULTDIALOGCAPTION)
  ENDIF

  toDialog.MinWidth= MAX( toDialog.MinWidth ,FONTMETRIC(6,"MS Sans Serif", 8, "B") * TXTWIDTH(toDialog.Caption,"MS Sans Serif", 8, "B"))

  RETURN

  *====================================
  *-- cGenericMsgBuilder::AddImage(oo)
  *====================================
  *
  FUNCTION AddImage( toDialog, toSpecPackage)
  LOCAL loMessageSpec
  loMessageSpec= toSpecPackage.GetItem( "Message spec")

  IF !EMPTY( loMessageSpec.cGuiVisual)
    toDialog.AddObject( "oImage", This.cImageClass, toSpecPackage)
  ENDIF

  RETURN

  *====================================
  *-- cGenericMsgBuilder::AddButtons(oo,oo)
  *====================================
  *
  FUNCTION AddButtons( toDialog, toSpecPackage)
  toDialog.AddObject( "oButtons", This.cButtonClass, toSpecPackage)

  RETURN

  *====================================
  *-- cGenericMsgBuilder::AddTherm(oo)
  *====================================
  *
  FUNCTION AddTherm( toDialog, toSpecPackage)
  toDialog.AddObject( "oTherm", This.cThermClass, toSpecPackage)

  RETURN

  *====================================
  *-- cGenericMsgBuilder::Addtext(oo)
  *====================================
  *
  FUNCTION Addtext( toDialog, toSpecPackage)
  LOCAL loMessageSpec
  loMessageSpec= toSpecPackage.GetItem( "Message spec")

  toDialog.AddObject( "oText", This.cTextClass, toSpecPackage)
  *-- If "NOTEXT" option is selected, only empty oText object is created
  IF This.lText
    toDialog.SetText( loMessageSpec.cOriginal)
    toDialog.SetTextAlignment( loMessageSpec.cAlignment)
  ENDIF

  RETURN

  *====================================
  *-- cGenericMsgBuilder::Addtimer(oo)
  *====================================
  *
  FUNCTION AddTimer( toDialog, toSpecPackage)
  LOCAL loMessageSpec
  loMessageSpec= toSpecPackage.GetItem( "Message spec")
  *-- We might require a timer...
  IF VAL( loMessageSpec.cTimeout)> 0
    toDialog.AddObject( "oTimer", This.cTimerClass, toSpecPackage)
  ENDIF

  RETURN


  *====================================
  *-- cGenericMsgBuilder::PositionDialog(oo)
  *====================================
  * Position the dialog.
  *
  FUNCTION PositionDialog(toDialog, toSpecPackage)
  LOCAL loMessageSpec
  loMessageSpec= toSpecPackage.GetItem( "Message spec")
  IF !EMPTY( loMessageSpec.cRow) OR ;
      !EMPTY( loMessageSpec.cCol)

    * MsgEvlTxt() allows {{ expression }} in cRow and cCol fields.
    toDialog.Top = VAL( TRANSFORM( MsgEvlTXT( loMessageSpec.cRow)))
    toDialog.Left= VAL( TRANSFORM( MsgEvlTXT( loMessageSpec.cCol)))
    toDialog.AutoCenter= .F.
  ENDIF

  RETURN

  *====================================
  *-- cGenericMsgBuilder::SetButtonFocus(oo)
  *====================================
  * Set the apropriate focus.
  *
  FUNCTION SetButtonFocus(toDialog, toSpecPackage)
  LOCAL loMessageSpec
  loMessageSpec= toSpecPackage.GetItem( "Message spec")
  LOCAL lnObjectSpec
  IF ! EMPTY(loMessageSpec.cObject)
    lnObjectSpec= VAL( loMessageSpec.cObject)
  ELSE
    lnObjectSpec=1
  ENDIF

  IF TYPE( "toDialog.oButtons") = "O" AND ;
      toDialog.oButtons.ControlCount >= lnObjectSpec

    DO CASE
    CASE lnObjectSpec > 0
      * toDialog.oButtons.Controls( lnObjectSpec).SetFocus()
      KEYBOARD REPLICATE( "{TAB}", m.lnObjectSpec - 1 ) CLEAR      && Thanks Sebastien!

    OTHERWISE
      * New in V.8 Initial focus on a non-button to "force" user to pick
      toDialog.oButtons.AddObject( "btnInitialFocus", "cCmdInitialFocus")
      toDialog.oButtons.btnInitialFocus.Visible= .T.
      toDialog.oButtons.btnInitialFocus.SetFocus()
    ENDCASE
  ENDIF

  RETURN

  *====================================
  *-- cGenericMsgBuilder::SetReturnType(oo)
  *====================================
  *
  FUNCTION SetReturnType(toDialog, toSpecPackage)
  LOCAL loMessageSpec
  loMessageSpec= toSpecPackage.GetItem( "Message spec")
  DO CASE
  CASE TYPE( "loMessageSpec.cRetType") = "U"
  CASE EMPTY( loMessageSpec.cRetType)
  CASE loMessageSpec.cRetType= "C"
    toDialog.nReturnIndex= 1

  CASE loMessageSpec.cRetType= "N"
    toDialog.nReturnIndex= 2

  CASE loMessageSpec.cRetType= "L"
    toDialog.nReturnIndex= 3

  CASE loMessageSpec.cRetType= "M"
    toDialog.nReturnIndex= 4

  ENDCASE

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c D i a l o g B u i l d e r
* Version..: March 31 1996
* Assumes..: Image is to left of text
*            Buttons are below text
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cDialogBuilder AS cGenericMsgBuilder
  *====================================
  *-- cDialogBuilder::Build(oo)
  *====================================
  FUNCTION BUILD(toDialog, toSpecPackage)
  DODEFAULT( @toDialog, @toSpecPackage)
  This.Arrange( @toDialog)
ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c W o r k i n g D i a l o g B u i l d e r
* Version..: March 31 1996
* Assumes..: Image is to left of text
*            Buttons are below text
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cWorkingDialogBuilder AS cGenericMsgBuilder
  cFormClass  =  "cFrmWorkingMsgSvc"
  lButtons= .T.
  lText   = .T.

  *====================================
  *-- cWorkingDialogBuilder::Build(oo)
  *====================================
  FUNCTION BUILD(toDialog, toSpecPackage)
  DODEFAULT( @toDialog, @toSpecPackage)
  This.Arrange( @toDialog)

  RETURN

ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c T h e r m B u i l d e r
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cThermBuilder AS cGenericMsgBuilder
  cFormClass  =  "cFrmThermMsgSvc"
  lButtons= .T.
  lText   = .T.

  *====================================
  *-- cThermBuilder::Build(oo)
  *====================================
  FUNCTION BUILD(toDialog, toSpecPackage)
  DODEFAULT( @toDialog, @toSpecPackage)
  LOCAL loMessageSpec, loCallParameters, lxSecondParameter
  loMessageSpec    = toSpecPackage.GetItem("Message Spec")
  loCallParameters = toSpecPackage.GetItem("Call parameters")

  *-- Go through the call parameters, looking for Numerics
  LOCAL lnI, lcI, lxTest
  FOR lnI= 1 TO loCallParameters.ItemCount
    lcI= STR( lnI, 1)
    lxTest= loCallParameters.GetItem( "Parameter"+lcI)
    IF TYPE( "lxTest")= "N"
      toDialog.SetPercent( lxTest)
    ENDIF
    DO CASE
    CASE TYPE("lnText")<> "C"
    CASE AT( "NOBUTTON", UPPER( STRTRAN(lxTest," "))) > 0
      toDialog.oButtons.Visible= .F.
    CASE AT( "BUTTON", UPPER( STRTRAN(lxTest," "))) > 0
      toDialog.oButtons.Visible= .T.
      LOOP
    ENDCASE
  ENDFOR

  This.Arrange( @toDialog)

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c T i p B u i l d e r
* Version..: April 3 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cTipBuilder AS cGenericMsgBuilder
  cFormClass  =  "cFrmTODMsgSvc"
  lButtons= .F.
  lText   = .F.
  lTitle  = .F.
  lImage  = .F.
  lTimer  = .F.
ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c W a i t W i n d B u i l d e r
* Version..: April 3 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cWaitWindBuilder AS cAbstractMsgBuilder
  * Compatibility note: Schemes not supported anymore since DOS is, er, dead.
  *====================================
  *-- cWaitWindBuilder::Build(oo)
  *====================================
  FUNCTION Build( toDialog, toSpecPackage)
  DODEFAULT( @toDialog, @toSpecPackage)
  LOCAL llWaitWind, llNowait, llNoClear, llWorking, lcRetVal, lnWaitTime, loMessageSpec

  lcWaitTime   = ''
  lnWaitTime   = 0
  loMessageSpec= toSpecPackage.GetItem("Message spec")

  IF [WAIT ] $ UPPER(loMessageSpec.cfunction)
    llWaitWind = .T.

    IF [NOWAIT] $ UPPER(loMessageSpec.cfunction)
      llNowait = .T.
    ENDIF

    IF [NOCLEAR] $ UPPER(loMessageSpec.cfunction)
      llNoClear = .T.
    ENDIF

    IF !EMPTY( loMessageSpec.cTimeout)
      lcWaitTime =  loMessageSpec.cTimeout
    ENDIF

    lnWaitTime = VAL( lcWaitTime)
    *-- We could have a WAIT/NOWAIT *and* a TIMEOUT
    *-- In this case, make the TIMEOUT prevail
    IF lnWaitTime > 0
      llNowait = .F.
    ENDIF

  ENDIF

  IF ! EMPTY( loMessageSpec.cErrno)
    loMessageSpec.cOriginal = strippat( stripext( SYS(16,1))) + ;
       [ Error No ] + ;
      ALLTRIM( MsgEvlTXT(loMessageSpec.cErrno)) + ;
      [ ] + ;
      loMessageSpec.cOriginal
  ENDIF

  IF lnWaitTime > 0
    This.waitwind( loMessageSpec, lnWaitTime)
  ELSE
    This.waitwind( loMessageSpec, llNowait, llNoClear)
  ENDIF
  lcRetVal = ''

  RETURN

  *====================================
  *-- cWaitWindBuilder::WaitWind(oxl)
  *====================================
  FUNCTION waitwind( toMessageSpec, txwaiting, tlNoClear)
  *[eg] 12/15/1998 12:23:47 PM pass message object instead of loMessageSpec.cOriginal
  *  Parameter List....: toMessageSpec - message object
  *                      txWaiting     - Numeric = TIMEOUT
  *                                       .T.= Wait, .F. = NoWait
  *                      tlNoClear     - NOCLEAR

  *-- you only need to pass the first one...

  PRIVATE ;
    lcAnswerVal, ;
    lcWaitType, ;
    llWaiting, ;
    lnWaiting, ;
    llNoClear, ;
    lcPhrase

  lnWaiting  = 0
  llWaiting  = .F.
  lcWaitType = TYPE( "txWaiting")
  lcPhrase   = toMessageSpec.cOriginal

  DO CASE
  CASE lcWaitType = "N"
    lnWaiting = txwaiting
  CASE lcWaitType = "L"
    llWaiting = ! txwaiting
  ENDCASE

  lcAnswerVal= ''
  *[eg] 12/15/1998 10:31:48 AM set screen position for wait windows
  lcPosition = IIF(!EMPTY(toMessageSpec.cRow),"AT " + ALLTR(toMessageSpec.cRow) + "," + ALLTR(toMessageSpec.cCol),"")
  lcNowait   = ''
  lcTime     = ''
  lcNoClear  = IIF(tlNoClear, "NOCLEAR", "")

  DO CASE
  CASE llWaiting                                        && defaults to .F. if nothing was passed...
    lcAnswerVal= "TO lcAnswerVal"
  CASE lnWaiting > 0
    lcAnswerVal= "TO lcAnswerVal"
    lcTime     = "TIME lnWaiting"
  OTHERWISE
    lcNowait= "NOWAIT"
  ENDCASE

  WAIT WINDOW lcPhrase &lcPosition. &lcNowait. &lcTime. &lcAnswerVal. &lcNoClear.

  RETURN lcAnswerVal
ENDDEFINE

*_FRM
*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c F r m M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cfrmMsgSvc AS FORM
  * Base class for message services forms

  *-- Standard form properties
  MinHeight  = 15
  MinWidth   = 175
  MaxWidth   = SYSMETRIC(1) * 0.62
  AlwaysOnTop= .T.
  AutoCenter = .T.
  BorderStyle= 0 && no border
  Caption    = ccDEFAULTDIALOGCAPTION

  Closable   = .T.
  ColorSource= 4 && Windows control panel
  ControlBox = .F.
  Desktop    = .T.
  FontName   = "MS Sans Serif"
  FontSize   = 8
  FontBold   = .F.
  Height     = 175
  MaxButton  = .F.
  ShowWindow = 1
  MinButton  = .F.
  WindowType = 1   && Modal
  cTable     = ccTABLE

  *-- Custom properties
  oReturnPointer= .NULL.
  nReturnIndex = 1
  TYPE = "Dialog"
  nHDBU=  6   && Horizontal Dialog Base Units
  nVDBU=  8   && Vertical and


  *-- Initialize the return array
  DIMENSION aRetVals[4]  && For button return values

  *====================================
  *-- cFrmMsgSvc::Init
  *====================================
  FUNCTION Init
  This.BackColor  = GetSysColor( COLOR_BTNFACE)
  This.FontName   = GetSystemFont()
  *-- Initialize array (bin) of return values
  This.aRetVals[1]= ''   && Original language caption
  This.aRetVals[2]= 0    && Button number
  This.aRetVals[3]= .F.  && First button
  This.aRetVals[4]= 0    && MESSAGEBOX()-Compatible

  *-- Horizontal and Vertical dialog base units
  This.nHDBU = FONTMETRIC(6, This.FontName, This.FontSize)/4
  This.nVDBU = FONTMETRIC(1, This.FontName, This.FontSize)/8

  *====================================
  *-- cFrmMsgSvc::GetPercent( n)
  *====================================
  *
  FUNCTION GetPercent
  RETURN 0

  *====================================
  *-- cFrmMsgSvc::SetPercent( n)
  *====================================
  *
  FUNCTION SetPercent( tnPassed)
  IF TYPE( "Thisform.oImageTimer")= "O" AND ;
      Thisform.oImageTimer.Enabled

    *-- Force an image animation
    Thisform.oImageTimer.Timer()

  ENDIF

  RETURN

  *====================================
  *-- cFrmMsgSvc::SetText( c)
  *====================================
  *
  FUNCTION SetText( tcPassed)
  IF TYPE( "This.oText") = "O" AND ;
      TYPE( "tcPassed") = "C"

    This.oText.Value= ALLTRIM(tcPassed)
  ENDIF

  RETURN

  *====================================
  *-- cFrmMsgSvc::SetAlignment( c)
  *====================================
  *
  FUNCTION SetTextAlignment( tcPassed)
  IF TYPE( "This.oText") = "O" AND ;
      TYPE( "tcPassed") = "C"
    tcPassed= UPPER( tcPassed)
    DO CASE
    CASE EMPTY (tcPassed) or tcPassed= "L"
      This.oText.Alignment= 0
    CASE tcPassed= "C"
      This.oText.Alignment= 2
    CASE tcPassed= "R"
      This.oText.Alignment= 1
    ENDCASE
  ENDIF

  RETURN
  *====================================
  *-- cFrmMsgSvc::Unload
  *====================================
  * Pass the return values up the tree
  FUNCTION Unload
  IF ! ISNULL( This.oReturnPointer)
    This.oReturnPointer.ReturnValue= This.aRetVals[ This.nReturnIndex]
  ENDIF

  RETURN


  *====================================
  *-- cFrmMsgSvc::Release
  *====================================
  * Release this form
  FUNCTION Release
  This.Visible = .F.
  RELEASE This

  RETURN
ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c F r m T h e r m M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cFrmThermMsgSvc AS cfrmMsgSvc
  Height= 100
  Width = 300
  WindowType= 0  && Modeless

  *-- Custom properties
  TYPE= "Therm"
  cFirstLine= ""

  *====================================
  *-- cFrmThermMsgSvc::GetPercent( n)
  *====================================
  *
  FUNCTION GetPercent( tnPassed)
  IF TYPE( "This.oTherm") = "O" AND ;
      !ISNULL( This.oTherm)

    RETURN This.oTherm.GetPercent( )
  ELSE
    RETURN 0
  ENDIF


  *====================================
  *-- cFrmThermMsgSvc::SetPercent( n)
  *====================================
  *
  FUNCTION SetPercent( tnPassed)
  IF TYPE( "This.oTherm") = "O" AND ;
      !ISNULL( This.oTherm)

    DODEFAULT()

    This.oTherm.SetPercent( tnPassed)
    IF TYPE( "This.oButtons")= "O"
      *-- Thanks to Mike O'Donnell for his suggestion on SetFocus wrt thermometer dialogs
      IF TYPE( "This.oButtons")= "O" AND This.Visible
        This.oButtons.Controls(1).SetFocus()
      ENDIF
    ENDIF
  ENDIF

  RETURN

  *====================================
  *-- cFrmThermMsgSvc::SetText( c)
  *====================================
  *
  FUNCTION SetText( tcPassed)
  IF ISNULL( tcPassed)
    RETURN .NULL.
  ENDIF
  IF TYPE( "tcPassed") <> "C"
    RETURN .F.
  ENDIF
  LOCAL lcPassed
  lcPassed= ALLTRIM( tcPassed)

  IF This.GetPercent()= 0
    This.cFirstLine= lcPassed
    tcPassed= ccCr_Lf
  ENDIF

  IF ! EMPTY( This.cFirstLine)
    lcPassed= This.cFirstLine+ ;
      ccCr_Lf+ ;
      tcPassed
  ENDIF

  DODEFAULT( lcPassed)

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c F r m W o r k i n g M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cFrmWorkingMsgSvc AS cfrmMsgSvc
  Height    = 100
  Width     = 300
  WindowType= 0  && Modeless
  TYPE      = "Working"
ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c F R M T O D M s g S v c
* Version..: April 3 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cFrmTODMsgSvc AS cfrmMsgSvc
  ScaleMode  = 3
  Height     = 230
  Width      = 427
  DoCreate   = .T.
  AutoCenter = .T.
  BorderStyle= 2
  FontSize   = 8
  KeyPreview= .T.
  MaxButton  = .F.
  MaxWidth   = 430
  MinButton  = .F.
  WindowType = 1
  WindowState= 0

  *-- The active workarea prior to TOD
  noldarea= 1
  Name    = "Tip"
  TYPE    = "Tip Of The Day"

  *-- Did we open TOD?
  ltodopened = .F.

  *-- Do we want random tips
  lRandomTip= .T.

  ADD OBJECT shape1 AS shape WITH ;
    BackColor    = GetSysColor( COLOR_BTNFACE), ;
    Height       = 185, ;
    Left         = 12, ;
    Top          = 12, ;
    Width        = 301, ;
    SpecialEffect= 0, ;
    Name         = "Shape1"

  ADD OBJECT shape2 AS shape WITH ;
    BackColor  = RGB(255, 255, 255), ;
    BorderStyle= 1, ;
    Height     = 171, ;
    Left       = 19, ;
    Top        = 19, ;
    Width      = 287, ;
    Name       = "Shape2"

  ADD OBJECT cmdOk AS cTODButton WITH ;
    Top     = 12, ;
    Left    = 325, ;
    Caption = ccOK, ;
    Name    = "cmdOk"

  ADD OBJECT cmdNextTip AS cTODButton WITH ;
    Top     = 41, ;
    Left    = 325, ;
    Caption = ccNEXTTIP, ;
    Name    = "cmdNextTip"

  ADD OBJECT cmdMoreTips AS cTODButton WITH ;
    Top     = 80, ;
    Left    = 325, ;
    Caption = ccMORETIPS, ;
    Name    = "cmdMoreTips"

  ADD OBJECT cmdHelp AS cTODButton WITH ;
    Top     = 109, ;
    Left    = 325, ;
    Caption = ccHELP, ;
    Name    = "cmdHelp"

  ADD OBJECT check1 AS checkbox WITH ;
    Top      = 203, ;
    Left     = 12, ;
    Height   = 18, ;
    Width    = 300, ;
    FontName = lcSystemFont, ;
    FontSize = 8, ;
    FontBold = .F., ;
    BackColor  = GetSysColor( COLOR_BTNFACE), ;
    Caption  = ccSHOWTIPS, ;
    Name     = "Check1"

  ADD OBJECT edit1 AS editbox WITH ;
    BackColor    = RGB(255, 255, 255), ;
    BackStyle    = 0, ;
    BorderStyle  = 0, ;
    FontName     = lcSystemFont, ;
    FontSize     = 8, ;
    FontBold     = .F., ;
    Height       = 122, ;
    Left         = 25, ;
    Top          = 66, ;
    Width        = 275, ;
    SpecialEffect= 1, ;
    ReadOnly     = .T., ;
    ScrollBars   = 0, ;
    TabStop      = .F., ;
    Name         = "Edit1"

  ADD OBJECT label1 AS clblMsgSvc WITH ;
    FontName= lcSystemFont, ;
    FontSize= 8, ;
    FontBold= .T., ;
    Caption = ccDIDYOUKNOW, ;
    Height  = 18, ;
    Left    = 65, ;
    Top     = 38, ;
    Width   = 200, ;
    Name    = "Label1", ;
    ForeColor= GetSysColor(COLOR_INFOTEXT)

  ADD OBJECT image1 AS image WITH ;
    Picture= "tod.bmp", ;
    Height = 40, ;
    Left   = 24, ;
    Top    = 24, ;
    Width  = 39, ;
    Name   = "Image1"

  *====================================
  *-- cFrmTODMsgSvc::Load
  *====================================
  PROCEDURE Load
  DODEFAULT()
  This.noldarea=SELECT()
  SELECT *, " " AS Temp FROM (This.cTable) ;
    INTO CURSOR __Tod ;
    WHERE UPPER(ALLTRIM(cKey)) == "TIP"

  This.lTODOpened= .T.

  RETURN
  *====================================
  *-- cFrmTODMsgSvc::Init
  *====================================
  FUNCTION Init
  DODEFAULT()
  This.Caption    = MsgEvlTXT(ccTOD)
  This.BackColor  = GetSysColor( COLOR_BTNFACE)
  This.edit1.BackStyle=1
  IF This.lRandomTip
    LOCAL lnRecords
    =RAND(-1)
    lnRecords=RAND()* RECCOUNT("__Tod")

    Skip INT(lnRecords) IN __Tod
    IF EOF()
      GO BOTTOM
    ENDIF
  ENDIF
    This.edit1.Controlsource= "__TOD.cOriginal"

  This.edit1.BackStyle=0

  RETURN

  *====================================
  *-- cFrmTODMsgSvc::Destroy
  *====================================
  PROCEDURE Destroy
  SELECT (This.noldarea)
  IF This.ltodopened
    USE IN __Tod
  ENDIF

  RETURN

  *====================================
  *-- cFrmTODMsgSvc::KeyPress
  *====================================
  PROCEDURE KeyPress( nKeyCode, nShiftAltCtrl)
  *-- Respond intelligently on escape
  IF nKeyCode= 27
    This.Release()
  ENDIF

  RETURN


  *====================================
  *-- cFrmTODMsgSvc::cmdOk.Click
  *====================================
  PROCEDURE cmdOk.Click
  RELEASE Thisform

  RETURN

  *====================================
  *-- cFrmTODMsgSvc::cmdNextTip.Click
  *====================================
  PROCEDURE cmdNextTip.Click
  LOCAL lnOldArea
  lnOldArea= SELECT()
  SELECT __Tod
  Skip
  IF EOF()
    LOCATE
  ENDIF
  SELECT (lnOldArea)
  Thisform.REFRESH

  RETURN

  *====================================
  *-- cFrmTODMsgSvc::cmdMoreTips.Click
  *====================================
  PROCEDURE cmdMoreTips.Click
  MsgSvc("Subclass to suit")

  RETURN


  *====================================
  *-- cFrmTODMsgSvc::check1.Interactivechange( n)
  *====================================
  PROCEDURE check1.Interactivechange( tnIndex)
  MsgSvc("Subclass to suit")

  RETURN

  *====================================
  *-- cFrmTODMsgSvc::cmdHelp.Click
  *====================================
  PROCEDURE cmdHelp.Click
  HELP

  RETURN
ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c T O D B u t t o n
*          : Tip of the day button
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cTODButton AS CommandButton
  Height  = 24
  Width   = 90
  FontName= lcSystemFont
  FontSize= 8
  FontBold= .F.
  Name    = "TipOfTheDayButton"

  FUNCTION Init
  This.ForeColor= GetSysColor(COLOR_BTNTEXT)

  RETURN
ENDDEFINE

*
*-- EndDefine: tod
**************************************************

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c P a c k a g e
*          : This class serves as a holder (package) of other objects so
*          : that several object references can be passed as one object.
*
* Pattern  : COMPOSITE
*
* Version..: April 6 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cPackage AS Relation  && A lightweight.
  DIMENSION aItems[1,2]
  ItemCount= 0
  cClassId= "Package"

  *====================================
  *-- cPackage::Init
  *====================================
  *
  *
  FUNCTION Init
  This.aItems[1]= .NULL.
  This.aItems[2]= .NULL.

  RETURN

  *====================================
  *-- cPackage::GetItem(c)
  *====================================
  * Return the first item of a given type.
  *
  FUNCTION GetItem( tcType)
  IF ISNULL( tcType)
    RETURN .NULL.
  ENDIF

  LOCAL lcRetVal, lcType, lnHit

  lcRetVal= ''
  IF TYPE( "tcType") <> "C"
    RETURN lcRetVal
  ENDIF

  lcType= PROPER( ALLTRIM( tcType))
  lnHit= ASCAN( This.aItems, lcType)
  IF lnHit> 0
    RETURN This.aItems[ lnHit+1]
  ELSE
    RETURN lcRetVal
  ENDIF

  RETURN

  *====================================
  *-- cPackage::AddItem(cx)
  *====================================
  * Add an item to this package
  *
  FUNCTION AddItem( tcType, txItem )
  LOCAL llRetVAal

  IF ISNULL( tcType) OR ISNULL( txItem)
    RETURN .NULL.
  ENDIF

  llRetVal= .F.

  IF EMPTY( tcType) OR ;
      TYPE( "tcType") <> "C"

    RETURN llRetVal
  ENDIF

  LOCAL lnFound, lntemp
  lnFound=ASCAN( This.aItems, tcType)
  IF lnFound > 0
    This.aItems( lnFound+1)= txItem
  ELSE
    IF ISNULL( This.aItems[ 1])
      lntemp= 0
    ELSE
      lntemp= ALEN( This.aItems)
      DIMENSION This.aItems[ lnTemp+ 2]
    ENDIF
    This.aItems[ lnTemp+ 1]= PROPER( tcType)
    This.aItems[ lnTemp+ 2]= txItem
  ENDIF
  llRetVal= .T.
  This.ItemCount= IIF(ISNULL( This.aItems[1]), 0 , ALEN( This.aItems,1))
  RETURN llRetVal

  *====================================
  *-- cPackage::Release()
  *====================================
  * Clean up this item and release
  *
  FUNCTION Release
  LOCAL lnI
  FOR lnI= 1 TO ALEN(This.aItems,1)
    IF TYPE("This.aItems[lni, 2].cClassId") <> "U" AND This.aItems[lni, 2].cClassId= This.cClassId
      This.aItems[lni, 2].Release()
    ENDIF
    This.aItems[lni, 1]= .NULL.
    This.aItems[lni, 2]= .NULL.
  ENDFOR

  RELEASE This
  RETURN

ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c C m d M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cCmdMsgSvc AS CommandButton
  Height= 23
  FontName= lcSystemFont
  FontSize= 8
  FontBold= .F.
  DIMENSION aRetVals[4]

  *====================================
  *-- cCmdMsgSvc::Init(o)
  *====================================
  *
  FUNCTION Init( toSpecPackage)
  LOCAL loMessageSpec, lcWinFont

  This.aRetVals[1]= ''   && Original language caption
  This.aRetVals[2]= 0    && Button number
  This.aRetVals[3]= .F.  && First button
  This.aRetVals[4]= 0    && MESSAGEBOX()-Compatible
  This.ForeColor= GetSysColor(COLOR_BTNTEXT)
  *[eg] 12/09/1998 05:48:34 PM get button font
  loMessageSpec = toSpecPackage.GetItem("Message Spec")
  IF !EMPTY(loMessageSpec.cWinFont)
    *-- Get button font from cWinFont
    lcWinFont      = tokennum(loMessageSpec.cWinFont,2,ccParseDelim)
    This.FontName  = tokennum(lcWinFont,1,[,])
    This.FontSize  = IIF (!EMPTY(tokennum(lcWinFont,2,[,])),VAL(tokennum(lcWinFont,2,[,])),8)
    This.FontBold  = IIF(UPPER(tokennum(lcWinFont,3,[,]))="B",.T.,.F.)
  ENDIF
  RETURN
  *====================================
  *-- cCmdMsgSvc::
  *====================================
  * Pass the return values up the tree
  FUNCTION Click
  Thisform.aRetVals[1]= This.aRetVals[1]  && Original language caption
  Thisform.aRetVals[2]= This.aRetVals[2]  && Button number
  Thisform.aRetVals[3]= This.aRetVals[3]  && First button
  Thisform.aRetVals[4]= This.aRetVals[4]  && MESSAGEBOX()-Compatible

  Thisform.Release()

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c C m d I n i t i a l F o c u s
* Version..: March 2 2003
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cCmdInitialFocus AS CommandButton
  nSetFocus= 0
  Top= 2000

  FUNCTION GotFocus()
    IF This.nSetFocus= 0
      This.nSetFocus= 1
      DODEFAULT()
    ELSE
      NODEFAULT
    ENDIF
  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c T m r M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cTmrMsgSvc AS Timer
  *====================================
  *-- cTmrMsgSvc::Init
  *====================================
  *
  FUNCTION Init( toSpecPackage)
  LOCAL loMessageSpec
  loMessageSpec= toSpecPackage.GetItem( "Message spec")
  IF VAL( loMessageSpec.cTimeout) > 0
    This.Interval= VAL( loMessageSpec.cTimeout)*1000
  ENDIF

  FUNCTION Timer
  Thisform.Release()

  RETURN

ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c A b s t r a c t M s g C o n t a i n e r
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cAbstractMsgContainer AS Container
  FUNCTION Init( o)
  FUNCTION SetPercent(n)
  FUNCTION GetPercent(n)
ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c L i n T h e r m
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cLinTherm AS Line
  BorderWidth = 2

  FUNCTION INIT
  This.BorderColor = RGB(255,255,255)

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c C t r T h e r m B a r
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cCtrThermBar AS cAbstractMsgContainer
  BackStyle    = 1     && 1= Opaque
  BorderWidth  = 0
  SpecialEffect= 1     && 1= Sunken

  FUNCTION INIT
  DoDefault()
  This.BackColor  = GetSysColor(COLOR_ACTIVECAPTION )

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c C t r T h e r m
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cCtrTherm AS cAbstractMsgContainer
  BackStyle    = 1     && 1= Opaque
  BorderWidth  = 1
  Height= 20
  SpecialEffect= 1     && 1= Sunken
  Width= 285

  nBorder= 3
  nPercent= 0
  *====================================
  *-- cCtrTherm::Init(o)
  *====================================
  * Build the thermometer bar illusion
  FUNCTION INIT( toSpecPackage)
  This.BackColor  = RGB(255,255,255)

  This.AddObject( "oLabel", "cThermBarLblMsgSvc")
  WITH This.oLabel
    .Top  = (This.Height/2)- (.Height/2) +1
    .Left = (This.Width/2)- (TXTWIDTH(.Caption, .FontName, .FontSize)/2)
    .Visible= .T.
  ENDWITH

  This.AddObject( "oTherm", "cCtrThermBar")

  WITH This.oTherm
    .Top= This.nBorder
    .Left=This.nBorder
    .Height= This.Height-(2*This.nBorder)
    .Visible      = .T.
    .AddObject( "oLabel", "cThermBarLblMsgSvc")
    WITH .oLabel
      .Top  = This.Height/2- .Height/2- This.nBorder
      .ForeColor= RGB(255, 255, 255)
      .Visible= .F.
    ENDWITH
  ENDWITH

  *-- Lay down therm bar separators
  LOCAL lnI, lcI
  This.oLabel.Visible= .F.
  FOR lnI= 1 TO 19
    lcI=ALLTRIM(STR( lnI,2))
    This.AddObject("oSep"+lcI, "cLinTherm")
    WITH This.oSep&lcI.
      .Visible=.T.
      .Left= lnI*This.Width/20
      .Height= This.Height- 5
      .Width= 0
      .Top= 3
    ENDWITH
  ENDFOR

  IF This.SpecialEffect= 1  && Sunken
    This.AddObject("H3D", "Line")
    WITH This.H3D
      .BorderColor=RGB(255, 255, 255)
      .BorderWidth=1
      .Top=This.Height-1
      .Left=1
      .Width=This.Width-2
      .Height=0
      .Visible= .T.
    ENDWITH
    This.AddObject("V3D", "Line")
    WITH This.V3D
      .BorderColor=RGB(255, 255, 255)
      .BorderWidth=1
      .Top= 1
      .Left= This.Width-1
      .Width=0
      .Height=This.height-1
      .Visible= .T.
    ENDWITH
  ENDIF

  This.RefreshTherm()

  RETURN

  *====================================
  *-- cCtrTherm::GetPercent(n)
  *====================================
  FUNCTION GetPercent( tnPercent)
  RETURN This.nPercent

  *====================================
  *-- cCtrTherm::SetPercent(n)
  *====================================
  FUNCTION SetPercent( tnPercent)
  DO CASE
  CASE TYPE( "tnPercent") <> "N"
  CASE tnPercent >= 100
    Thisform.Release()
  CASE tnPercent < 0
    This.nPercent = 0
  OTHERWISE
    This.nPercent= tnPercent
  ENDCASE
  This.RefreshTherm()

  RETURN

  *====================================
  *-- cCtrTherm::RefreshTherm()
  *====================================
  FUNCTION RefreshTherm
  This.oLabel.Caption=ALLTRIM(STR(INT(This.nPercent),3))+ " %"
  WITH This.oTherm
    .Width= MAX(0, MIN(This.nPercent,100))/100 * (This.Width - (2*This.nBorder))
    WITH .oLabel
      .Caption=ALLTRIM(STR(This.nPercent,3,0))+ " %"
      .Left = This.Width/2- TXTWIDTH(.Caption, ;
        .FontName, ;
        .FontSize)/2 ;
        - This.nBorder-1

      .ForeColor= RGB(255, 255, 255)
      .Visible= .F.
    ENDWITH
  ENDWITH

  RETURN

ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c C t r C o m m a n d B u t t o n
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cCtrCommandButton AS cAbstractMsgContainer
  BackStyle= 0
  BorderWidth= 0
  Spacing= 6
  ButtonClass= "cCmdMsgSvc"

  DIMENSION aTrans[5]
  DIMENSION aOriginal[5]

  *====================================
  *-- cCtrCommandButton::Init(oo)
  *====================================
  FUNCTION Init( toSpecPackage)

  *-- Analyse toSpecPackage
  This.ButtonSpec( toSpecPackage)
  *-- localize the captions
  *-- Create Buttons
  This.AddButtons( Thisform, toSpecPackage)

  RETURN

  *====================================
  *-- cCtrCommandButton::ButtonSpec(o)
  *====================================
  FUNCTION ButtonSpec( toSpecPackage)
  LOCAL lcFunction, lcUppFunction, loMessageSpec
  loMessageSpec=toSpecPackage.GetItem( "Message spec")

  lcFunction= loMessageSpec.cfunction

  IF EMPTY( lcFunction)
    lcFunction= ccOK
  ENDIF

  *-- If "NOBUTTON" option selected, create out-of-scope <OK> button to allow <ESC> processing
  IF !(loBuilder.lButtons)
    lcFunction= ccOK
  ENDIF

  lcUppFunc = UPPER( ALLTRIM(lcFunction))

  DO CASE
  CASE lcUppFunc== [OK]
    DIMENSION This.aOriginal[1], This.aTrans[1]
    This.aOriginal[1]= ccOK
    *** Drew Speedie mdification 8/17/98, as per suggestion
    *** from VMP developer Gene Pasquini -- allow
    *** termination of an <OK> dialog via {ESCAPE}
    This.aTrans[1]   =  [\?\!\<OK]
    *** end modification

  CASE lcUppFunc== [OC]
    DIMENSION This.aOriginal[2], This.aTrans[2]
    This.aOriginal[1]= ccOK
    This.aOriginal[2]= ccCANCEL
    This.aTrans[1]   =  [\!\<] + ccOK 
    This.aTrans[2]   =  [\?\<] + ccCANCEL 

  CASE lcUppFunc== [YN]
    DIMENSION This.aOriginal[2], This.aTrans[2]
    This.aOriginal[1]= ccYES
    This.aOriginal[2]= ccNO
    This.aTrans[1]   =  [\!\<] + ccYES
    This.aTrans[2]   =  [\<] + ccNO

  CASE lcUppFunc== [NY]
    DIMENSION This.aOriginal[2], This.aTrans[2]
    This.aOriginal[1]= ccNO
    This.aOriginal[2]= ccYES
    This.aTrans[1]   =  [\<] + ccNO
    This.aTrans[2]   =  [\?\<] + ccYES

  CASE lcUppFunc== [YNC]
    DIMENSION This.aOriginal[3], This.aTrans[3]
    This.aOriginal[1]= ccYES
    This.aOriginal[2]= ccNO
    This.aOriginal[3]= ccCANCEL
    This.aTrans[1]   =  [\!\<]+ ccYES
    This.aTrans[2]   =  [\<]+ ccNO
    This.aTrans[3]   =  [\?\<]+ ccCANCEL

  CASE lcUppFunc== [NYC]
    DIMENSION This.aOriginal[3], This.aTrans[3]
    This.aOriginal[1]= ccNO
    This.aOriginal[2]= ccYES
    This.aOriginal[3]= ccCANCEL
    This.aTrans[1]   =  [\!\<] + ccNO
    This.aTrans[2]   =  [\<]+ ccYES
    This.aTrans[3]   =  [\?\<]+ ccCANCEL

  CASE lcUppFunc== [RC]
    DIMENSION This.aOriginal[2], This.aTrans[2]
    This.aOriginal[1]= ccRETRY
    This.aOriginal[2]= ccCANCEL
    This.aTrans[1]   =  [\!\<]+ ccRETRY
    This.aTrans[2]   =  [\?\<]+ ccCANCEL

  CASE lcUppFunc== [ARI]
    DIMENSION This.aOriginal[3], This.aTrans[3]
    This.aOriginal[1]= ccABORT
    This.aOriginal[2]= ccRETRY
    This.aOriginal[3]= ccIGNORE
    This.aTrans[1]   =  [\!\<] + ccABORT
    This.aTrans[2]   =  [\<]+ ccRETRY
    This.aTrans[3]   =  [\<] + ccIGNORE

  CASE lcUppFunc== [CANCEL]
    DIMENSION This.aOriginal[1], This.aTrans[1]
    This.aOriginal[1]= ccCANCEL
    This.aTrans[1]   =  [\?\<]+ ccCANCEL

  CASE lcUppFunc== [WORKING]
    llWorking= .T.

  OTHERWISE
    lcHoldVar = ''
    lnNumButtons = tokens( lcFunction, [;], .T.)
    DIMENSION This.aOriginal[lnNumButtons], This.aTrans[lnNumButtons]
    LOCAL lcThisWord
    FOR lnI = 1 TO lnNumButtons
      lcThisWord      = tokennum( lcFunction, lnI, [;], .T.)
      This.aOriginal[lnI] = lcThisWord
      This.aTrans[lnI] =  lcThisWord
      lcHoldVar       = lcHoldVar + This.aTrans[lnI] + [;]
    ENDFOR
    *-- Eliminate trailing ";"
    lcFunction = LEFT( lcHoldVar, LEN( lcHoldVar) - 1 )
  ENDCASE

  RETURN

  *====================================
  *-- cCtrCommandButton::AddButtons(oo)
  *   Add buttons to the button container
  *====================================
  FUNCTION AddButtons( toDialog, toSpecPackage)
  LOCAL lnI, lcI, loTemp, laTemp, lcMsgBox
  lcMsgBox= SPACE(9)+          ;
    PADR( ccOK,    10)+ ;
    PADR( ccCANCEL,10)+ ;
    PADR( ccABORT, 10)+ ;
    PADR( ccRETRY, 10)+ ;
    PADR( ccIGNORE,10)+ ;
    PADR( ccYES,   10)+ ;
    PADR( ccNO,    10)

  FOR lnI= 1 TO ALEN( This.aTrans)
    IF TYPE("This.aTrans[ lnI]")= "L"
      EXIT
    ENDIF
    lcName= "cmd"+STR( lnI,1)
    *[eg] 12/10/1998 11:54:34 AM add third parameter
    This.AddObject( lcName, This.ButtonClass, toSpecPackage)
    loTemp= This.&lcName.

    *-- Thanks to Gene Pasquini for this one -- makes
    *-- buttons look less whimpy.
    * loTemp.Caption= NoOldHot(This.aTrans[ lnI])
    IF lenc(This.aTrans[lnI]) < 11
      loTemp.Caption = NoOldHot(padc(This.aTrans[lnI],11))
    ELSE
      loTemp.Caption = NoOldHot(This.aTrans[lnI])  &&& original code
    ENDIF

    *-- Add button characteristics
    loTemp.aRetVals[1]= NOHOT(This.aOriginal[ lnI]) && Original language caption
    loTemp.aRetVals[2]= lnI                  && Button number
    loTemp.aRetVals[3]= (lnI=1)              && First button?
    loTemp.aRetVals[4]= INT(AT(loTemp.aRetVals[1], lcMsgBox)/10) && MessageBox() compatibility

    *-- Load ESC & Ctrl-Enter properties here
    IF "\!" $ This.aTrans[lnI]
      loTemp.Default=.T.
    ENDIF

    IF "\?" $ This.aTrans[lnI]
      loTemp.Cancel=.T.
    ENDIF
  ENDFOR

  *-- Lay them out
  LOCAL lnSpacing, lnHeight, lnMaxPromptWidth, lnAvgCharWidth
  lnMaxPromptWidth= 0
  lnAvgCharWidth= 0
  IF This.ControlCount > 0
    lnAvgCharWidth= FONTMETRIC(6, ;
      This.Controls(1).FontName, ;
      This.Controls(1).FontSize)

    *-- WIN95 guidelines
    lnSpacing= lnAvgCharWidth
    lnHeight=  FONTMETRIC(1, ;
      This.Controls(1).FontName, ;
      This.Controls(1).FontSize) * 7/4
  ENDIF

  FOR lnI=1 TO This.ControlCount
    lnMaxPromptWidth= MAX( lnMaxPromptWidth, lnAvgCharWidth* ;
      TXTWIDTH( NOHOT(This.Controls(lnI).Caption), ;
      This.Controls(lnI).FontName, ;
      This.Controls(lnI).FontSize))
  ENDFOR
  *-- Small adjustment suggested by Steve Dingle:
  *-- The "OK" button, when alone, is kinda small to be a
  *-- decent target.  I agree.
  IF This.ControlCount= 1
    lnMaxPromptWidth= MAX( lnMaxPromptWidth, lnAvgCharWidth* ;
      TXTWIDTH( NOHOT("Cancel"), ;
      This.Controls(1).FontName, ;
      This.Controls(1).FontSize))
  ENDIF

  *-- Adjust the button sizes
  LOCAL lnButtonWidth
  * lnButtonWidth= lnMaxPromptWidth* (2.2)
  lnButtonWidth= lnMaxPromptWidth* (1.4)

  FOR lnI=1 TO This.ControlCount
    This.Controls(lnI).Width= lnButtonWidth
    This.Controls(lnI).Height= toDialog.nVDBU*14
    This.Controls(lnI).Left  = (toDialog.nHDBU*4)+ ;
      ((lnI-1)* (lnButtonWidth+ (toDialog.nHDBU*4)))
    This.Controls(lnI).Top= 0
    This.Controls(lnI).Visible= .T.
  ENDFOR
  IF This.ControlCount> 0
    This.Height= This.Controls(1).Height
    This.Width = 2*(toDialog.nHDBU*4)+ ;
      (This.ControlCount* lnButtonWidth)+ ;
      ((This.ControlCount-1)*(toDialog.nHDBU*4))
  ELSE
    This.Parent.RemoveObject( This.Name)
  ENDIF

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c E d t M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cEdtMsgSvc AS EditBox
  Alignment  = 0
  BackStyle  = 0 && Transparent
  BorderStyle= 0 && none
  FontName   = lcSystemFont
  FontSize   = 8
  FontBold   = .F.
  ReadOnly   = .T.
  ScrollBars = 0 && none
  TabStop    = .F.
  Margin     = 0
  Width      = 200

  *====================================
  *-- cEdtMsgSvc::Init()
  *====================================
  *
  FUNCTION INIT( toSpecPackage)
  *[eg] 12/09/1998 05:48:59 PM get text font
  LOCAL loMessageSpec, lcWinFont
  loMessageSpec = toSpecPackage.GetItem("Message Spec")
  IF !EMPTY(loMessageSpec.cWinFont)
    *-- Get text font from cWinFont
    lcWinFont = tokennum(loMessageSpec.cWinFont,1,ccParseDelim)
    This.FontName  = tokennum(lcWinFont,1,[,])
    This.FontSize  = IIF (!EMPTY(tokennum(lcWinFont,2,[,])),VAL(tokennum(lcWinFont,2,[,])),8)
    This.FontBold  = IIF(UPPER(tokennum(lcWinFont,3,[,]))="B",.T.,.F.)
  ENDIF
  *====================================
  *-- cEdtMsgSvc::When()
  *====================================
  * No focus here please
  *
  FUNCTION When
  RETURN .F.

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c T m r A n i m a t e M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cTmrAnimateMsgSvc AS cTmrMsgSvc
  *====================================
  *-- cTmrMsgSvc::Init
  *====================================
  *
  Interval = 400
  nCounter = 0
  nMaxImage= 1
  Enabled  = .F.

  DIMENSION aImages[1]

  *====================================
  *-- cTmrMsgSvc::Animate()
  *====================================
  FUNCTION Timer
  This.nCounter= This.nCounter+1
  IF This.nCounter > This.nMaxImage
    This.nCounter= 1
  ENDIF
  Thisform.oImage.Picture= This.aImages[ This.nCounter]

  RETURN

  *====================================
  *-- cTmrMsgSvc::SetImage()
  *====================================
  FUNCTION SetImage( toImage, tnImages)
  * Limited to 10 images.
  This.nMaxImage= tnImages
  DIMENSION This.aImages[ tnImages]
  LOCAL lnI, lcPre, lcPost, lntemp, lcVarChar
  lntemp= AT( ".", toImage.Picture)

  lcPre= LEFT( toImage.Picture, lntemp -1)
  lcVarChar= RIGHT( lcPre,1)
  lcPre= LEFT( lcPre, LEN( lcPre)-1)

  lcPost= SUBS( toImage.Picture, lntemp)

  FOR lnI= 1 TO tnImages
    This.aImages[lnI]= lcPre+ CHR( ASC( lcVarChar)+lnI-1)+lcPost
  ENDFOR

  RETURN

ENDDEFINE


*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c I m g M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cImgMsgSvc AS Image
  Top   = 12
  Left  = 12
  Width = 32
  Height= 32
  BackStyle= 0  && Transparent

  cPictureProp= "cGuiVisual"
  lAnimate= .F.
  nAnimate= 1

  *====================================
  *-- cImgMsgSvc::Init(o)
  *====================================
  *
  FUNCTION INIT( toSpecPackage)
  LOCAL loMessageSpec
  loMessageSpec= toSpecPackage.GetItem("Message spec")

  LOCAL lcImageFile
  lcImageFile= EVAL("loMessageSpec."+ This.cPictureProp)
  IF EMPTY( lcImageFile)
    RETURN .F.
  ENDIF

  lcImageFile=UPPER( lcImageFile)
  IF "ANIMATE" $ lcImageFile
    LOCAL lnAnimatePos, lcAnimateSpec, lnAnimate
    lnAnimatePos= AT( "ANIMATE", lcImageFile)
    lcAnimateSpec= SUBS( lcImageFile, lnAnimatePos)
    lcImageFile= ALLTRIM( LEFT( lcImageFile, lnAnimatePos-1))
    lcAnimateSpec= ALLTRIM(STRTRAN( lcAnimateSpec, "ANIMATE"))
    lnAnimate= VAL( lcAnimateSpec)
    IF lnAnimate> 0
      This.lAnimate= .T.
      This.nAnimate= lnAnimate
    ENDIF
  ENDIF

  *-- There could be nothing left...
  IF EMPTY( lcImageFile)
    RETURN .F.
  ENDIF


  IF FILE( ALLTRIM( lcImageFile))
    This.Picture= lcImageFile
  ELSE
    RETURN .F.
  ENDIF

  IF This.lAnimate
    Thisform.AddObject("oImageTimer", "cTmrAnimateMsgSvc", toSpecPackage)
    Thisform.oImageTimer.SetImage( This, This.nAnimate)
    Thisform.oImageTimer.Enabled= .T.
  ENDIF

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c L b l M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS clblMsgSvc AS Label
  FontName= lcSystemFont
  FontSize= 8
  FontBold= .F.
  BackStyle= 0  && Transparent

  FUNCTION INIT
  This.ForeColor= GetSysColor(COLOR_INFOTEXT)

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
* CLASS....: c T h e r m B a r L b l M s g S v c
* Version..: March 31 1996
*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS cThermBarLblMsgSvc AS Label
  FontBold= .F.
  BackStyle= 0  && transparent
  BorderStyle= 0

  FUNCTION Init
  This.ForeColor= GetSysColor(COLOR_INFOTEXT)

  RETURN

ENDDEFINE

*//////////////////////////////////////////////////////////////////////////////
DEFINE CLASS LightweightCustom AS custom
*//////////////////////////////////////////////////////////////////////////////
PROTECTED addobject
  PROTECTED addproperty
  PROTECTED cloneobject
  PROTECTED comment
  PROTECTED controlcount
  PROTECTED controls
  PROTECTED destroy
  PROTECTED error
  PROTECTED height
  PROTECTED helpcontextid
  PROTECTED init
  PROTECTED newobject
  PROTECTED objects
  PROTECTED parent
  PROTECTED parentclass
  PROTECTED picture
  PROTECTED readexpression
  PROTECTED readmethod
  PROTECTED removeobject
  PROTECTED resettodefault
  PROTECTED saveasclass
  PROTECTED showwhatsthis
  PROTECTED tag
  PROTECTED whatsthishelpid
  PROTECTED width
  PROTECTED writeexpression
  PROTECTED writemethod
ENDDEFINE


*!***********************************************
*!
*!      Procedure: WAITWIND
*!
*!***********************************************
PROCEDURE waitwind
*  Program...........: WAITWIND.PRG
*  Version...........: 1.1 Dec 27 1994
*  Author............: Steven M. Black
*} Project...........: common
*  Created...........: 11/22/91
*  Copyright.........: None (Public Domain)
*) Description.......: A Wait window shell -- From Lisa Slater Nichols'
*)                     compuserve suggestion
*] Dependencies......:
*  Calling Samples...:
*  Parameter List....: tcPhrase   - What goes in the WAIT window
*                      tnSchemeNo - Color of the WAIT window
*                      txWaiting  - Numeric = TIMEOUT
*                                   .T.     = WAIT, .F. = NoWait

PARAMETERS ;
  tcPhrase, ;
  tnSchemeno, ;
  txwaiting
*-- you only need to pass the first one...

PRIVATE ;
  lcAnswerVal, ;
  lcWaitType, ;
  llWaiting, ;
  lnWaiting

lnWaiting  = 0
llWaiting  = .F.
lcWaitType = TYPE( "txWaiting")

DO CASE
CASE lcWaitType = "N"
  lnWaiting = txwaiting
CASE lcWaitType = "L"
  llWaiting = txwaiting
ENDCASE

IF EMPTY( tnSchemeno)
  tnSchemeno = 5
ENDIF

lcAnswerVal = ''
IF PARAMETERS() > 1
  SET COLOR OF SCHEME 5 TO SCHEME tnSchemeno
ENDIF

DO CASE
CASE llWaiting                                        && defaults to .F. if nothing was passed...
  WAIT WINDOW tcPhrase TO lcAnswerVal
CASE lnWaiting > 0
  WAIT WINDOW tcPhrase TO lcAnswerVal TIME lnWaiting
OTHERWISE
  WAIT WINDOW tcPhrase NOWAIT
ENDCASE

SET COLOR OF SCHEME 5 TO

RETURN lcAnswerVal


*!***********************************************
*!
*!      Procedure: OK2INSERT
*!
*!***********************************************
PROCEDURE ok2insert
*  Author............: Steven M. Black
*  Version...........: 1.3 March 11 1995
*} Project...........: INTL
*  Created...........: 10/26/93
*  Copyright.........: None (Public Domain)
*) Description.......: PROCEDURE ok2insert
*)                     Sort of kills the point of the INSERT,
*)                     so tell me a better way...

PARAMETER tcNewAlias

PRIVATE llRetVal, lcOldError, lnOldAlias
lnOldAlias=0
llRetVal = .T.

lcOldError        = ON( "ERROR")
ON ERROR llRetVal = .F.

IF ! EMPTY( tcNewAlias)
  lnOldAlias = SELECT()
  SELECT (tcNewAlias)
ENDIF

IF EOF() OR BOF()
  LOCATE
ENDIF

*-- do something that might trigger an error
lcField = FIELD( 1)
REPLACE &lcField WITH &lcField

ON ERROR &lcOldError

IF ! EMPTY( lnOldAlias)
  SELECT ( lnOldAlias)
ENDIF

RETURN llRetVal


*!***********************************************
*!
*!      Procedure: msgevltxt
*!
*!***********************************************
PROCEDURE MsgEvlTXT
*  Author............: Ken Levy
*  Version...........: 1.1 Dec 27 1993
*} Project...........: GENSCRNX
*  Created...........: 09/23/93
*  Copyright.........: None (Public Domain)
*) Description.......: PROCEDURE msgevltxt
*)                     Evaluated {{}} within strings

PARAMETERS m.old_text
PRIVATE ;
  m.eval_str1, ;
  m.eval_str2, ;
  m.eval_str, ;
  m.new_text, ;
  m.old_text, ;
  m.var_type
PRIVATE ;
  m.at_pos, ;
  m.at_pos2, ;
  m.at_pos3, ;
  m.at_pos4, ;
  m.at_pos5, ;
  m.new_str, ;
  m.old_Str
PRIVATE ;
  m.at_line, ;
  m.cR_lf, ;
  m.evlmode, ;
  m.I, ;
  m.j, ;
  m.mThd_Str, ;
  m.onError, ;
  m.sellast

IF TYPE( [m.old_text])#[C]
  RETURN m.old_text
ENDIF
m.cR_lf   = CHR( 10)+ CHR( 13)
m.onError = ON( [ERROR])
m.new_text= m.old_text
m.at_pos3 = 1
DO WHILE .T.
  m.at_pos= AT( [{{], SUBSTR( m.old_text, m.at_pos3))
  IF m.at_pos= 0
    EXIT
  ENDIF
  m.at_pos2= AT( [}}], SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1))
  IF m.at_pos2= 0
    EXIT
  ENDIF
  m.at_pos4= AT( [{{], SUBSTR( m.old_text, m.at_pos+ m.at_pos3+ 1))
  IF m.at_pos4>0.and.m.at_pos4<m.at_pos2
    m.at_pos4= OCCURS( [{{], SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1, ;
      m.at_pos2-m.at_pos4))
    m.at_pos4 = AT( [{{], SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1), m.at_pos4)
    m.old_Str = SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1, m.at_pos2+ 1)
    m.eval_str= SUBSTR( m.old_Str, 3, LEN( m.old_Str)-2)
    m.old_Str = MsgEvlTXT( m.eval_str)
    m.old_text= STRTRAN( m.old_text, m.eval_str, m.old_Str)
    m.new_text= STRTRAN( m.new_text, m.eval_str, m.old_Str)
    LOOP
  ENDIF
  m.old_Str = SUBSTR( m.old_text, m.at_pos+ m.at_pos3-1, m.at_pos2+ 1)
  m.eval_str= ALLTRIM( SUBSTR( m.old_Str, 3, LEN( m.old_Str)-4))

  m.evlmode = .F.

  DO CASE
  CASE EMPTY( m.eval_str)
    m.eval_str= ''
  CASE LEFT( m.eval_str, 2)== [&.]
    m.eval_str= SUBSTR( m.eval_str, 3)
    &eval_str                                       &&;
      --------------------------------------------------------------;
      ERROR ocCured during MACRO substitution OF {{&. <expc> }}.
    m.eval_str= ''
  CASE LEFT( m.eval_str, 1)== [<]
    *[smb]  m.eval_str= INSERT( SUBSTR( m.eval_str, 2))     &&;
--------------------------------------------------------------;
ERROR ocCured during evaluation OF {{< <FILE> }}.
  OTHERWISE
    m.eval_str= EVALUATE( m.eval_str)               &&;
      --------------------------------------------------------------;
      ERROR ocCured during evaluation OF {{ <expc> }}.
  ENDCASE
  IF EMPTY( m.onError)
    ON ERROR
  ELSE
    ON ERROR &onError
  ENDIF
  m.var_type= TYPE( [m.eval_str])
  DO CASE
  CASE m.var_type== [C]
    m.new_str= m.eval_str
  CASE m.var_type== [N]
    m.new_str= ALLTRIM( STR( m.eval_str, 24, 12))
    DO WHILE RIGHT( m.new_str, 1)== [0]
      m.new_str= LEFT( m.new_str, LEN( m.new_str)-1)
      IF RIGHT( m.new_str, 1)== [.]
        m.new_str= LEFT( m.new_str, LEN( m.new_str)-1)
        EXIT
      ENDIF
    ENDDO
  CASE m.var_type== [D]
    m.new_str= DTOC( m.eval_str)
  CASE m.var_type== [T]
    m.new_str= TTOC( m.eval_str)
  CASE m.var_type== [D]
    m.new_str= TTOC( m.eval_str)
  CASE m.var_type== [L]
    m.new_str= IIF( m.eval_str, [.T.], [.F.])
  OTHERWISE
    m.new_str= m.old_Str
  ENDCASE
  m.new_text= STRTRAN( m.new_text, m.old_Str, m.new_str)
  m.at_pos2 = m.at_pos+ LEN( m.new_str)
  IF m.at_pos2<= 0
    EXIT
  ENDIF
  m.at_pos3= m.at_pos3+ m.at_pos2
ENDDO
m.j= 0
DO WHILE [{{]$m.new_text.and.[}}]$m.new_text
  m.I       = LEN( m.new_text)
  m.new_text= MsgEvlTXT( m.new_text)
  IF m.I= LEN( m.new_text)
    IF m.j>= 2
      EXIT
    ENDIF
    m.j= m.j+ 1
  ENDIF
ENDDO
RETURN m.new_text


*!*********************************************
*!
*!       Procedure: tokennum
*!
*!*********************************************
PROCEDURE tokennum
*  Author............: Steven M. Black
*} Project...........: COMMON
*  Version...........: 1.1  Feb 6 1994
*  Created...........: Sometime in early '92
*  Copyright.........: None (Public Domain)
*) Description.......: PROCEDURE tokennum
*)                     Return a specified of tokens from a string
*] Dependencies......:
*  Calling Samples...: tokennum( <expC>, <expN>[, <expC>])
*  Parameter List....: tcPassedStr
*                      tnTokenNum
*                      tcBreakChar
*                      tlCountDupBreaks
*  Returns...........: The n'th token in a string
*  Major change list.: Support for counting duplicate break characters

PARAMETERS ;
  tcPassedStr, ;
  tnTokenNum, ;
  tcBreakChar, ;
  tlCountDupBreaks

PRIVATE ;
  lcRetVal, ;
  lcString1, ;
  lcX

lcX = CHR(253)

IF PARAMETERS() = 2
  tcBreakChar = " .,"
ENDIF

m.lcString1 = ALLTRIM( m.tcPassedStr)

m.lcString1 = CHRTRAN( m.lcString1, tcBreakChar, REPLICATE(lcX, LEN(tcBreakChar)) )

DO WHILE (! tlCountDupBreaks) AND AT( lcX+ lcX, m.lcString1) > 0
  m.lcString1 = STRTRAN( m.lcString1, lcX+ lcX, lcX)
ENDDO

DO CASE
CASE m.tnTokenNum > 1

  DO CASE
    *-- no token tnTokenNum past end of string.
  CASE AT( lcX, m.lcString1, m.tnTokenNum-1) = 0
    m.lcRetVal = ""

    *-- token tnTokenNum is last token in string.
  CASE AT( lcX, m.lcString1, m.tnTokenNum) = 0
    m.lcRetVal = SUBSTR( m.lcString1, ;
      AT( lcX, m.lcString1, m.tnTokenNum-1)+ 1)

    *-- token tnTokenNum is in the middle.
  OTHERWISE
    lnStartPos = AT( lcX, m.lcString1, m.tnTokenNum-1) +1
    m.lcRetVal = SUBSTR( m.lcString1, ;
      lnStartPos, ;
      AT( lcX, m.lcString1, m.tnTokenNum) - lnStartPos)
  ENDCASE

CASE m.tnTokenNum = 1

  *-- get first token.
  IF AT( lcX, m.lcString1) > 0
    m.lcRetVal = SUBSTR( m.lcString1, 1, AT( lcX, m.lcString1)-1)

    *-- there is only one token.  get it.
  ELSE
    m.lcRetVal = m.lcString1
  ENDIF

ENDCASE

m.lcRetVal = ALLTRIM( m.lcRetVal)

RETURN m.lcRetVal


*!*********************************************
*!
*!       Procedure: tokens
*!
*!*********************************************
PROCEDURE tokens
*  Author............: Steven M. Black
*} Project...........: Common
*  Version...........: 1.1  Feb 6 1994
*  Created...........: Sometime in early '92
*  Copyright.........: None (Public Domain)
*) Description.......: PROCEDURE tokens
*)
*] Dependencies......:
*  Calling Samples...: tokens( <expC>[, <expC>] [, <expL>])
*  Parameter List....: tcPassedString
*                      tcBreakChar
*                      tlCountDupBreaks
*  Returns...........: The number of tokens in a string
*  Major change list.: Support for counting duplicate break characters


PARAMETERS ;
  tcPassedString, ;
  tcBreakChar, ;
  tlCountDupBreaks

PRIVATE ;
  tcBreakChar, ;
  tcPassedString, ;
  lcX

lcX = CHR( 253)

DO CASE
CASE PARAMETERS() = 0
  RETURN ""
CASE PARAMETERS() = 1
  m.tcBreakChar = " .,"
ENDCASE

m.tcPassedString = CHRTRAN( m.tcPassedString, ;
  m.tcBreakChar, ;
  REPLICATE( lcX, LEN( m.tcBreakChar)))

m.tcPassedString = ALLTRIM( m.tcPassedString)

DO WHILE (! tlCountDupBreaks) AND AT( lcX+ lcX, m.tcPassedString) > 0
  m.tcPassedString = STRTRAN( m.tcPassedString, lcX+lcX, lcX)
ENDDO

RETURN ( OCCURS( lcX, m.tcPassedString) + 1)

FUNCTION I
LPARAMETERS Passed
RETURN Passed


*!*********************************************
*!
*!       Procedure: NoHot
*!
*!*********************************************
PROCEDURE NOHOT
*  Author............: Steven M. Black
*} Project...........: common
*  Created...........: 05/09/92
*  Copyright.........: None (Public Domain)
*) Description.......: PROCEDURE NoFeatures
*)                     Feed it a string, and it strips out hotkey assignments
*)                     returning the featureless string
*] Dependencies......:
*  Calling Samples...: nohot(<ExpC>)
*  Parameter List....:

PARAMETERS tcPassedPrompt
*-- This is the fastest, though not the most legible, way
*-- to code This.
*--                                     Hot Key, Ctrl Enter, Escape
RETURN STRTRAN( STRTRAN( STRTRAN( tcPassedPrompt, "\<"), "\!"), "\?")


*!*********************************************
*!
*!       Procedure: NoOldHot
*!
*!*********************************************
PROCEDURE NoOldHot
PARAMETERS tcPassedPrompt
*-- This is the fastest, though not the most legible, way
*-- to code This.
*--
RETURN STRTRAN( STRTRAN( tcPassedPrompt, "\!"), "\?")


*!***********************************************
*!
*!      Procedure: STRIPPAT
*!
*!***********************************************
FUNCTION strippat
PARAMETER tcFileName

PRIVATE ;
  lnColPos, ;
  lnNamelen, ;
  lnSlashPos

m.lnSlashPos = RAT( "\", tcFileName)
IF m.lnSlashPos <> 0
  m.lnNamelen  = LEN( tcFileName) - m.lnSlashPos
  tcFileName   = RIGHT( tcFileName, m.lnNamelen)
ELSE
  m.lnColPos = RAT( ":", tcFileName)
  IF m.lnColPos <> 0
    m.lnNamelen  = LEN( tcFileName) - m.lnColPos
    tcFileName   = RIGHT( tcFileName, m.lnNamelen)
  ENDIF
ENDIF
RETURN tcFileName


*!***********************************************
*!
*!      Procedure: STRIPEXT
*!
*!***********************************************
FUNCTION stripext
PARAMETER m.tcFileName

PRIVATE ;
  lcRetVal, ;
  lnDotPos, ;
  lnTermintr

lcRetVal = m.tcFileName

m.lnDotPos   = RAT( ".", m.tcFileName)
m.lnTermintr = MAX( RAT( "\", m.tcFileName), RAT( ":", m.tcFileName))

IF m.lnDotPos > m.lnTermintr
  m.lcRetVal = LEFT( m.tcFileName, m.lnDotPos-1)
ENDIF

RETURN m.lcRetVal

*!*********************************************
*!
*!       Function: strtranc
*!
*!*********************************************
FUNCTION STRTRANC
*  Author............: Ken Levy
*  Version...........: 2.0
*} Project...........: GENSCRNX
PARAMETERS tcSearched, tcSearchFor , tcReplacement, tnStartOccurrence, tnNumberOfOccurrences
PRIVATE lcRetVal, at_pos, at_pos2, lnOccurence, lnSubstitutionsDone

IF EMPTY( tcSearched).OR.EMPTY( tcSearchFor )
  RETURN tcSearched
ENDIF

lcRetVal= tcSearched
IF TYPE('tnStartOccurrence')# 'N'
  tnStartOccurrence= 1
ENDIF

IF TYPE( 'tnNumberOfOccurrences')#'N'
  tnNumberOfOccurrences= LEN( tcSearched)
ENDIF

IF tnStartOccurrence< 1 OR tnNumberOfOccurrences< 1
  RETURN tcSearched
ENDIF

lnOccurence=0
lnSubstitutionsDone=0
m.at_pos2=1
DO WHILE .T.
  m.at_pos= ATC( tcSearchFor ,SUBSTR( lcRetVal, m.at_pos2))
  IF m.at_pos=0
    EXIT
  ENDIF
  lnOccurence= lnOccurence+ 1
  IF lnOccurence< tnStartOccurrence
    m.at_pos2= m.at_pos+ m.at_pos2+ LEN( tcSearchFor)- 1
    LOOP
  ENDIF

  *[smb] 6/20/97
  lcRetVal=LEFT( lcRetVal, m.at_pos+ m.at_pos2- 2)+ tcReplacement+ ;
    IIF( (m.at_pos+ m.at_pos2+ LEN( tcSearchFor )- 1)> LEN(lcRetVal), ;
    '' , ;
    SUBSTR(lcRetVal, m.at_pos+ m.at_pos2+ LEN( tcSearchFor )- 1))

  lnSubstitutionsDone= lnSubstitutionsDone+ 1
  IF lnSubstitutionsDone>= tnNumberOfOccurrences
    EXIT
  ENDIF
  m.at_pos2= m.at_pos+ m.at_pos2+ LEN( tcReplacement)- 1
  IF m.at_pos2> LEN( lcRetVal)
    EXIT
  ENDIF
ENDDO
RETURN lcRetVal
* END strtranc

*********************************************************
FUNCTION GetSystemFont()
*********************************************************
LOCAL NCM, NCMData, lcFaceName

DECLARE INTEGER SystemParametersInfo IN Win32API ;
  INTEGER, INTEGER, STRING @, INTEGER

NCM = SPACE(340)   && length of NonClientMetrics structure
NCMData = Long2Str(LEN(NCM)) + REPLICATE(CHR(0),336)
= SystemParametersInfo( 41, 340, @NCMData,0)

lcFaceName = SUBSTR( NCMData, 309, 32)
lcFaceName = LEFT( lcFaceName, AT(CHR(0), lcFaceName)-1)
RETURN lcFaceName

*********************************************************
FUNCTION Long2Str
*********************************************************
* Accepts long integer, translates it to low-high format in
* a character string variable.
PARAMETERS m.longval

PRIVATE I, m.retstr
m.retstr = ""
FOR I = 24 TO 0 STEP -8
  m.retstr = CHR(INT(m.longval/(2^I))) + m.retstr
  m.longval = MOD(m.longval, (2^I))
NEXT

RETURN m.retstr

*!*********************************************
*!
*!       Function: juststem
*!
*!*********************************************
* Required for pre-VFP 6.0 versions
FUNCTION JustStem
LPARAMETER M.filname
IF RAT('\', M.filname)>0
  m.filname = SUBSTR(M.filname, RAT('\', M.filname)+1, 255)
ENDIF
IF RAT(':', M.filname)>0
  m.filname = SUBSTR(M.filname, RAT(':', M.filname)+1, 255)
ENDIF
IF AT('.', M.filname)>0
  m.filname = SUBSTR(M.filname, 1, AT('.', M.filname)-1)
ENDIF
RETURN ALLTRIM(UPPER(M.filname))

*********************************************************
FUNCTION X7ISAPIF(tcFunctionName)
*********************************************************
*  RETURN a logical value indicating whether the passed
*  function name is a Windows API function (in a Windows
*  .DLL) that is currently loaded via the DECLARE command
*
*  Copyright.........: None (Public Domain)
*                17501 East 40 Hwy., Suite 218
*                Independence, MO 64055
*                816-350-7900
*                http://www.visionds.com
*                http://www.visualmaxframe.com
*                http://discussion.visualmaxframe.com
*  Author:  Drew Speedie
*
*  Examples:
*  IF NOT X7ISAPIF("MessageBeep")
*    DECLARE Long MessageBeep IN USER32.DLL Long uType
*  ENDIF
*  MessageBeep(0)
*
LOCAL laDLLs[1]
IF ADLLS(laDLLs) = 0
  RETURN .f.
ENDIF
RETURN ASCAN(laDLLs,tcFunctionName,-1,-1,1,15)>0

****************************************************************************
* Brief MSGSVC() History
*
* ==========================================================================
* MSGSVC NEW FOR VFP8                 IMPROVED
* ==========================================================================
* Class cMsgSvc is now a subclass of the Custom base class. This has no effect on functionality.
* Added a Release() method to class cFrmMsgSvc
* Now uses the messagebeep api call.
* Allows {{ }} expressions in cRow and cCol.  Make these fields wider if you need to.
* Enter "0" in cObject field for no initial focus.  So that initially pressing [Enter] does not clear the message.
* Fields cVisual, cMacFont and NewField are deprecated and are deleted from MsgSvc.DBF.
* A class property now determines whether the _SCREEN.oMsgSvc object persists between hits.
* The cFunction field is now case insensitive in all situations.
* A new property, .lUpdateTable, determines if the MsgSvc table is updated with new messages
* A vanilla MSGSVC() call will do a WAIT WINDOW CLEAR.
*
* ==========================================================================
* MSGSVC NEW FOR VFP7                 IMPROVED                     2000-2001
* ==========================================================================
* MsgSvc now uses the user's color preferences as set in Windows
* Miscellaneous fixes and enhancements from suggestions of many users.
*
* ==========================================================================
* MSGSVC NEW FOR VFP6                 IMPROVED                   Dec 21 1998
* ==========================================================================
*  A dialog with a wide titles will now be wide enough to display it.
*  WAIT WINDOWS can now have a NOCLEAR statement by putting NOCLEAR in the cFunction.
*  WAIT WINDOWS can now be positioned by using the CRow and CCol fields
*  MsgSvc dialogs now respect the Windows color scheme and system font.
*  #DEFINEs for Tip of the Day dialog text
*  "Ok" button, when alone, is now bigger to make a better target.
*  MsgSvc now supports embedded variables with {{ }}.
*  Default dialog title is now _SCREEN.Caption
*
*
* ==========================================================================
* MSGSVC NEW FOR FALL 97              IMPROVED                   Oct 11 1997
* ==========================================================================
*  Single Ok button now the same size as the others.
*
* ==========================================================================
* MSGSVC NEW FOR VFP 5.0              IMPROVED                   Aug 15 1997
* ==========================================================================
*  Esc key no longer closes dialogs that don't have cancel buttons
*  Editbox backcolor problem in Tip-Of-The-Day dialog fixed
*  Better handling of %C% embedded cookies
*  Esc key closes the tip of the day dialog
*
* ==========================================================================
* MSGSVC NEW FOR VFP 3.0              IMPROVED                      Apr 6 96
* ==========================================================================
*  Win95 GUI
*  Tip of the day
*  Animated icons
*  Objectified
*  Looks better if icon is missing
*  No Read.
*  WORKING functionality
*  Return type "C" -- It's the default but doesn't work if specified
*  Lowercase %Cx% now being respected in Msgsvc
*  Default dialog is now Grey
*  Flexbox re-engineerd to look more like MESSAGEBOX
*  Default Windows font now ARIAL 10 B for VFP
*  Default Windows font now MS Sans Serif 8 Regular for VFP :)
*  MESSAGEBOX() return value compatibility




