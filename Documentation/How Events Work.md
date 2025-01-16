# How Events Work #

Well, events (Chilkat calls them event callbacks) are an obscure subject. Have you used the IMPLEMENTS clause of the DEFINE CLASS command? If you have, go to the head of the class. Until this ChilkatVFP project I can't come up with an instance where I've actually used it on my own. Oh, I'm sure I've tested canned samples using IMPLEMENTS but the whole process seems brittle and hard to support.

Events are the "dusty attic" portion of both Visual Foxpro and Chilkat - seemingly, visited once and then forgotten. The documentation for the first implementation of Chilkat events is fairly good, but anything after that first implementation is almost completely undocumented. As mentioned above, the Visual Foxpro side is brittle - either the class definition is done perfectly and it binds...or else it won't bind. And that's just the binding, we haven't done anything with it.

From the Visual Foxpro help file: "When you use the IMPLEMENTS clause, you must include all methods of that interface in the class definition. You must use the interface name exactly as it appears in the type library." In other words, if the COM library changes in any fashion, your support code changes. That's not so bad...unless and until you have to support multiple versions, then things get ugly.

Anyway, enough of that. 

The idea is quite cool in theory. Something happens in a COM object and the COM object raises an event. You as the developer can tap into that event call to add your code to do something special. Think of things like uploading or downloading a file, connecting to a web site, processing email, etc. You can do custom handling depending on the name of the file or who sends an email, the sky is the limit. And you get the event call right as it occurs.

## A Four-Legged Stool ##

To visualize the process, think of ChilkatVFP event support as a four-legged stool with one of the legs being slightly rickety. We'll start with the solid legs first, then get to the rickety one.

## ChilkatEventCallbacks.PRG

Events are supported within ChilkatVFP through ChilkatEventCallbacks.PRG. Let's work through an example.

<pre><code class="language-html">
*****************************
PROCEDURE SpiderEventCallback
*****************************

LPARAMETERS toChilkatVFPSpider AS [Chilkat_9_5_0.Spider]

LOCAL loSpiderEventHandler AS [SpiderEvents OF ChilkatVFPEventCallbacks.PRG], ;
loChilkatVFPSpider AS [Spider of Chilkat.VCX], ;
loChilkatSpider AS [Chilkat_9_5_0.Spider]

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
</code></pre>

It's hard to know where to start but the first thing I notice is when I go to the Chilkat Spider ActiveX page and go to the bottom, there are only three events listed. If I just used those for the definition, it wouldn't bind. BinaryData and TextData came in version 58 and are unused at the moment. You still need those definitions but there's still an other one to worry about. What to do?

The Object Browser is your friend for this subject matter. I'm much more of a Class Browser user than I am an Object Browser user, but in this case the Object Browser is absolutely, hands-down **the** tool to use. Even when Chilkat documents everything you should always reference the Object Browser and use it as the source you can trust - there's issues with the Chilkat event documentation.

![Object Browser](Images/Object%20Browser.jpg)

Hey! There's six methods, not three! And I have the parameter definitions! 

This is where you want to play.

So back to the Spider example...

A ChilkatVFP Spider object is passed in via parameter (Yeah, there's a way to create this without passing in an object, but you don't end up with a reference to the object created in the method.) The Chilkat object to bind is contained in the .oChilkat property of the passed ChilkatVFP object. The event handler object (**loSpiderEventHandler**) is a subclassed VFP Session object IMPLEMENTed to exactly match the exposed COM events of the Chilkat Spider object. 

There is also a ChilkatVFP event handler object. The methods contained within the IMPLEMENTed event handler object point back to the Chilkat event handler object passed in as a member of the ChilkatVFP Spider object.

The advantage of this three object dance is the code to handle the event is contained with the specific ChilkatVFP event handler object and not in the SpiderEvents session object.

So to recap - ChilkatVFP comes out of the box with an event binding definition. Let's call this a solid third leg of the stool. And there's nothing for you to do. But it's not clear how to use it, let alone implement it.

## Event Handling in Chilkat Objects ## 

There are several ChilkatVFP properties used to support event handling.

| Method | Purpose                        |
|--------|--------------------------------|
|cEventHandlerClass| The class name of the event handler, if relevant.|
oEventHandler| Object property used to hold a reference to the Chilkat event handler, if relevant. |
lAddEventHandler| Logical property used to determine if the Chilkat object (oChilkat) will add an event handler, if relevant. |

As part of the class definition, the cEventHandlerClass property of the Spider object is set to "iBaseEventHandler".

Here's how to set up event handling:

<pre><code class="language-html">
loSpider = NEWOBJECT([Spider]) && assumes Set([Classlib]) is set to ChilkatVFP
loSpider.lAddEventHandler = .T.
</code></pre>
 
That is it!

Setting lAddEventHandler to true for the ChilkatVFP object will populate the oEventHandler object property via the class name referenced in the cEventHandlerClass property. The appropriate procedure in the ChilkatEventCallbacks.PRG (in this case SpiderEventCallback) is called with itself as the passed reference object and put into memory. 

Continuing with the stool analogy, this is a pretty straightforward and stable first leg of the stool.

We've instantiated the object and set one property to do all the event binding. As mentioned, the iBaseEventHandler class is the event handler for the Spider object. The iBaseEventHandler class is just an empty class for your fixes and enhancements; the BaseEventHandler is where the action is. Open the BaseEventHandler class and what do you see? The method names AbortCheck, BinaryData, PercentDone, ProgressInfo, TaskCompleted and TextData methods, the methods referenced in the IMPLEMENTS _IChilkatEvents within the SpiderEventCallback procedure.

There are more methods than that in the BaseEventHandler class. These six methods are "hooked" so that you have the flexibility of four support methods. More on that later. 

To continue the analogy, this is the fourth leg of the stool.

## Implementation ##

If you've made it this far, we've put all the other pieces in place. But what we haven't done is the actual implementation - what specific thing are we trying to do?

Your implementation is the implementation done through ChilkatVFP. You're uploading a file, visiting a web site, running a Chilkat Task, whatever. It's the communication between your implementation and the specific procedure (in the ongoing example, SpiderEventCallback) that's unlike anything else in Visual Foxpro. It's both fragile and a little odd (I don't want to get off the subject but I've run into two clear VFP 9 compilation bugs with the IMPLEMENTS clause) to use. 

If you scroll up to the SpiderEventCallback code, we've put this procedure in memory when setting the lEventHandler property of the ChilkatVFP object to true. This class in memory is a self-contained VFP Session object (by definition with its' own DataSession) with specific references to call a loChilkatEventHandler object. To make the handoff to the SpiderEventCallback procedure, get a reference to the oEventHandler object of the class and name it <ins>**loChilkatEventHandler**</ins> - just like what's in the procedure. And the variable must be declared PRIVATE so the SpiderEventCallback procedure can "see" the variable (I do not recommend declaring it PUBLIC for a number of reasons, and LOCAL won't work) -- even though the variable is declared LOCAL within the procedure itself.

I didn't say it made sense...

Some code....

<pre><code class="language-html">
# INCLUDE [Foxpro.H]
# DEFINE SpiderCache    [C:\SpiderCache]

CLEAR ALL
CLOSE ALL

LOCAL loSpider AS [Spider OF Chilkat.VCX], loSeenDomains AS [StringArray OF Chilkat.VCX], ;
loSeedURLs AS [StringArray OF Chilkat.VCX], liCount AS Integer, lcURL AS Character, ;
lcDomain AS Character, li AS Integer, llSuccess AS Logical, ;
liOutboundLinks AS Integer, lcBaseDomain AS Character

*!*  LOCAL loChilkatVFPEventHandler 
PRIVATE loChilkatVFPEventHandler 

STORE NULL TO loSpider, loSeenDomains, loSeedURLs
STORE [] TO lcURL, lcDomain, lcBaseDomain
STORE 0 TO liCount, li, liOutboundLinks

llSuccess = .F.

SET CLASSLIB TO [Chilkat.VCX] ADDITIVE
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

llOKToContinue = llSpiderObject AND llSeenDomainsObject AND llSeedURLsObject

** Okay to continue test
IF llOKToContinue 

  WITH loSeedURLs

    .Unique = 1
    .Append([https://www.joelonsoftware.com/])
    liCount = .Count

  ENDWITH

  loSeenDomains.Unique = 1

  WITH loSpider

    STORE .T. TO .lReturnBitAsLogical, .FetchFromCache, .UpdateCache
    .CacheDir = SpiderCache
    .lAddEventHandler = .T.
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
      IF loSeenDomains.Contains(lcBaseDomain) = 0

        WITH loSeedURLs

          ** Add to list test
          IF .Count < 1000

            .Append(lcURL)

          ENDIF .Count < 1000
          ** End add to list test

        ENDWITH

      ENDIF loSeenDomains.Contains(lcBaseDomain) = 0
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

RETURN
</code></pre>

This is the code for SpiderTest.Prg. I don't want to get in too deep with the details but some explanation is justified. Spidertest.Prg does, well, web spidering. It grabs a web site and starts crawling. The key to this program is the artificial use of the HeartbeatMs property and the SleepMs methods of the Spider object. The SleepMs causes an unnecessary one second delay while the HeartbeatMs property sets the abort check to a half second.

To set it up, set the SpiderCache to an empty directory, then run the program. You should see 5 URLs on screen and have 5 files in the cache directory. Nothing special.

Delete the files in the cache directory (If you wish, set it up so you can see both Visual Foxpro and the cache directory at the same time). Open up the Class Browser, navigate to the BaseEventHandler and the AbortCheck method. Inside the method is a commented out line that begins with a question mark - remove the comment from that line and save the changes to the BaseEventHandler class. Now run it again.

You were firing events the whole time!

If you don't believe me, add the same type of message to the AbortCheck_Pre, AbortCheck_Post and the AbortCheck_Process methods of the BaseEventHandler class, clear the cache once again and run it. More messages appear.

Again, delete the files in the cache directory. Only this time, modify the SpiderTest.PRG -- comment out the PRIVATE line and remove the comment from the LOCAL line above it. Run it.

The events don't fire.

Why does it work this way? You can't see me right now but I'm looking left, then right, then respond to you in a whisper...I don't know. What you do need to know is that because of the way the SpiderEventCallback procedure is written is must be named loChilkatVFPEventHandler and the variable must be PRIVATE. Not PUBLIC, not LOCAL, PRIVATE. 

This is the rickety second leg of the stool.

But it works.

### Recap ###

1) Setting the lEventHandler property to true for a ChilkatVFP object that supports events will put the appropriate event callback method into memory.

2) That event callback method will make a call back to a method within the EventHandler (.oEventHandler) that was loaded when the ChilkatVFP object was set to true.

3) Your implementation will cause the events to fire and if set up correctly, the communication between all the relevant objects will work.

## You've reached Shangri-La! ##

If you have the BaseEventHandler class in your call stack, you've made it to Shangri-La! A whole world of possibilities have opened up for you!

As the time of this writing, Chilkat has 103 classes. ~~33~~ 35 of these classes contain events. This event handler class is the base handler for 27 of those ~~33~~ 35 classes. The other six classes subclass from this base event handler and have even more events.

Note that for each Chilkat event there are four supporting methods in the event handler. For each Chilkat [*event*] there is a corresponding Event Handler [*event*], [*event name*]_pre, [*event name*]_process and [*event name*]_post methods. The event handler methods are "hooked". 

For reference, please read Steven Black's seminal work about the subject here: <a href="http://stevenblack.com/articles/hooks-and-anchors/" target="_blank">http://stevenblack.com/articles/hooks-and-anchors/</a>

My flippant three word comment on Steve's article - "Too much granola". But that is the point - sure, I can't digest it all at once, but it makes me think differently, think in more abstractions, think more like an engineer and less like just a programmer. It's an article way ahead of its time (originally written around 1997). 

Through the years I've used a similar hook concept used by the Visual Fox Express framework described below.

The four event handler classes can be used (or for that matter, ignored) any way you want. The intent is thus: 

| Method | Purpose                        |
|--------|--------------------------------|
|*event*| The "manager" of the support event methods. |
|*event*_pre| A pre-processing method. You can set up the environment, ensure you have everything you need.  |
|*event*_process| The "work" is done in this method. |
|*event*_post| A post-processing method to update the environment as necessary. |

Think of the _pre method as a Textbox **When** method and the _post method as a Textbox **LostFocus** method and you wouldn't be far off at all. 

Do your setup in the _pre method (Do I have a file? Is the directory good? Did the user provide an option? Etc.). 
Do your "real work", the intent, in the _process method.
If the "work" is done successfully, call the _post method to "report" the success, update statistics, etc.

OK, but why? Think of every decision point within your hook. Can that decision point be its' own hook? And so on. Thinking in hooks and how to put the pieces together becomes an assemblage of Lego blocks or Tinkertoys, ripe for reuse. See? Shangri-La is a fun place to be!

#### Contact: chilkatVFP at gmail dot com.
