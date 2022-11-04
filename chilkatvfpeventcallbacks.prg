*==============================================================================
* Purpose:           ChilkatVFP Event Callbacks
* Author:            Bill Anderson
* Notice:            Copyright (c) 2022 The Anderson Files LLC, All Rights Reserved.
* Returns:           Logical, indicating success.
* Date Added:        10/07/2022
*==============================================================================

#INCLUDE FoxPro.H

**************************************
PROCEDURE ChilkatVFPEventCallbackSetup
**************************************

** Alias not set test
IF NOT ([CHILKAT.VCX] $ UPPER(SET([CLASSLIB])))

  SET CLASSLIB TO [Chilkat.VCX] ADDITIVE

ENDIF NOT ([CHILKAT.VCX] $ UPPER(SET([CLASSLIB])))
** End alias not set test

SET PATH TO [\] ADDITIVE

***************************
PROCEDURE AtomEventCallback
***************************

LPARAMETERS toChilkatVFPAtom AS [Chilkat_9_5_0.Atom]

LOCAL loAtomEventHandler AS [AtomEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPAtom AS [Atom OF Chilkat.VCX], loChilkatAtom AS [Chilkat_9_5_0.Atom], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPAtom = toChilkatVFPAtom 

STORE NULL TO loAtomEventHandler, loChilkatAtom

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPAtom.Name]) == T_CHARACTER)

  loChilkatVFPAtom = CREATEOBJECT([Atom])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**********************************
PROCEDURE AuthAzureADEventCallback
**********************************

LPARAMETERS toChilkatVFPAuthAzureAD AS [Chilkat_9_5_0.AuthAzureAD]

LOCAL loAuthAzureADEventHandler AS [AuthAzureADEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPAuthAzureAD AS [AuthAzureAD OF Chilkat.VCX], ;
loChilkatAuthAzureAD AS [Chilkat_9_5_0.AuthAzureAD], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPAuthAzureAD = toChilkatVFPAuthAzureAD 

STORE NULL TO loAuthAzureADEventHandler, loChilkatAuthAzureAD

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPAuthAzureAD.Name]) == T_CHARACTER)

  loChilkatVFPAuthAzureAD = CREATEOBJECT([AuthAzureAD])

ENDIF (NOT TYPE([loChilkatVFPAuthAzureAD.Name]) == T_CHARACTER)
** End didn't pass an object test

loAuthAzureADEventHandler = CREATEOBJECT([AuthAzureADEvents])

WITH loChilkatVFPAuthAzureAD 

  loChilkatAuthAzureAD = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatAuthAzureAD, loAuthAzureADEventHandler)

DEFINE CLASS AuthAzureADEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.AuthAzureAD"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

*********************************
PROCEDURE AuthGoogleEventCallback
*********************************

LPARAMETERS toChilkatVFPAuthGoogle AS [Chilkat_9_5_0.AuthGoogle]

LOCAL loAuthGoogleEventHandler AS [AuthGoogleEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPAuthGoogle AS [AuthGoogle OF Chilkat.VCX], ;
loChilkatAuthGoogle AS [Chilkat_9_5_0.AuthGoogle], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPAuthGoogle = toChilkatVFPAuthGoogle 

STORE NULL TO loAuthGoogleEventHandler, loChilkatAuthGoogle

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPAuthGoogle.Name]) == T_CHARACTER)

  loChilkatVFPAuthGoogle = CREATEOBJECT([AuthGoogle])

ENDIF (NOT TYPE([loChilkatVFPAuthGoogle.Name]) == T_CHARACTER)
** End didn't pass an object test

loAuthGoogleEventHandler = CREATEOBJECT([AuthGoogleEvents])

WITH loChilkatVFPAuthGoogle 

  loChilkatAuthGoogle = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatAuthGoogle, loAuthGoogleEventHandler)

DEFINE CLASS AuthGoogleEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.AuthGoogle"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**************************
PROCEDURE Bz2EventCallback
**************************

LPARAMETERS toChilkatVFPBz2 AS [Chilkat_9_5_0.Bz2]

LOCAL loBz2EventHandler AS [Bz2Events OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPBz2 AS [Bz2 OF Chilkat.VCX], loChilkatBz2 AS [Chilkat_9_5_0.Bz2], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPBz2 = toChilkatVFPBz2

STORE NULL TO loBz2EventHandler, loChilkatBz2

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPBz2.Name]) == T_CHARACTER)

  loChilkatVFPBz2 = CREATEOBJECT([Bz2])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**********************************
PROCEDURE CompressionEventCallback
**********************************

LPARAMETERS toChilkatVFPCompression AS [Chilkat_9_5_0.Compression]

LOCAL loCompressionEventHandler AS [CompressionEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPCompression AS [Compression OF Chilkat.VCX], ;
loChilkatCompression AS [Chilkat_9_5_0.Compression], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPCompression = toChilkatVFPCompression

STORE NULL TO loCompressionEventHandler, loChilkatCompression

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPCompression.Name]) == T_CHARACTER)

  loChilkatVFPCompression = CREATEOBJECT([Compression])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

*****************************
PROCEDURE Crypt2EventCallback
*****************************

LPARAMETERS toChilkatVFPCrypt2 AS [Chilkat_9_5_0.Crypt2]

LOCAL loCrypt2EventHandler AS [Crypt2Events OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPCrypt2 AS [Crypt2 OF Chilkat.VCX], ;
loChilkatCrypt2 AS [Chilkat_9_5_0.Crypt2], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPCrypt2 = toChilkatVFPCrypt2

STORE NULL TO loCrypt2EventHandler, loChilkatCrypt2

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPCrypt2.Name]) == T_CHARACTER)

  loChilkatVFPCrypt2 = CREATEOBJECT([Crypt2])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

***************************
PROCEDURE DkimEventCallback
***************************

LPARAMETERS toChilkatVFPDkim AS [Chilkat_9_5_0.Dkim]

LOCAL loDkimEventHandler AS [DkimEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPDkim AS [Dkim OF Chilkat.VCX], loChilkatDkim AS [Chilkat_9_5_0.Dkim], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPDkim = toChilkatVFPDkim

STORE NULL TO loDkimEventHandler, loChilkatDkim

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPDkim.Name]) == T_CHARACTER)

  loChilkatVFPDkim = CREATEOBJECT([Dkim])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

***************************
PROCEDURE FTP2EventCallback
***************************

LPARAMETERS toChilkatVFPFtp2 AS [Chilkat_9_5_0.Ftp2]

LOCAL loFtp2EventHandler AS [Ftp2Events OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPFtp2 AS [Ftp2 OF Chilkat.VCX], loChilkatFtp2 AS [Chilkat_9_5_0.Ftp2], ;
loChilkatVFPEventHandler AS [iFtp2EventHandler OF Chilkat.VCX]

loChilkatVFPFtp2 = toChilkatVFPFtp2

STORE NULL TO loFtp2EventHandler, loChilkatFtp2

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPFtp2.Name]) == T_CHARACTER)

  loChilkatVFPFtp2 = CREATEOBJECT([Ftp2])

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

PROCEDURE _IChilkatFtp2Events_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
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

PROCEDURE _IChilkatFtp2Events_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatFtp2Events_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
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

LPARAMETERS toChilkatVFPGzip AS [Chilkat_9_5_0.Gzip]

LOCAL loGzipEventHandler AS [GzipEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPGzip AS [Gzip OF Chilkat.VCX], loChilkatGzip AS [Chilkat_9_5_0.Gzip], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPGZip = toChilkatVFPGZip

STORE NULL TO loGZipEventHandler, loChilkatGZip

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPGzip.Name]) == T_CHARACTER)

  loChilkatVFPGzip = CREATEOBJECT([Gzip])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

***************************
PROCEDURE HttpEventCallback
***************************

LPARAMETERS toChilkatVFPHttp AS [Chilkat_9_5_0.Http]

LOCAL loHttpEventHandler AS [HttpEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPHttp AS [Http OF Chilkat.VCX], loChilkatHttp AS [Chilkat_9_5_0.Http], ;
loChilkatVFPEventHandler AS [iHTTPEventHandler OF Chilkat.VCX]

loChilkatVFPHttp = toChilkatVFPHttp

STORE NULL TO loHttpEventHandler, loChilkatHttp

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([toChilkatVFPHTTP.Name]) == T_CHARACTER)

  loChilkatVFPHttp = CREATEOBJECT([Http])

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

PROCEDURE _IChilkatHttpEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
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

PROCEDURE _IChilkatHttpEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatHttpEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

***************************
PROCEDURE IMapEventCallback
***************************

LPARAMETERS toChilkatVFPImap AS [Chilkat_9_5_0.Imap]

LOCAL loImapEventHandler AS [ImapEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPImap AS [Imap OF Chilkat.VCX], loChilkatImap AS [Chilkat_9_5_0.Imap], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPImap = toChilkatVFPImap

STORE NULL TO loImapEventHandler, loChilkatImap

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPImap.Name]) == T_CHARACTER)

  loChilkatVFPImap = CREATEOBJECT([Imap])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

******************************
PROCEDURE MailManEventCallback
******************************

LPARAMETERS toChilkatVFPMailMan AS [Chilkat_9_5_0.MailMan]

LOCAL loMailManEventHandler AS [MailManEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPMailMan AS [MailMan OF Chilkat.VCX], ;
loChilkatMailMan AS [Chilkat_9_5_0.MailMan], ;
loChilkatVFPEventHandler AS [iMailManEventHandler OF Chilkat.VCX]

loChilkatVFPMailMan = toChilkatVFPMailMan

STORE NULL TO loMailManEventHandler, loChilkatMailMan

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPMailMan.Name]) == T_CHARACTER)

  loChilkatVFPMailMan = CREATEOBJECT([MailMan])

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

PROCEDURE _IChilkatMailManEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
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

PROCEDURE _IChilkatMailManEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatMailManEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**************************
PROCEDURE MhtEventCallback
**************************

LPARAMETERS toChilkatVFPMht AS [Chilkat_9_5_0.Mht]

LOCAL loMhtEventHandler AS [MhtEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPMht AS [Mht OF Chilkat.VCX], loChilkatMht AS [Chilkat_9_5_0.Mht], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPMht = toChilkatVFPMht

STORE NULL TO loMhtEventHandler, loChilkatMht

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPMht.Name]) == T_CHARACTER)

  loChilkatVFPMht = CREATEOBJECT([Mht])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

*****************************
PROCEDURE OAuth2EventCallback
*****************************

LPARAMETERS toChilkatVFPOAuth2 AS [Chilkat_9_5_0.OAuth2]

LOCAL loOAuth2EventHandler AS [OAuth2Events OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPOAuth2 AS [OAuth2 OF Chilkat.VCX], loChilkatOAuth2 AS [Chilkat_9_5_0.OAuth2], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPOAuth2 = toChilkatVFPOAuth2

STORE NULL TO loOAuth2EventHandler, loChilkatOAuth2

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPOAuth2.Name]) == T_CHARACTER)

  loChilkatVFPOAuth2 = CREATEOBJECT([OAuth2])

ENDIF (NOT TYPE([loChilkatVFPOAuth2.Name]) == T_CHARACTER)
** End didn't pass an object test

loOAuth2EventHandler = CREATEOBJECT([OAuth2Events])

WITH loChilkatVFPOAuth2 

  loChilkatOAuth2 = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatOAuth2, loOAuth2EventHandler)

DEFINE CLASS OAuth2Events AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.OAuth2"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**************************
PROCEDURE PemEventCallback
**************************

LPARAMETERS toChilkatVFPPem AS [Chilkat_9_5_0.Pem]

LOCAL loPemEventHandler AS [PemEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPPem AS [Pem OF Chilkat.VCX], loChilkatPem AS [Chilkat_9_5_0.Pem], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPPem = toChilkatVFPPem

STORE NULL TO loPemEventHandler, loChilkatPem

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPPem.Name]) == T_CHARACTER)

  loChilkatVFPPem = CREATEOBJECT([Pem])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

***************************
PROCEDURE RestEventCallback
***************************

LPARAMETERS toChilkatVFPRest AS [Chilkat_9_5_0.Rest]

LOCAL loRestEventHandler AS [RestEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPRest AS [Rest OF Chilkat.VCX], loChilkatRest AS [Chilkat_9_5_0.Rest], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPRest = toChilkatVFPRest

STORE NULL TO loRestEventHandler, loChilkatRest

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPRest.Name]) == T_CHARACTER)

  loChilkatVFPRest = CREATEOBJECT([Rest])

ENDIF (NOT TYPE([loChilkatVFPRest.Name]) == T_CHARACTER)
** End didn't pass an object test

loRestEventHandler = CREATEOBJECT([RestEvents])

WITH loChilkatVFPRest 

  loChilkatRest = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatRest, loRestEventHandler)

DEFINE CLASS RestEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Rest"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**************************
PROCEDURE RssEventCallback
**************************

LPARAMETERS toChilkatVFPRss AS [Chilkat_9_5_0.Rss]

LOCAL loRssEventHandler AS [RssEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPRss AS [Rss OF Chilkat.VCX], loChilkatRss AS [Chilkat_9_5_0.Rss], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPRss = toChilkatVFPRss

STORE NULL TO loRssEventHandler, loChilkatRss

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPRss.Name]) == T_CHARACTER)

  loChilkatVFPRss = CREATEOBJECT([Rss])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**************************
PROCEDURE ScpEventCallback
**************************

LPARAMETERS toChilkatVFPScp AS [Chilkat_9_5_0.Scp]

LOCAL loScpEventHandler AS [ScpEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPScp AS [Scp OF Chilkat.VCX], loChilkatScp AS [Chilkat_9_5_0.Scp], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPScp = toChilkatVFPScp

STORE NULL TO loScpEventHandler, loChilkatScp

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPScp.Name]) == T_CHARACTER)

  loChilkatVFPScp = CREATEOBJECT([Scp])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

***************************
PROCEDURE SFtpEventCallback
***************************

LPARAMETERS toChilkatVFPSFtp AS [Chilkat_9_5_0.SFtp]

LOCAL loSFtpEventHandler AS [SFtpEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPSFtp AS [SFtp OF Chilkat.VCX], loChilkatSFtp AS [Chilkat_9_5_0.SFtp], ;
loChilkatVFPEventHandler AS [iSFtpEventHandler OF Chilkat.VCX]

loChilkatVFPSFtp = toChilkatVFPSFtp

STORE NULL TO loSFtpEventHandler, loChilkatSFtp

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSFtp.Name]) == T_CHARACTER)

  loChilkatVFPSFtp = CREATEOBJECT([SFtp])

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

PROCEDURE _IChilkatSFtpEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatSFtpEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatSFtpEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatSFtpEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatSFtpEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

*****************************
PROCEDURE SocketEventCallback
*****************************

LPARAMETERS toChilkatVFPSocket AS [Chilkat_9_5_0.Socket]

LOCAL loSocketEventHandler AS [SocketEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPSocket AS [Socket OF Chilkat.VCX], ;
loChilkatSocket AS [Chilkat_9_5_0.Socket], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPSocket = toChilkatVFPSocket

STORE NULL TO loSocketEventHandler, loChilkatSocket

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSocket.Name]) == T_CHARACTER)

  loChilkatVFPSocket = CREATEOBJECT([Socket])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

*****************************
PROCEDURE SpiderEventCallback
*****************************

LPARAMETERS toChilkatVFPSpider AS [Chilkat_9_5_0.Spider]

LOCAL loSpiderEventHandler AS [SpiderEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPSpider AS [Spider OF Chilkat.VCX], ;
loChilkatSpider AS [Chilkat_9_5_0.Spider], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPSpider = toChilkatVFPSpider

STORE NULL TO loSpiderEventHandler, loChilkatSpider

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSpider.Name]) == T_CHARACTER)

  loChilkatVFPSpider = CREATEOBJECT([Spider])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**************************
PROCEDURE SshEventCallback
**************************

LPARAMETERS toChilkatVFPSsh AS [Chilkat_9_5_0.Ssh]

LOCAL loSshEventHandler AS [SshEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPSsh AS [Ssh OF Chilkat.VCX], loChilkatSsh AS [Chilkat_9_5_0.Ssh], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPSsh = toChilkatVFPSsh

STORE NULL TO loSshEventHandler, loChilkatSsh

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSsh.Name]) == T_CHARACTER)

  loChilkatVFPSsh = CREATEOBJECT([Ssh])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

********************************
PROCEDURE SshTunnelEventCallback
********************************

LPARAMETERS toChilkatVFPSshTunnel AS [Chilkat_9_5_0.SshTunnel]

LOCAL loSshTunnelEventHandler AS [SshTunnelEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPSshTunnel AS [SshTunnel OF Chilkat.VCX], ;
loChilkatSshTunnel AS [Chilkat_9_5_0.SshTunnel], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPSshTunnel = toChilkatVFPSshTunnel

STORE NULL TO loSshTunnelEventHandler, loChilkatSshTunnel

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPSshTunnel.Name]) == T_CHARACTER)

  loChilkatVFPSshTunnel = CREATEOBJECT([SshTunnel])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**************************
PROCEDURE TarEventCallback
**************************

LPARAMETERS toChilkatVFPTar AS [Chilkat_9_5_0.Tar]

LOCAL loTarEventHandler AS [TarEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPTar AS [Tar OF Chilkat.VCX], loChilkatTar AS [Chilkat_9_5_0.Tar], ;
loChilkatVFPEventHandler AS [iTarEventHandler OF Chilkat.VCX]

loChilkatVFPTar = toChilkatVFPTar

STORE NULL TO loTarEventHandler, loChilkatTar

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPTar.Name]) == T_CHARACTER)

  loChilkatVFPTar = CREATEOBJECT([Tar])

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

PROCEDURE _IChilkatTarEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
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

PROCEDURE _IChilkatTarEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatTarEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

***************************
PROCEDURE TaskEventCallback
***************************

LPARAMETERS toChilkatVFPTask AS [Chilkat_9_5_0.Task]

LOCAL loTaskEventHandler AS [TaskEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPTask AS [Task OF Chilkat.VCX], loChilkatTask AS [Chilkat_9_5_0.Task], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPTask = toChilkatVFPTask

STORE NULL TO loTaskEventHandler, loChilkatTask

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPTask.Name]) == T_CHARACTER)

  loChilkatVFPTask = CREATEOBJECT([Task])

ENDIF (NOT TYPE([loChilkatVFPTask.Name]) == T_CHARACTER)
** End didn't pass an object test

loTaskEventHandler = CREATEOBJECT([TaskEvents])

WITH loChilkatVFPTask 

  loChilkatTask = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatTask, loTaskEventHandler)

DEFINE CLASS TaskEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.Task"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

********************************
PROCEDURE TaskChainEventCallback
********************************

LPARAMETERS toChilkatVFPTaskChain AS [Chilkat_9_5_0.TaskChain]

LOCAL loTaskChainEventHandler AS [TaskChainEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPTaskChain AS [TaskChain OF Chilkat.VCX], ;
loChilkatTaskChain AS [Chilkat_9_5_0.TaskChain], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPTaskChain = toChilkatVFPTaskChain

STORE NULL TO loTaskChainEventHandler, loChilkatTaskChain

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPTaskChain.Name]) == T_CHARACTER)

  loChilkatVFPTaskChain = CREATEOBJECT([TaskChain])

ENDIF (NOT TYPE([loChilkatVFPTaskChain.Name]) == T_CHARACTER)
** End didn't pass an object test

loTaskChainEventHandler = CREATEOBJECT([TaskChainEvents])

WITH loChilkatVFPTaskChain 

  loChilkatTaskChain = .oChilkat
  loChilkatVFPEventHandler = .oEventHandler

ENDWITH

EVENTHANDLER(loChilkatTaskChain, loTaskChainEventHandler)

DEFINE CLASS TaskChainEvents AS SESSION OLEPUBLIC
IMPLEMENTS _IChilkatEvents IN "Chilkat_9_5_0.TaskChain"

PROCEDURE _IChilkatEvents_AbortCheck(tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.AbortCheck(tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

***********************************
PROCEDURE TrustedRootsEventCallback
***********************************

LPARAMETERS toChilkatVFPTrustedRoots AS [Chilkat_9_5_0.TrustedRoots]

LOCAL loTrustedRootsEventHandler AS [TrustedRootsEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPTrustedRoots AS [TrustedRoots OF Chilkat.VCX], ;
loChilkatTrustedRoots AS [Chilkat_9_5_0.TrustedRoots], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPTrustedRoots = toChilkatVFPTrustedRoots

STORE NULL TO loTrustedRootsEventHandler, loChilkatTrustedRoots

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPTrustedRoots.Name]) == T_CHARACTER)

  loChilkatVFPTrustedRoots = CREATEOBJECT([TrustedRoots])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

***********************************
PROCEDURE UnixCompressEventCallback
***********************************

LPARAMETERS toChilkatVFPUnixCompress AS [Chilkat_9_5_0.UnixCompress]

LOCAL loUnixCompressEventHandler AS [UnixCompressEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPUnixCompress AS [UnixCompress OF Chilkat.VCX], ;
loChilkatUnixCompress AS [Chilkat_9_5_0.UnixCompress], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPUnixCompress = toChilkatVFPUnixCompress

STORE NULL TO loUnixCompressEventHandler, loChilkatUnixCompress

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPUnixCompress.Name]) == T_CHARACTER)

  loChilkatVFPUnixCompress = CREATEOBJECT([UnixCompress])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

*****************************
PROCEDURE UploadEventCallback
*****************************

LPARAMETERS toChilkatVFPUpload AS [Chilkat_9_5_0.Upload]

LOCAL loUploadEventHandler AS [UploadEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPUpload AS [Upload OF Chilkat.VCX], ;
loChilkatUpload AS [Chilkat_9_5_0.Upload], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPUpload = toChilkatVFPUpload

STORE NULL TO loUploadEventHandler, loChilkatUpload

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPUpload.Name]) == T_CHARACTER)

  loChilkatVFPUpload = CREATEOBJECT([Upload])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

**************************
PROCEDURE ZipEventCallback
**************************

LPARAMETERS toChilkatVFPZip AS [Chilkat_9_5_0.Zip]

LOCAL loZipEventHandler AS [ZipEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPZip AS [Zip OF Chilkat.VCX], loChilkatZip AS [Chilkat_9_5_0.Zip], ;
loChilkatVFPEventHandler AS [iZipEventHandler OF Chilkat.VCX]

loChilkatVFPZip = toChilkatVFPZip

STORE NULL TO loZipEventHandler, loChilkatZip

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPZip.Name]) == T_CHARACTER)

  loChilkatVFPZip = CREATEOBJECT([Zip])

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

PROCEDURE _IChilkatZipEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
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

PROCEDURE _IChilkatZipEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatZipEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
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

LPARAMETERS toChilkatVFPZipCrc AS [Chilkat_9_5_0.ZipCrc]

LOCAL loZipCrcEventHandler AS [ZipCrcEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPZipCrc AS [ZipCrc OF Chilkat.VCX], ;
loChilkatZipCrc AS [Chilkat_9_5_0.ZipCrc], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPZipCrc = toChilkatVFPZipCrc

STORE NULL TO loZipCrcEventHandler, loChilkatZipCrc

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPZipCrc.Name]) == T_CHARACTER)

  loChilkatVFPZipCrc = CREATEOBJECT([ZipCrc])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE

*******************************
PROCEDURE ZipEntryEventCallback
*******************************

LPARAMETERS toChilkatVFPZipEntry AS [Chilkat_9_5_0.ZipEntry]

LOCAL loZipEntryEventHandler AS [ZipEntryEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPZipEntry AS [ZipEntry OF Chilkat.VCX], ;
loChilkatZipEntry AS [Chilkat_9_5_0.ZipEntry], ;
loChilkatVFPEventHandler AS [iBaseEventHandler OF Chilkat.VCX]

loChilkatVFPZipEntry = toChilkatVFPZipEntry

STORE NULL TO loZipEntryEventHandler, loChilkatZipEntry

DO ChilkatVFPEventCallbackSetup

** Didn't pass an object test
IF (NOT TYPE([loChilkatVFPZipEntry.Name]) == T_CHARACTER)

  loChilkatVFPZipEntry = CREATEOBJECT([ZipEntry])

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

PROCEDURE _IChilkatEvents_BinaryData(tqData AS VarBinary)
RETURN loChilkatVFPEventHandler.BinaryData(tqData)
ENDPROC

PROCEDURE _IChilkatEvents_PercentDone(tiPercentDone AS Integer, tiAbort AS Integer)
RETURN loChilkatVFPEventHandler.PercentDone(tiPercentDone, tiAbort)
ENDPROC

PROCEDURE _IChilkatEvents_ProgressInfo(tcName AS Character, tcValue AS Character)
RETURN loChilkatVFPEventHandler.ProgressInfo(tcName, tcValue)
ENDPROC

PROCEDURE _IChilkatEvents_TaskCompleted(toTask AS [Chilkat_9_5_0.Task])
RETURN loChilkatVFPEventHandler.TaskCompleted(toTask)
ENDPROC

PROCEDURE _IChilkatEvents_TextData(tcData AS Character)
RETURN loChilkatVFPEventHandler.TextData(tcData)
ENDPROC

ENDDEFINE