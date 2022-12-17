
## History
## Version 1.12
*Released 12/17/2022*

Finished version 93 compatibility and added a couple of version 94 properties.

## Version 1.11
*Released 11/26/2022*

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

