
## History

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

