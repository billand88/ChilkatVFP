*==============================================================================
* Purpose:           SpiderTest.PRG
* Author:            Bill Anderson
* Notice:            Copyright (c) 2022 - 2025 The Anderson Files LLC, All Rights Reserved.
* Returns:           Logical, indicating success.
* Date Added:        11/03/2022
*==============================================================================

# INCLUDE [Foxpro.H]
# DEFINE kcSpiderCache    [C:\SpiderCache]

CLEAR ALL
CLOSE ALL

LOCAL loSpider AS [iSpider OF iChilkatVFP.VCX], loSeenDomains AS [iStringArray OF iChilkatVFP.VCX], ;
loSeedURLs AS [iStringArray OF iChilkatVFP.VCX], liCount AS Integer, lcURL AS Character, ;
lcDomain AS Character, li AS Integer, llSuccess AS Logical, ;
liOutboundLinks AS Integer, lcBaseDomain AS Character, llSpiderObject AS Logical, ;
llSeenDomainsObject AS Logical, llSeedURLsObject AS Logical

*!*  LOCAL loChilkatVFPEventHandler && doesn't work! 
PRIVATE loChilkatVFPEventHandler

STORE NULL TO loSpider, loSeenDomains, loSeedURLs, loChilkatVFPEventHandler
STORE [] TO lcURL, lcDomain, lcBaseDomain
STORE 0 TO liCount, li, liOutboundLinks
STORE .F. TO llSuccess, llSpiderObject, llSeenDomainsObject, llSeedURLsObject

** Alias not set test
IF NOT ([ChilkatVFP.VCX] $ UPPER(SET([CLASSLIB])))

  SET CLASSLIB TO [ChilkatVFP.VCX] ADDITIVE

ENDIF NOT ([ChilkatVFP.VCX] $ UPPER(SET([CLASSLIB])))
** End alias not set test

** Alias not set test
IF NOT ([iChilkatVFP.VCX] $ UPPER(SET([CLASSLIB])))

  SET CLASSLIB TO [iChilkatVFP.VCX] ADDITIVE

ENDIF NOT ([iChilkatVFP.VCX] $ UPPER(SET([CLASSLIB])))
** End alias not set test

CLEAR

**
** Go into the AbortCheck method of the BaseEventHandler.
** There is a line that begins with a question mark.
** Uncomment that line and save it.
**

loSpider = NEWOBJECT([Spider])
loSeenDomains = NEWOBJECT([StringArray])
loSeedURLs = NEWOBJECT([StringArray])

llSpiderObject = (TYPE([loSpider.Name]) == T_CHARACTER)
llSeenDomainsObject = (TYPE([loSeenDomains.Name]) == T_CHARACTER)
llSeedURLsObject = (TYPE([loSeedURLs.Name]) == T_CHARACTER)

llOKToContinue = (llSpiderObject AND llSeenDomainsObject AND llSeedURLsObject)
 
** Okay to continue test
IF llOKToContinue 

  WITH loSeedURLs

    STORE .T. TO .lReturnBitAsLogical, .Unique
    .Append([https://www.joelonsoftware.com/])
    liCount = .Count

  ENDWITH

  WITH loSeenDomains

    STORE .T. TO .lReturnBitAsLogical, .Unique

  ENDWITH

  WITH loSpider

    STORE .T. TO .lReturnBitAsLogical, .FetchFromCache, .UpdateCache, .lAddEventHandler

    .CacheDir = kcSpiderCache

    ** The line below is necessary for events to fire,
    ** even though it isn't referenced elsewhere in this program!
    loChilkatVFPEventHandler = .oEventHandler

    .HeartBeatMs = 500 && half second

    ** Walk through seed URLs loop
    DO WHILE liCount > 0

      lcURL = loSeedURLs.Pop()
      .Initialize(lcURL)

      lcDomain = .GetURLDomain(lcURL)
      loSeenDomains.Append(.GetBaseDomain(lcDomain))

      ** Stop at five URLs loop
      FOR li = 0 TO 4

        llSuccess = .CrawlNext()

        ** Got to next link test
        IF llSuccess
        
          ? .LastURL

          ** Not fetched from cache test
          IF NOT .LastFromCache

            .SleepMs(1000)
 
          ENDIF NOT .LastFromCache
          ** End not fetched from cache test

        ELSE

          EXIT

        ENDIF llSuccess
        ** End got to next link test

      ENDFOR li = 0 TO 4
      ** End stop at five URLs loop

      WITH loSeedURLs

        .Remove(lcURL)
        liCount = .Count

      ENDWITH

    ENDDO WHILE liCount > 0
    ** End walk through seed URLs loop

    liOutboundLinks = .NumOutboundLinks - 1

    ** Walk through outbound links loop
    FOR li = 0 TO liOutboundLinks

      lcURL = .GetOutboundLink(li)
      lcDomain = .GetURLDomain(lcURL)
      lcBaseDomain = .GetBaseDomain(lcDomain)

      ** Already spidered test
      IF NOT loSeenDomains.Contains(lcBaseDomain)

        WITH loSeedURLs

          ** Add to list test
          IF .Count < 1000

            .Append(lcURL)

          ENDIF .Count < 1000
          ** End add to list test

        ENDWITH

      ENDIF NOT loSeenDomains.Contains(lcBaseDomain)
      ** End already spidered test

    ENDFOR li = 0 TO liOutboundLinks
    ** End walk through outbound links loop

  ENDWITH
  ** End okay to continue test

ENDIF llOKToContinue 
** End okay to continue test

** Have a Spider object test
IF llSpiderObject 

  loSpider.Release()

ENDIF llSpiderObject
** End have a Spider object test

** Have a Seen Domains object test
IF llSeenDomainsObject 

  loSeenDomains.Release()

ENDIF llSeenDomainsObject
** End have a Seen Domains object test

** Have a Seed URLs object test
IF llSeedURLsObject  

  loSeedURLs.Release()

ENDIF llSeedURLsObject
** End have a Seed URLs object test

STORE NULL TO loSpider, loSeenDomains, loSeedURLs

RETURN llSuccess