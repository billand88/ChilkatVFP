*==============================================================================
* Purpose:           ChilkatVFP Event Callbacks
* Author:            Bill Anderson
* Notice:            Copyright (c) 2022 - 2025 The Anderson Files LLC, All Rights Reserved.
* Returns:           Logical, indicating success.
* Date Added:        10/07/2022
*==============================================================================

#INCLUDE FoxPro.H

**
** Fixed for Version 29: Fixed the AbortCheck and PercentDone events for the Single-DLL ActiveX. 
** These events did not fire. This was a problem that only affected the Single-DLL ActiveX.
**

**************************************
PROCEDURE ChilkatVFPEventCallbackSetup
**************************************

** Alias not set test
IF NOT ([CHILKATVFP.VCX] $ UPPER(SET([CLASSLIB])))

  SET CLASSLIB TO [ChilkatVFP.VCX] ADDITIVE

ENDIF NOT ([CHILKATVFP.VCX] $ UPPER(SET([CLASSLIB])))
** End alias not set test

** Alias not set test
IF NOT ([ICHILKATVFP.VCX] $ UPPER(SET([CLASSLIB])))

  SET CLASSLIB TO [iChilkatVFP.VCX] ADDITIVE

ENDIF NOT ([ICHILKATVFP.VCX] $ UPPER(SET([CLASSLIB])))
** End alias not set test
SET PATH TO [\] ADDITIVE

***************************
PROCEDURE AtomEventCallback
***************************

LPARAMETERS toChilkatVFPAtom AS [iAtom OF iChilkatVFP.VCX]

LOCAL loAtomEventHandler AS [AtomEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPAtom AS [iAtom OF iChilkatVFP.VCX], loChilkatAtom AS [Chilkat_9_5_0.Atom], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPAtom = toChilkatVFPAtom 

STORE NULL TO loAtomEventHandler, loChilkatAtom

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPAtom.Name]) == T_CHARACTER)

  loChilkatVFPAtom = CREATEOBJECT([iAtom])

ENDIF (NOT TYPE([loChilkatVFPAtom.Name]) == T_CHARACTER)
** End didn't pass an object test

loAtomEventHandler = CREATEOBJECT([AtomEvents])

WITH loChilkatVFPAtom 

  loChilkatAtom = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatAtom, loAtomEventHandler)

DEFINE CLASS AtomEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Atom"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

**************************
PROCEDURE Bz2EventCallback
**************************

LPARAMETERS toChilkatVFPBz2 AS [iBz2 OF iChilkatVFP.VCX]

LOCAL loBz2EventHandler AS [Bz2Events OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPBz2 AS [iBz2 OF iChilkatVFP.VCX], loChilkatBz2 AS [Chilkat_9_5_0.Bz2], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPBz2 = toChilkatVFPBz2

STORE NULL TO loBz2EventHandler, loChilkatBz2

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPBz2.Name]) == T_CHARACTER)

  loChilkatVFPBz2 = CREATEOBJECT([iBz2])

ENDIF (NOT TYPE([loChilkatVFPBz2.Name]) == T_CHARACTER)
** End didn't pass an object test

loBz2EventHandler = CREATEOBJECT([Bz2Events])

WITH loChilkatVFPBz2 

  loChilkatBz2 = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatBz2, loBz2EventHandler)

DEFINE CLASS Bz2Events AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Bz2"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

**********************************
PROCEDURE CompressionEventCallback
**********************************

LPARAMETERS toChilkatVFPCompression AS [iCompression OF iChilkatVFP.VCX]

LOCAL loCompressionEventHandler AS [CompressionEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPCompression AS [iCompression OF iChilkatVFP.VCX], ;
loChilkatCompression AS [Chilkat_9_5_0.Compression], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPCompression = toChilkatVFPCompression

STORE NULL TO loCompressionEventHandler, loChilkatCompression

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPCompression.Name]) == T_CHARACTER)

  loChilkatVFPCompression = CREATEOBJECT([iCompression])

ENDIF (NOT TYPE([loChilkatVFPCompression.Name]) == T_CHARACTER)
** End didn't pass an object test

loCompressionEventHandler = CREATEOBJECT([CompressionEvents])

WITH loChilkatVFPCompression 

  loChilkatCompression = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatCompression, loCompressionEventHandler)

DEFINE CLASS CompressionEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Compression"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

*****************************
PROCEDURE Crypt2EventCallback
*****************************

LPARAMETERS toChilkatVFPCrypt2 AS [iCrypt2 OF iChilkatVFP.VCX]

LOCAL loCrypt2EventHandler AS [Crypt2Events OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPCrypt2 AS [iCrypt2 OF iChilkatVFP.VCX], ;
loChilkatCrypt2 AS [Chilkat_9_5_0.Crypt2], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPCrypt2 = toChilkatVFPCrypt2

STORE NULL TO loCrypt2EventHandler, loChilkatCrypt2

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPCrypt2.Name]) == T_CHARACTER)

  loChilkatVFPCrypt2 = CREATEOBJECT([iCrypt2])

ENDIF (NOT TYPE([loChilkatVFPCrypt2.Name]) == T_CHARACTER)
** End didn't pass an object test

loCrypt2EventHandler = CREATEOBJECT([Crypt2Events])

WITH loChilkatVFPCrypt2 

  loChilkatCrypt2 = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatCrypt2, loCrypt2EventHandler)

DEFINE CLASS Crypt2Events AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Crypt2"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

***************************
PROCEDURE DkimEventCallback
***************************

LPARAMETERS toChilkatVFPDkim AS [iDkim OF iChilkatVFP.VCX]

LOCAL loDkimEventHandler AS [DkimEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPDkim AS [iDkim OF iChilkatVFP.VCX], loChilkatDkim AS [Chilkat_9_5_0.Dkim], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPDkim = toChilkatVFPDkim

STORE NULL TO loDkimEventHandler, loChilkatDkim

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPDkim.Name]) == T_CHARACTER)

  loChilkatVFPDkim = CREATEOBJECT([iDkim])

ENDIF (NOT TYPE([loChilkatVFPDkim.Name]) == T_CHARACTER)
** End didn't pass an object test

loDkimEventHandler = CREATEOBJECT([DkimEvents])

WITH loChilkatVFPDkim 

  loChilkatDkim = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatDkim, loDkimEventHandler)

DEFINE CLASS DkimEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Dkim"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

***************************
PROCEDURE FTP2EventCallback
***************************

LPARAMETERS toChilkatVFPFtp2 AS [iFtp2 OF iChilkatVFP.VCX]

**
** Enhancement for Version 47: Ensured that a final DownloadRate event callback 
** happens at the end of an operation to provide a final rate and byte count.
**
** Fixed for Version 49: UploadRate/DownloadRate events stopped at 4GB.
**
** Fixed for Version 49: FTP resume/restart percent-done progress monitoring fixed.
**
** Fixed for Version 51: The control/command connection is maintained (if possible) 
** when an upload or download is aborted. Previously, a file transfer aborted 
** by an application event callback caused the command connection to also be aborted.
**

LOCAL loFtp2EventHandler AS [Ftp2Events OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPFtp2 AS [iFtp2 OF iChilkatVFP.VCX], loChilkatFtp2 AS [Chilkat_9_5_0.Ftp2], ;
loChilkatVFPEventHandler AS [iFtp2EventHandler OF ChilkatVFP.VCX]

loChilkatVFPFtp2 = toChilkatVFPFtp2

STORE NULL TO loFtp2EventHandler, loChilkatFtp2

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPFtp2.Name]) == T_CHARACTER)

  loChilkatVFPFtp2 = CREATEOBJECT([iFtp2])

ENDIF (NOT TYPE([loChilkatVFPFtp2.Name]) == T_CHARACTER)
** End didn't pass an object test

loFtp2EventHandler = CREATEOBJECT([Ftp2Events])

WITH loChilkatVFPFtp2 

  loChilkatFtp2 = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatFtp2, loFtp2EventHandler)

DEFINE CLASS Ftp2Events AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatFtp2Events IN "Chilkat_9_5_0.Ftp2"

PROCEDURE _IChilkatFtp2Events_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatFtp2Events_BeginDownloadFile(tcPath AS Character, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.BeginDownloadFile(tcPath, tiSkip)
ENDPROC

PROCEDURE _IChilkatFtp2Events_BeginUploadFile(tcPath AS Character, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.BeginUploadFile(tcPath, tiSkip)
ENDPROC

PROCEDURE _IChilkatFtp2Events_DownloadRate(tiByteCount AS Integer, tiBytesPerSec AS Integer)
RETURN loChilkatVFPEventHandler.DownloadRate(tiByteCount, tiBytesPerSec)
ENDPROC

PROCEDURE _IChilkatFtp2Events_EndDownloadFile(tcPath AS Character, tiByteCount AS Integer)
RETURN loChilkatVFPEventHandler.EndDownloadFile(tcPath, tiByteCount)
ENDPROC

PROCEDURE _IChilkatFtp2Events_EndUploadFile(tcPath AS Character, tiByteCount AS Integer)
RETURN loChilkatVFPEventHandler.EndUploadFile(tcPath, tiByteCount)
ENDPROC

PROCEDURE _IChilkatFtp2Events_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatFtp2Events_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatFtp2Events_UploadRate(tiByteCount AS Integer, tiBytesPerSec AS Integer)
RETURN loChilkatVFPEventHandler.UploadRate(tiByteCount, tiBytesPerSec)
ENDPROC

PROCEDURE _IChilkatFtp2Events_VerifyDeleteDir(tcPath AS Character, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.VerifyDeleteDir(tcPath, tiSkip)
ENDPROC

PROCEDURE _IChilkatFtp2Events_VerifyDeleteFile(tcPath AS Character, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.VerifyDeleteFile(tcPath, tiSkip)
ENDPROC

PROCEDURE _IChilkatFtp2Events_VerifyDownloadDir(tcPath AS Character, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.VerifyDownloadDir(tcPath, tiSkip)
ENDPROC

PROCEDURE _IChilkatFtp2Events_VerifyUploadDir(tcPath AS Character, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.VerifyDownloadDir(tcPath, tiSkip)
ENDPROC

ENDDEFINE

***************************
PROCEDURE GZipEventCallback
***************************

LPARAMETERS toChilkatVFPGzip AS [iGzip OF iChilkatVFP.VCX]

LOCAL loGzipEventHandler AS [GzipEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPGzip AS [iGzip OF iChilkatVFP.VCX], loChilkatGzip AS [Chilkat_9_5_0.Gzip], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPGZip = toChilkatVFPGZip

STORE NULL TO loGZipEventHandler, loChilkatGZip

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPGzip.Name]) == T_CHARACTER)

  loChilkatVFPGzip = CREATEOBJECT([iGzip])

ENDIF (NOT TYPE([loChilkatVFPGzip.Name]) == T_CHARACTER)
** End didn't pass an object test

loGzipEventHandler = CREATEOBJECT([GzipEvents])

WITH loChilkatVFPGzip 

  loChilkatGzip = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatGzip, loGzipEventHandler)

DEFINE CLASS GzipEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Gzip"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

***************************
PROCEDURE HttpEventCallback
***************************

LPARAMETERS toChilkatVFPHttp AS [iHttp OF iChilkatVFP.VCX]

**
** Fixed for Version 32: For HTTP requests that have KeepAlive indicated in the response header, 
** the internal connection is not closed so that a subsequent request may continue 
** using the existing connection. However, when the client application aborts in the middle 
** of receiving the response, the connection must be closed to avoid being left in an invalid state 
** (where the some of the remainder of the aborted request may have already been received 
** and would incorrectly be read as the first bytes of the nexxt response). 
** The internal fix was to always close the connection after an abort (AbortCheck) 
** so that the next HTTP operation starts afresh on a new connection.
**
** Fixed for Version 35: The PercentDone callback always began at 0 when resuming a download. 
** If a partial file exists locally, and the download is resumed, 
** the percent done now begins at the place based on the size of the partial file. 
** (If 50% of the file already exists, then the percent done begins at 50%)
**
** Enhancement for Version 46: The percent done event will track the sending of the HTTP request 
** (i.e. the upload) rather than the receiving of the HTTP request. 
** The choice of whether percent-done tracks the request or response is automatic 
** and is determined by the size of the request.
** 

LOCAL loHttpEventHandler AS [HttpEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPHttp AS [iHttp OF iChilkatVFP.VCX], loChilkatHttp AS [Chilkat_9_5_0.Http], ;
loChilkatVFPEventHandler AS [iHTTPEventHandler OF ChilkatVFP.VCX]

loChilkatVFPHttp = toChilkatVFPHttp

STORE NULL TO loHttpEventHandler, loChilkatHttp

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([toChilkatVFPHTTP.Name]) == T_CHARACTER)

  loChilkatVFPHttp = CREATEOBJECT([iHttp])

ENDIF (NOT TYPE([toChilkatVFPHTTP.Name]) == T_CHARACTER)
** End didn't pass an object test

loHttpEventHandler = CREATEOBJECT([HttpEvents])

WITH loChilkatVFPHttp

  loChilkatHttp = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatHttp, loHttpEventHandler)

DEFINE CLASS HttpEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatHttpEvents IN "Chilkat_9_5_0.Http"

PROCEDURE _IChilkatHttpEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatHttpEvents_BeginReceive
RETURN loChilkatVFPEventHandler.BeginReceive()
ENDPROC

PROCEDURE _IChilkatHttpEvents_BeginSend
RETURN loChilkatVFPEventHandler.BeginSend()
ENDPROC

PROCEDURE _IChilkatHttpEvents_EndReceive(tiSuccess AS Integer)
RETURN loChilkatVFPEventHandler.EndReceive(tiSuccess)
ENDPROC

PROCEDURE _IChilkatHttpEvents_EndSend(tiSuccess AS Integer)
RETURN loChilkatVFPEventHandler.EndSend(tiSuccess)
ENDPROC

PROCEDURE _IChilkatHttpEvents_HttpChunked
RETURN loChilkatVFPEventHandler.HttpChunked()
ENDPROC

PROCEDURE _IChilkatHttpEvents_HttpRedirect(tcOriginalUrl AS Character, ;
tcRedirectUrl AS Character, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.HttpRedirect(tcOriginalUrl, tcRedirectUrl, tiAbort)
ENDPROC

PROCEDURE _IChilkatHttpEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatHttpEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatHttpEvents_ReceiveRate(tiByteCount AS Integer, tiBytesPerSec AS Integer)
RETURN loChilkatVFPEventHandler.ReceiveRate(tiByteCount, tiBytesPerSec)
ENDPROC

PROCEDURE _IChilkatHttpEvents_SendRate(tiByteCount AS Integer, tiBytesPerSec AS Integer)
RETURN loChilkatVFPEventHandler.SendRate(tiByteCount, tiBytesPerSec)
ENDPROC

ENDDEFINE

***************************
PROCEDURE IMapEventCallback
***************************

LPARAMETERS toChilkatVFPImap AS [iImap OF iChilkatVFP.VCX]

LOCAL loImapEventHandler AS [ImapEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPImap AS [iImap OF iChilkatVFP.VCX], loChilkatImap AS [Chilkat_9_5_0.Imap], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPImap = toChilkatVFPImap

STORE NULL TO loImapEventHandler, loChilkatImap

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPImap.Name]) == T_CHARACTER)

  loChilkatVFPImap = CREATEOBJECT([iImap])

ENDIF (NOT TYPE([loChilkatVFPImap.Name]) == T_CHARACTER)
** End didn't pass an object test

loImapEventHandler = CREATEOBJECT([ImapEvents])

WITH loChilkatVFPImap 

  loChilkatImap = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatImap, loImapEventHandler)

DEFINE CLASS ImapEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Imap"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

******************************
PROCEDURE MailManEventCallback
******************************

LPARAMETERS toChilkatVFPMailMan AS [iMailMan OF iChilkatVFP.VCX]

LOCAL loMailManEventHandler AS [MailManEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPMailMan AS [iMailMan OF iChilkatVFP.VCX], ;
loChilkatMailMan AS [Chilkat_9_5_0.MailMan], ;
loChilkatVFPEventHandler AS [iMailManEventHandler OF ChilkatVFP.VCX]

loChilkatVFPMailMan = toChilkatVFPMailMan

STORE NULL TO loMailManEventHandler, loChilkatMailMan

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPMailMan.Name]) == T_CHARACTER)

  loChilkatVFPMailMan = CREATEOBJECT([iMailMan])

ENDIF (NOT TYPE([loChilkatVFPMailMan.Name]) == T_CHARACTER)
** End didn't pass an object test

loMailManEventHandler = CREATEOBJECT([MailManEvents])

WITH loChilkatVFPMailMan 

  loChilkatMailMan = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatMailMan, loMailManEventHandler)

DEFINE CLASS MailManEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatMailManEvents IN "Chilkat_9_5_0.MailMan"

PROCEDURE _IChilkatMailManEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatMailManEvents_EmailReceived(tcSubject AS Character, ;
tcFromAddr AS Character, tcFromName AS Character, tcReturnPath AS Character, ;
tcDate AS Character, tcUIDL AS Character, tiSizeInBytes AS Integer)
RETURN loChilkatVFPEventHandler.EmailReceived(tcSubject, ;
tcFromAddr, tcFromName, tcReturnPath, tcDate, tcUIDL, tiSizeInBytes)
ENDPROC

PROCEDURE _IChilkatMailManEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatMailManEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

**************************
PROCEDURE MhtEventCallback
**************************

LPARAMETERS toChilkatVFPMht AS [iMht OF iChilkatVFP.VCX]

LOCAL loMhtEventHandler AS [MhtEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPMht AS [iMht OF iChilkatVFP.VCX], loChilkatMht AS [Chilkat_9_5_0.Mht], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPMht = toChilkatVFPMht

STORE NULL TO loMhtEventHandler, loChilkatMht

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPMht.Name]) == T_CHARACTER)

  loChilkatVFPMht = CREATEOBJECT([iMht])

ENDIF (NOT TYPE([loChilkatVFPMht.Name]) == T_CHARACTER)
** End didn't pass an object test

loMhtEventHandler = CREATEOBJECT([MhtEvents])

WITH loChilkatVFPMht 

  loChilkatMht = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatMht, loMhtEventHandler)

DEFINE CLASS MhtEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Mht"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

**************************
PROCEDURE PemEventCallback
**************************

LPARAMETERS toChilkatVFPPem AS [iPem OF iChilkatVFP.VCX]

LOCAL loPemEventHandler AS [PemEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPPem AS [iPem OF iChilkatVFP.VCX], loChilkatPem AS [Chilkat_9_5_0.Pem], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPPem = toChilkatVFPPem

STORE NULL TO loPemEventHandler, loChilkatPem

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPPem.Name]) == T_CHARACTER)

  loChilkatVFPPem = CREATEOBJECT([iPem])

ENDIF (NOT TYPE([loChilkatVFPPem.Name]) == T_CHARACTER)
** End didn't pass an object test

loPemEventHandler = CREATEOBJECT([PemEvents])

WITH loChilkatVFPPem 

  loChilkatPem = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatPem, loPemEventHandler)

DEFINE CLASS PemEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Pem"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

**************************
PROCEDURE RssEventCallback
**************************

LPARAMETERS toChilkatVFPRss AS [iRss OF iChilkatVFP.VCX]

LOCAL loRssEventHandler AS [RssEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPRss AS [iRss OF iChilkatVFP.VCX], loChilkatRss AS [Chilkat_9_5_0.Rss], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPRss = toChilkatVFPRss

STORE NULL TO loRssEventHandler, loChilkatRss

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPRss.Name]) == T_CHARACTER)

  loChilkatVFPRss = CREATEOBJECT([iRss])

ENDIF (NOT TYPE([loChilkatVFPRss.Name]) == T_CHARACTER)
** End didn't pass an object test

loRssEventHandler = CREATEOBJECT([RssEvents])

WITH loChilkatVFPRss 

  loChilkatRss = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatRss, loRssEventHandler)

DEFINE CLASS RssEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Rss"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

**************************
PROCEDURE ScpEventCallback
**************************

LPARAMETERS toChilkatVFPScp AS [iScp OF iChilkatVFP.VCX]

LOCAL loScpEventHandler AS [ScpEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPScp AS [iScp OF iChilkatVFP.VCX], loChilkatScp AS [Chilkat_9_5_0.Scp], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPScp = toChilkatVFPScp

STORE NULL TO loScpEventHandler, loChilkatScp

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPScp.Name]) == T_CHARACTER)

  loChilkatVFPScp = CREATEOBJECT([iScp])

ENDIF (NOT TYPE([loChilkatVFPScp.Name]) == T_CHARACTER)
** End didn't pass an object test

loScpEventHandler = CREATEOBJECT([ScpEvents])

WITH loChilkatVFPScp 

  loChilkatScp = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatScp, loScpEventHandler)

DEFINE CLASS ScpEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Scp"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

***************************
PROCEDURE SFtpEventCallback
***************************

LPARAMETERS toChilkatVFPSFtp AS [iSFtp OF iChilkatVFP.VCX]

**
** Enhancement for Version 47: Ensured that a final DownloadRate event callback 
** happens at the end of an operation to provide a final rate and byte count.
**

LOCAL loSFtpEventHandler AS [SFtpEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPSFtp AS [iSFtp OF iChilkatVFP.VCX], loChilkatSFtp AS [Chilkat_9_5_0.SFtp], ;
loChilkatVFPEventHandler AS [iSFtpEventHandler OF ChilkatVFP.VCX]

loChilkatVFPSFtp = toChilkatVFPSFtp

STORE NULL TO loSFtpEventHandler, loChilkatSFtp

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSFtp.Name]) == T_CHARACTER)

  loChilkatVFPSFtp = CREATEOBJECT([iSFtp])

ENDIF (NOT TYPE([loChilkatVFPSFtp.Name]) == T_CHARACTER)
** End didn't pass an object test

loSFtpEventHandler = CREATEOBJECT([SFtpEvents])

WITH loChilkatVFPSFtp 

  loChilkatSFtp = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatSFtp, loSFtpEventHandler)

DEFINE CLASS SFtpEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatSFtpEvents IN "Chilkat_9_5_0.SFtp"

PROCEDURE _IChilkatSFtpEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatSFtpEvents_DownloadRate(tiByteCount AS Integer, tiBytesPerSec AS Integer)
RETURN loChilkatVFPEventHandler.DownloadRate(tiByteCount, tiBytesPerSec)
ENDPROC

PROCEDURE _IChilkatSFtpEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatSFtpEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatSFtpEvents_UploadRate(tiByteCount AS Integer, tiBytesPerSec AS Integer)
RETURN loChilkatVFPEventHandler.UploadRate(tiByteCount, tiBytesPerSec)
ENDPROC

ENDDEFINE

*****************************
PROCEDURE SocketEventCallback
*****************************

LPARAMETERS toChilkatVFPSocket AS [iSocket OF iChilkatVFP.VCX]

LOCAL loSocketEventHandler AS [SocketEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPSocket AS [iSocket OF iChilkatVFP.VCX], ;
loChilkatSocket AS [Chilkat_9_5_0.Socket], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPSocket = toChilkatVFPSocket

STORE NULL TO loSocketEventHandler, loChilkatSocket

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSocket.Name]) == T_CHARACTER)

  loChilkatVFPSocket = CREATEOBJECT([iSocket])

ENDIF (NOT TYPE([loChilkatVFPSocket.Name]) == T_CHARACTER)
** End didn't pass an object test

loSocketEventHandler = CREATEOBJECT([SocketEvents])

WITH loChilkatVFPSocket 

  loChilkatSocket = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatSocket, loSocketEventHandler)

DEFINE CLASS SocketEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Socket"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

*****************************
PROCEDURE SpiderEventCallback
*****************************

LPARAMETERS toChilkatVFPSpider AS [iSpider OF iChilkatVFP.VCX]

LOCAL loSpiderEventHandler AS [SpiderEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPSpider AS [iSpider OF iChilkatVFP.VCX], ;
loChilkatSpider AS [Chilkat_9_5_0.Spider], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPSpider = toChilkatVFPSpider

STORE NULL TO loSpiderEventHandler, loChilkatSpider

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSpider.Name]) == T_CHARACTER)

  loChilkatVFPSpider = CREATEOBJECT([iSpider])

ENDIF (NOT TYPE([loChilkatVFPSpider.Name]) == T_CHARACTER)
** End didn't pass an object test

loSpiderEventHandler = CREATEOBJECT([SpiderEvents])

WITH loChilkatVFPSpider 

  loChilkatSpider = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatSpider, loSpiderEventHandler)

DEFINE CLASS SpiderEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Spider"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

**************************
PROCEDURE SshEventCallback
**************************

LPARAMETERS toChilkatVFPSsh AS [iSsh OF iChilkatVFP.VCX]

LOCAL loSshEventHandler AS [SshEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPSsh AS [iSsh OF iChilkatVFP.VCX], loChilkatSsh AS [Chilkat_9_5_0.Ssh], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPSsh = toChilkatVFPSsh

STORE NULL TO loSshEventHandler, loChilkatSsh

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSsh.Name]) == T_CHARACTER)

  loChilkatVFPSsh = CREATEOBJECT([iSsh])

ENDIF (NOT TYPE([loChilkatVFPSsh.Name]) == T_CHARACTER)
** End didn't pass an object test

loSshEventHandler = CREATEOBJECT([SshEvents])

WITH loChilkatVFPSsh 

  loChilkatSsh = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatSsh, loSshEventHandler)

DEFINE CLASS SshEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Ssh"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

********************************
PROCEDURE SshTunnelEventCallback
********************************

LPARAMETERS toChilkatVFPSshTunnel AS [iSshTunnel OF iChilkatVFP.VCX]

LOCAL loSshTunnelEventHandler AS [SshTunnelEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPSshTunnel AS [iSshTunnel OF iChilkatVFP.VCX], ;
loChilkatSshTunnel AS [Chilkat_9_5_0.SshTunnel], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPSshTunnel = toChilkatVFPSshTunnel

STORE NULL TO loSshTunnelEventHandler, loChilkatSshTunnel

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSshTunnel.Name]) == T_CHARACTER)

  loChilkatVFPSshTunnel = CREATEOBJECT([iSshTunnel])

ENDIF (NOT TYPE([loChilkatVFPSshTunnel.Name]) == T_CHARACTER)
** End didn't pass an object test

loSshTunnelEventHandler = CREATEOBJECT([SshTunnelEvents])

WITH loChilkatVFPSshTunnel 

  loChilkatSshTunnel = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatSshTunnel, loSshTunnelEventHandler)

DEFINE CLASS SshTunnelEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.SshTunnel"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

**************************
PROCEDURE TarEventCallback
**************************

LPARAMETERS toChilkatVFPTar AS [iTar OF iChilkatVFP.VCX]

LOCAL loTarEventHandler AS [TarEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPTar AS [iTar OF iChilkatVFP.VCX], loChilkatTar AS [Chilkat_9_5_0.Tar], ;
loChilkatVFPEventHandler AS [iTarEventHandler OF ChilkatVFP.VCX]

loChilkatVFPTar = toChilkatVFPTar

STORE NULL TO loTarEventHandler, loChilkatTar

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPTar.Name]) == T_CHARACTER)

  loChilkatVFPTar = CREATEOBJECT([iTar])

ENDIF (NOT TYPE([loChilkatVFPTar.Name]) == T_CHARACTER)
** End didn't pass an object test

loTarEventHandler = CREATEOBJECT([TarEvents])

WITH loChilkatVFPTar 

  loChilkatTar = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatTar, loTarEventHandler)

DEFINE CLASS TarEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatTarEvents IN "Chilkat_9_5_0.Tar"

PROCEDURE _IChilkatTarEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatTarEvents_NextTarFile(tcPath AS Character, ;
tiFileSize AS Integer, tiIsDirectory AS Integer, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.NextTarFile(tcPath, tiFileSize, tiIsDirectory, tiSkip)
ENDPROC

PROCEDURE _IChilkatTarEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatTarEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

***********************************
PROCEDURE TrustedRootsEventCallback
***********************************

LPARAMETERS toChilkatVFPTrustedRoots AS [iTrustedRoots OF iChilkatVFP.VCX]

LOCAL loTrustedRootsEventHandler AS [TrustedRootsEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPTrustedRoots AS [iTrustedRoots OF iChilkatVFP.VCX], ;
loChilkatTrustedRoots AS [Chilkat_9_5_0.TrustedRoots], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPTrustedRoots = toChilkatVFPTrustedRoots

STORE NULL TO loTrustedRootsEventHandler, loChilkatTrustedRoots

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPTrustedRoots.Name]) == T_CHARACTER)

  loChilkatVFPTrustedRoots = CREATEOBJECT([iTrustedRoots])

ENDIF (NOT TYPE([loChilkatVFPTrustedRoots.Name]) == T_CHARACTER)
** End didn't pass an object test

loTrustedRootsEventHandler = CREATEOBJECT([TrustedRootsEvents])

WITH loChilkatVFPTrustedRoots 

  loChilkatTrustedRoots = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatTrustedRoots, loTrustedRootsEventHandler)

DEFINE CLASS TrustedRootsEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.TrustedRoots"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

***********************************
PROCEDURE UnixCompressEventCallback
***********************************

LPARAMETERS toChilkatVFPUnixCompress AS [iUnixCompress OF iChilkatVFP.VCX]

LOCAL loUnixCompressEventHandler AS [UnixCompressEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPUnixCompress AS [iUnixCompress OF iChilkatVFP.VCX], ;
loChilkatUnixCompress AS [Chilkat_9_5_0.UnixCompress], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPUnixCompress = toChilkatVFPUnixCompress

STORE NULL TO loUnixCompressEventHandler, loChilkatUnixCompress

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPUnixCompress.Name]) == T_CHARACTER)

  loChilkatVFPUnixCompress = CREATEOBJECT([iUnixCompress])

ENDIF (NOT TYPE([loChilkatVFPUnixCompress.Name]) == T_CHARACTER)
** End didn't pass an object test

loUnixCompressEventHandler = CREATEOBJECT([UnixCompressEvents])

WITH loChilkatVFPUnixCompress 

  loChilkatUnixCompress = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatUnixCompress, loUnixCompressEventHandler)

DEFINE CLASS UnixCompressEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.UnixCompress"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

*****************************
PROCEDURE UploadEventCallback
*****************************

LPARAMETERS toChilkatVFPUpload AS [iUpload OF iChilkatVFP.VCX]

LOCAL loUploadEventHandler AS [UploadEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPUpload AS [iUpload OF iChilkatVFP.VCX], ;
loChilkatUpload AS [Chilkat_9_5_0.Upload], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPUpload = toChilkatVFPUpload

STORE NULL TO loUploadEventHandler, loChilkatUpload

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPUpload.Name]) == T_CHARACTER)

  loChilkatVFPUpload = CREATEOBJECT([iUpload])

ENDIF (NOT TYPE([loChilkatVFPUpload.Name]) == T_CHARACTER)
** End didn't pass an object test

loUploadEventHandler = CREATEOBJECT([UploadEvents])

WITH loChilkatVFPUpload 

  loChilkatUpload = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatUpload, loUploadEventHandler)

DEFINE CLASS UploadEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Upload"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

**************************
PROCEDURE ZipEventCallback
**************************

LPARAMETERS toChilkatVFPZip AS [iZip OF iChilkatVFP.VCX]

**
** Fixed for Version 48: For files skipped because of access-denied or file-not-found, 
** the FileZipped event fired when it should not have. This was fixed, 
** and in addition a ProgressInfo event was added for each occurance, 
** using the names “fileAccessDenied” and “fileNotFound”. 
** (Each Progress info event has two params: a name and value 
** where the name identifies the event, and the value contains information specific to the event.)
** 

LOCAL loZipEventHandler AS [ZipEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPZip AS [iZip OF iChilkatVFP.VCX], loChilkatZip AS [Chilkat_9_5_0.Zip], ;
loChilkatVFPEventHandler AS [iZipEventHandler OF ChilkatVFP.VCX]

loChilkatVFPZip = toChilkatVFPZip

STORE NULL TO loZipEventHandler, loChilkatZip

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPZip.Name]) == T_CHARACTER)

  loChilkatVFPZip = CREATEOBJECT([iZip])

ENDIF (NOT TYPE([loChilkatVFPZip.Name]) == T_CHARACTER)
** End didn't pass an object test

loZipEventHandler = CREATEOBJECT([ZipEvents])

WITH loChilkatVFPZip 

  loChilkatZip = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatZip, loZipEventHandler)

DEFINE CLASS ZipEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatZipEvents IN "Chilkat_9_5_0.Zip"

PROCEDURE _IChilkatZipEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatZipEvents_AddFilesBegin
RETURN loChilkatVFPEventHandler.AddFilesBegin()
ENDPROC

PROCEDURE _IChilkatZipEvents_AddFilesEnd
RETURN loChilkatVFPEventHandler.AddFilesEnd()
ENDPROC

PROCEDURE _IChilkatZipEvents_DirToBeAdded(tcPath AS Character, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.DirToBeAdded(tcPath, tiSkip)
ENDPROC

PROCEDURE _IChilkatZipEvents_FileAdded(tcPath AS Character, ;
tiFileSize AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.FileAdded(tcPath, tiFileSize, tiAbort)
ENDPROC

PROCEDURE _IChilkatZipEvents_FileUnzipped(tcPath AS Character, ;
tiCompressedSize AS Integer, tiFileSize AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.FileUnzipped(tcPath, tiCompressedSize, tiFileSize, tiAbort)
ENDPROC

PROCEDURE _IChilkatZipEvents_FileZipped(tcPath AS Character, ;
tiFileSize AS Integer, tiCompressedSize AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.FileZipped(tcPath, tiFileSize, tiCompressedSize, tiAbort)
ENDPROC

PROCEDURE _IChilkatZipEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatZipEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatZipEvents_SkippedForUnzip(tcPath AS Character, ;
tiCompressedSize AS Integer, tiFileSize AS Integer)
RETURN loChilkatVFPEventHandler.SkippedForUnzip(tcPath, tiCompressedSize, tiFileSize)
ENDPROC

PROCEDURE _IChilkatZipEvents_ToBeAdded(tcPath AS Character, ;
tiFileSize AS Integer, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.ToBeAdded(tcPath, tiFileSize, tiSkip)
ENDPROC

PROCEDURE _IChilkatZipEvents_ToBeUnzipped(tcPath AS Character, ;
tiCompressedSize AS Integer, tiFileSize AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.ToBeUnzipped(tcPath, tiCompressedSize, tiFileSize, tiAbort)
ENDPROC

PROCEDURE _IChilkatZipEvents_ToBeZipped(tcPath AS Character, ;
tiFileSize AS Integer, tiSkip AS Integer)
RETURN loChilkatVFPEventHandler.ToBeZipped(tcPath, tiFileSize, tiSkip)
ENDPROC

PROCEDURE _IChilkatZipEvents_UnzipBegin
RETURN loChilkatVFPEventHandler.UnzipBegin()
ENDPROC

PROCEDURE _IChilkatZipEvents_UnzipEnd
RETURN loChilkatVFPEventHandler.UnzipEnd()
ENDPROC

PROCEDURE _IChilkatZipEvents_WriteZipBegin
RETURN loChilkatVFPEventHandler.WriteZipBegin()
ENDPROC

PROCEDURE _IChilkatZipEvents_WriteZipEnd
RETURN loChilkatVFPEventHandler.WriteZipEnd()
ENDPROC

ENDDEFINE

*****************************
PROCEDURE ZipCRCEventCallback
*****************************

LPARAMETERS toChilkatVFPZipCrc AS [iZipCrc OF iChilkatVFP.VCX]

LOCAL loZipCrcEventHandler AS [ZipCrcEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPZipCrc AS [iZipCrc OF iChilkatVFP.VCX], ;
loChilkatZipCrc AS [Chilkat_9_5_0.ZipCrc], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPZipCrc = toChilkatVFPZipCrc

STORE NULL TO loZipCrcEventHandler, loChilkatZipCrc

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPZipCrc.Name]) == T_CHARACTER)

  loChilkatVFPZipCrc = CREATEOBJECT([iZipCrc])

ENDIF (NOT TYPE([loChilkatVFPZipCrc.Name]) == T_CHARACTER)
** End didn't pass an object test

loZipCrcEventHandler = CREATEOBJECT([ZipCrcEvents])

WITH loChilkatVFPZipCrc 

  loChilkatZipCrc = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatZipCrc, loZipCrcEventHandler)

DEFINE CLASS ZipCrcEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.ZipCrc"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE

*******************************
PROCEDURE ZipEntryEventCallback
*******************************

LPARAMETERS toChilkatVFPZipEntry AS [iZipEntry OF iChilkatVFP.VCX]

LOCAL loZipEntryEventHandler AS [ZipEntryEvents OF ChilkatVFPEventCallbacksPrev52.PRG], ;
loChilkatVFPZipEntry AS [iZipEntry OF iChilkatVFP.VCX], ;
loChilkatZipEntry AS [Chilkat_9_5_0.ZipEntry], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF ChilkatVFP.VCX]

loChilkatVFPZipEntry = toChilkatVFPZipEntry

STORE NULL TO loZipEntryEventHandler, loChilkatZipEntry

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPZipEntry.Name]) == T_CHARACTER)

  loChilkatVFPZipEntry = CREATEOBJECT([iZipEntry])

ENDIF (NOT TYPE([loChilkatVFPZipEntry.Name]) == T_CHARACTER)
** End didn't pass an object test

loZipEntryEventHandler = CREATEOBJECT([ZipEntryEvents])

WITH loChilkatVFPZipEntry 

  loChilkatZipEntry = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatZipEntry, loZipEntryEventHandler)

DEFINE CLASS ZipEntryEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.ZipEntry"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

ENDDEFINE