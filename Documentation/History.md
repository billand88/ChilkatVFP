 History

## Version 1.41

*Released 01/19/2025*

This is a bug fix version of the prior 1.40 release. Version 1.40 was a large, large release.

I ran the SpiderTest.PRG after releasing 1.40 and it didn't work. In looking, the BaseChilkat lAddEventHandler_Assign method had a note I put in that the method needed to be updated. It wasn't updated.

Fixed/adjusted for this version:

   1) Events can be set again.
   2) An additional CallBack*.PRG was added in 1.40, but never called. Fixed.
   3) Secrets class added to the list of Chilkat objects that can have an event handler.
   4) Removed the three depcrecated properties/methods from the BaseChilkat class. Went through the framework to remove all references. At least two classes (One of them HTTPRequest) couldn't instantiate in version 1.40 without this fix.
   5) Added m. (m dot) prefixes to the BaseEventHandler class and subclasses.
   6) Other random fixes.

## Version 1.40

*Released 01/14/2025*

Well, Chilkat is changing and ChilkatVFP needs to follow suit. 

First off: It turns out I need to change the name of the main library from Chilkat.VCX to ChilkatVFP.VCX. The reason why is explained in this [document](Class%20Library%20Name%20Change.md).

Chilkat is changing how they do versioning. The Chilkat objects for version 99 would return "9.5.0.xx" where "xx" represented the version for the Version property. Starting with the *next* Chilkat version, Chilkat will return xx.yy.zz where "xx" represents the major version, "yy" represents the minor version, and "zz" represents a patch version. As I write this, the Version property returns "10.0.0".

Not only is the major version in the front and not at the end, Chilkat 1.34 had no concept of major or minor versions. There was only "version" at the end, the rest was static.

Chilkat will support both naming conventions for version 10 only. Starting with version 11.0.0, the old naming convention will be dropped. But ChilkatVFP needs to support both.

The other permutation is it will break Events. Or better stated, there needs to be a separate set of Chilkat Event classes that support version 11.0.0 and above. The Chilkat COM definition has changed.

--

The internal mechanism for testing versioning has had to change with the version format change. To support this, there is a new Versioning object to do the appropriate calculations. Some of the methods contained in the BaseChilkat class have moved to the Versioning object.

--

Added new Secrets class arriving in Chilkat version 10.1.0. 

Added the ability to support Chilkat class retirements coming in version 11. Added a MsgSvc record pertaining to class retirements.

Changed all source code to support the new versioning.

Found two classes that didn't get the "m." prefix for variables as described in Version 1.31 changes as well as other random missed methods.

## Version 1.34
*Released 07/10/2024*

Chilkat version 99 compatibility release.

Also added the enhancement/bug fix notes in the method documentation to the associated *ASync method if such a method existed.

## Version 1.33
*Released 04/04/2024*

The last big change I had to work on was a true integration of MsgSvc. This involved minor modifications of MsgSvc, now named ChMsgSvc. So the MsgSvc program will be deprecated and replaced with ChMsgSvc.PRG.

There's a new instance class property called **cMsgSvcLanguage**. This property references the MsgSvc.DBF field to retrieve for message displays. The default value is "Original", pointing to the MsgSvc.cOriginal field (English). Other supported values are "French", "Spanish", "German" and "Test". 
For my international users, please let me know if the translations work for you. If you would like me to add a language or fix translations, please send me an email at chilkatvfp@gmail.com.

There is Chilkat version 98 support. This appears to be more of a Chilkat bug fix version. I can only find two new properties in this version, and no new methods (there are several new UncommonOptions clauses). One of them - CodeSign.HeartBeatMs - I recommended to ChilkatSoft.

There is a new document in the Documentation folder, "Using the Chilkat Class Library". This document goes over some solutions for implementing a language change within ChilkatVFP. 

## Version 1.32
*Released 02/13/2024*

Added Version 97 compatibility (Version 97 was released on 01/31/2024) such as the new CodeSign class. Fixed code bugs and documentation bugs when I ran into them (For instance, the DNS.cChilkatClass property was incorrectly set; there were a couple methods with "...**En**code..." in the Chilkat method name, but the VFP code indicated "...Code...""). 

The LogicalToBit method was fixed.

Added lots of documentation within the instance classes. 

Added the ChilkatChangeLog method to all instance classes to serve as historical documentation. Cross referenced all the Chilkat release notes to their affected individual classes.

## Version 1.31
*Released 01/20/2024*

The change file generated by FoxBin2PRG will be enormous because...

Based on Rick Schummer's session at Southwest Fox October 2023, I added "m." (mdots) to all the memory variables within Chilkat.VCX where necessary. That took a while.

Tweaked the copyright notice in the header to span multiple years.

In other words, every method changed.

Other items:

ChilkatVFP is more solid due to Tamar Granor's research. The StringTable, BinData and IMAP classes didn't even compile cleanly. The SFTP event handling within the three ChilkatVFPEventCallbacks programs didn't have the extended events. And if *anything* is wrong, it's broken. All fixed. Thank you Tamar! 

Added two Chilkat version 97 properties to ChilkatVFP - that doesn't help right now because we're on version 96 - but they're in there.

## Version 1.3
*Released 11/15/2023*

Completed version 96 compatibility changes. Version 96 is a pretty big release.

This update includes the new DNS/iDNS classes in Chilkat.VCX/iChilkat.VCX. ChilkatVFPEventCallbacks.PRG gets three new event procedures. The new DNS class has Chilkat events, what about the other two? Cert and PrivateKey now have events (and Async() methods) starting in Chilkat version 96. But take note of that: Cert and PrivateKey classes do not have events prior to version 96. ChilkatVFP handles this distinction during event handling validation.

As always, there's fixes and enhancements to the documentation. For instance, this update adds missing copyright notices in the documentation (not very exciting, I know). 

Found about a dozen or so missing ChilkatVFP methods and properties between Chilkat versions 90 - 95. Turns out Chilkat's release notes will miss a few things.

Some minor bug fixes done when stumbling around in the code.

I'm told that some suggestions of mine will make the version 97 code base.

## Version 1.24
*Released 10/13/2023*

Found several additional Chilkat classes that lacked a Version property (and thereby couldn't instantiate correctly in ChilkatVFP). 

Added a TaskDownloadTest program to demonstrate very basic tasking. Adjusted some example programs to use iChilkat.VCX. Minor documentation fixes. 

## Version 1.23
*Released 08/24/2023*

Finished off compatibility changes for Chilkat version 95. Added one version 96 method.

## Version 1.22
*Released 07/18/2023*

Minor update.

Added iChilkat.VCT/VCX which subclasses the iBaseChilkat instance classes. Use these to instantiate your ChilkatVFP Chilkat classes in code. 

The cEventHandler class was set incorrectly for several classes. A few version 95 methods were added (but as I type we're in Chilkat version 94). The SpiderTest program was updated. I found an empty method and added the appropriate code, etc.

## Version 1.21
*Released 04/19/2023*

Chilkat version 94 compatibility and a couple of minor fixes.

## Version 1.2

Enhancement: You can now pass a ChilkatVFP object as an object parameter to a ChilkatVFP method. The associated Chilkat object will be passed to the Chilkat method and reattached to the ChilkatVFP object upon method return.

Bug Fix/Enhancement: In code, calling properties (and presumably methods) before their implementation would simply fail (which is what should happen since the Chilkat object doesn't have it yet). Now you are told why it failed.

You can see the fix if you add one of the two new version 94 OAuth2 properties in code (the current release is version 93)...

Both of the above enhancements required diving into the code for each ChilkatVFP object. A lot of other side issues were addressed. To implement the first enhancement, the object naming conventions got more consistent, but there were a few cases where the ChilkatVFP parameter didn't match the parameter name going to Chilkat. For the second enhancement, the implementation value for the common Last* properties were set consistently. Previously, if the value was set too low it usually didn't matter, but in some cases it was clearly set too high (copy/paste errors).

## Version 1.11

Bug fix version.

The onus for the change is the developer could not instantiate the BinData or the StringBuilder class due to the related Chilkat object not having a Version property. I needed to enhance/tweak/adjust about few methods in the BaseChilkat class. These include (from memory, could be faulty) The Init, Init_Post, Version_Access and the GetChilkatVersionObject methods.

I upgraded my internal Chilkat software to the latest and greatest, version 92. This brought in 5 new classes for me. More importantly, two of them had events that could be wrapped so ChilkatVFPEventCallbacks.PRG has been updated to reflect that.

## Version 1.1
*Released 11/04/2022*

Major enhancement - Added support for all Chilkat event callbacks. See <a href="D:/ChilKat/Documentation/How%20Events%20Work.md" target="_blank">How Events Work</a> for details.

Added the cEventHandlerClass, lAddEventHandler and oEventHandler properties to the BaseChilkat class. Added the BaseEventHandler class and about a dozen subclasses to support Chilkat event callbacks.

ChilkatVFPEventCallbacks.PRG, ChilkatVFPEventCallbacksPreV52.PRG and ChilkatVFPEventCallbacksPreV58.PRG are added to support Chilkat event callbacks. SpiderTest.PRG included as a Chilkat event implementation example.

A couple SleepMs methods were not working correctly are fixed in this version.

Added <a href="D:/ChilKat/Documentation/How%20Events%20Work.md" target="_blank">How Events Work</a> to document how ChilkatVFP supports Chilkat event callbacks.

A few Chilkat version 93 properties and methods were added.

## Version 1.01
*Released 10/16/2022*

Completed Chilkat version 92 compatibility.

Based on a version 92 behavior change (automatic cache clearing when doing an FTP connection), I researched prior release notes for behavior changes. A few more behavior changes were found.

Other enhancements are in the being worked on but are not included with this release.

## Version 1.0
*Released 09/18/2022*

This is the first release (1.0) of ChilkatVFP.

