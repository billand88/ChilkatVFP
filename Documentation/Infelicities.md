## Infelicities

1) The Chilkat VFP library does not come with subclasses for the Chilkat named classes.
One day I made the 103 subclasses (now 106). The next day I looked at the ChilkatVFP class library in the class browser. I removed them. 
Somewhere else I describe it as "muddy". The VFP Class Browser gives a high-level overview of how things are structured, and these subclasses made it more difficult to see how the full class library was organized. (Note: Starting in version 1.22 there is an included iChilkatVFP.VCX which subclasses the ~~103~~ 106 ChilkatVFP instance classes.)

2) In some cases, the Chilkat documentation indicates a property or method exists when that is simply not the case. This doesn't happen often, but it's there. In this case I followed the documentation and added it. Some examples: SFTPDir and SFTPFile are both missing LastBinaryResult and LastStringResultLen for starters. Crypt2 is missing a lot of documented ASync methods. (Note: These are fixed in more recent versions of Chilkat.)

3) The Version property is missing for the Chilkat CkString, BinData, StringBuilder SecureString, ServerSentEvent, Mailboxex, MessageSet, URL, HashTable, SFTPDir and SFTPFile objects. I can see why it could be missing in the CkString class, a really old class. But there's no reason BinData and StringBuilder don't have the Version property. These are "active" classes. 

4) This is littered everywhere in the Chilkat on line documentation: If the non-asynchronous message came in after, say version 40 or so and is correctly documented as such, the related Async method would state it came in the same version. If the Async method is documented to be before version 52 it is wrong. The Async methods came as part of version 52. ChilkatVFP corrects this.

5) There are misspellings in the Chilkat documentation that are corrected in ChilkatVFP, though I can't recall a specific example.

6) Riffing on point 3, all Chilkat classes should have a Version class. CkString has a couple of methods that were added for version 52, how else can you test to see if you have a version that has these methods?

7) ~~SFTPDir and SFTPFile need cleanup. There's no point in adding a LastStringResult property and leave off the LastStringResultLen property. They are both documented to have it but they don't.~~

8) There are about a dozen total PEMs that say "To be documented soon." They won't be, but they should.

9) ~~There's plenty of examples whereby the class itself came after version 52 but the LastStringResult property (for example) would say it came in version 52. I generally left that alone. It's not accurate but it is harmless.~~ The documentation has been cleaned up in ChilkatVFP version 1.2.

10) Doing a PEMSTATUS([Chilkat Object], [PEM], 5) test against an existing Chilkat object method/property will probably work in the command window and in the debugger if the running program is stopped. But when running Visual Foxpro code it's not consistent at all when it works and when it doesn't.

11) There are issues with Chilkat events documentation. Some events are named differently, at least one event has an extra parameter, and at least one was missing. If you get into events (Chilkat calls it event callbacks), use the Visual Foxpro Object Browser as your reference. Normally missing a piece of documentation is not that big a deal. But Visual Foxpro must match the Chilkat COM definition ***exactly*** or the IMPLEMENTS binding will not work. One miss is as good as completely broken. The Object Browser is your friend.

#### Contact: chilkatVFP at gmail dot com.
