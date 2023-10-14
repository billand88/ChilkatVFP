*==============================================================================
* Purpose:           TaskDownloadTest.PRG
* Author:            Bill Anderson
* Notice:            Copyright (c) 2023 The Anderson Files LLC, All Rights Reserved.
* Returns:           Logical, indicating success.
* Date Added:        09/27/2023
*==============================================================================

# INCLUDE [Foxpro.H]
# DEFINE kcFTPDownloadDir    [C:\FTPDownload]

CLEAR ALL
CLOSE ALL

LOCAL loFTP2 AS [iFTP2 OF iChilkat.VCX], loTaskChain AS [iTaskChain OF iChilkat.VCX], ;
lcUserName AS Character, lcPassword AS Character, llSuccess AS Logical, ;
llFTP2Object AS Logical, llTaskChainObject AS Logical, lcHostName AS Character, ;
loChilkatTask AS [Chilkat_9_5_0.Task], llMethodCallWorked

STORE NULL TO loFTP2, loTaskChain, loChilkatTask
STORE [] TO lcUserName, lcPassword, lcHostName
STORE .F. TO llSuccess, llFTP2Object, llTaskChainObject, llMethodCallWorked

lcHostName = [*************]
lcUserName = [************]
lcPassword = [***************]

** Alias not set test
IF NOT ([CHILKAT.VCX] $ UPPER(SET([CLASSLIB])))

  SET CLASSLIB TO [Chilkat.VCX] ADDITIVE

ENDIF NOT ([CHILKAT.VCX] $ UPPER(SET([CLASSLIB])))
** End alias not set test

** Alias not set test
IF NOT ([ICHILKAT.VCX] $ UPPER(SET([CLASSLIB])))

  SET CLASSLIB TO [iChilkat.VCX] ADDITIVE

ENDIF NOT ([ICHILKAT.VCX] $ UPPER(SET([CLASSLIB])))
** End alias not set test

CLEAR

loFTP2 = NEWOBJECT([iFTP2])
loTaskChain = NEWOBJECT([iTaskChain])

llFTP2Object = (TYPE([loFTP2.Name]) == T_CHARACTER)
llTaskChainObject = (TYPE([loTaskChain.Name]) == T_CHARACTER)

llOKToContinue = (llFTP2Object AND llTaskChainObject)

** Okay to continue test
IF llOKToContinue 

  WITH loFTP2

    .lReturnBitAsLogical = .T.
    .HostName = lcHostName
    .UserName = lcUserName
    .Password = lcPassword

    loChilkatTask = .ConnectOnlyAsync()

    llMethodCallWorked = .LastMethodSuccess

    ** Call worked test
    IF llMethodCallWorked

      loTaskChain.Append(loChilkatTask)

    ELSE

      llSuccess = .F.

    ENDIF llMethodCallWorked
    ** End call worked test

    ** Successful connection test
    IF llMethodCallWorked

      loChilkatTask = .LoginAfterConnectOnlyAsync()

      llMethodCallWorked = .LastMethodSuccess

      ** Call worked test
      IF llMethodCallWorked

       loTaskChain.Append(loChilkatTask)

      ELSE

        llSuccess = .F.

      ENDIF llMethodCallWorked
      ** End call worked test

      ** Successful connection test
      IF llMethodCallWorked

        loChilkatTask = .ChangeRemoteDirAsync([/Sessions])

        llMethodCallWorked = .LastMethodSuccess

        ** Call worked test
        IF llMethodCallWorked

          loTaskChain.Append(loChilkatTask)

        ELSE

          llSuccess = .F.

        ENDIF llMethodCallWorked
        ** End call worked test

        ** Successful connection test
        IF llMethodCallWorked

          loChilkatTask = .DownloadTreeAsync(kcFTPDownloadDir)

          llMethodCallWorked = .LastMethodSuccess

          ** Call worked test
          IF llMethodCallWorked

            loTaskChain.Append(loChilkatTask)

          ELSE

            llSuccess = .F.

          ENDIF llMethodCallWorked
          ** End call worked test

          ** Successful connection test
          IF llMethodCallWorked

            loChilkatTask = .DisconnectAsync()

            llMethodCallWorked = .LastMethodSuccess

            ** Call worked test
            IF llMethodCallWorked

              loTaskChain.Append(loChilkatTask)
  
              STORE .LastMethodSuccess TO llMethodCallWorked, llSuccess

            ENDIF llMethodCallWorked
            ** End call worked test

          ENDIF llMethodCallWorked
          ** End call worked test

        ENDIF llMethodCallWorked
        ** End call worked test

      ENDIF llMethodCallWorked
      ** End successful connection test

    ENDIF llMethodCallWorked
    ** End successful connection test

  ENDWITH
 
  ** Okay to continue test
  IF llSuccess

    WITH loTaskChain

     STORE .T. TO .lReturnBitAsLogical, .StopOnFailedTask

     .HeartbeatMs = (1000 * 60 * 5) && 5 minutes

     .Run()

    ENDWITH

  ENDIF llSuccess
  ** End okay to continue test

ENDIF llOKToContinue 
** End okay to continue test

** Have an FPT2 object test
IF llFTP2Object 

  loFTP2.Release()

ENDIF llFTP2Object
** End have an FPT2 object test

** Have a Task Chain object test
IF llTaskChainObject 

  loTaskChain.Release()

ENDIF llTaskChainObject 
** End have a Task Chain object test

STORE NULL TO loFTP2, loTaskChain, loChilkatTask

RETURN llSuccess