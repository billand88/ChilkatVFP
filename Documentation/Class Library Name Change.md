# Class Library Name Change  

Have you heard the saying "It's what you learn after you know it all that counts?". That appears to be a saying from former legendary UCLA basketball coach John Wooden. Well, it applies here.

Chilkat put out a version 10 in oh, say, late September 2024 and I began to work on supporting the change. Prior to Version 10, calling a Chilkat object directly from Visual Foxpro looks like this:

#### xx = NEWOBJECT([Chilkat_9_5_0.Email])

Starting in Version 11, the syntax will exclusively look like this:

#### xx = NEWOBJECT([Chilkat.Email])

Version 10 will support both formats and in Version 11, the older naming mechanism will be dropped.

OK, fine and dandy. I have some work to do.

In attempting to implement, I kept blowing the call stack, falling into some sort of infinite loop. Hmmmm, it wasn't doing that before, must be some rogue code...but I can't find it. So I dropped it for a while and went back to other things.

When I got back to it...same thing. So at a certain point where I'm fishing for a Chilkat object to instantiate to grab the version number, I attempted to save/clear out/restore the SET([Classlib]) setting. Only that didn't work either, because of something I forgot or didn't know about - the SET([Classlib]) setting has an ALIAS clause that gets tacked on after each VCX. That made the restoration a problem using the macro command.

Now I'm stuck. I implement other Version 10 things, but I can't get around this issue. And if I can't fix it, ChilkatVFP is broken. Somehow, VFP is reloading the Email object stack over and over and over again.

So I set it down. I kind of chewed on the fact of "why is there an ALIAS clause for a class library and when did this clause come in?" Frankly I was more interested in the "why" versus the "when" but moved on to other things.

Weeks later I stewed on it some more (mind you, this is the straight line to the resolution, not the winding garden path I really took...) and decided the ALIAS clause must be related to what VFP does internally, opening the VCX as a DBF and using the ALIAS clause to keep track of it...though what happens if two class libraries with the same name are used coming from different directories? Is that why the ALIAS clause exists?

At some point things clicked, like stewing on it in the shower or something. 

Here's the story: As mentioned above, the new syntax is 

#### xx = NEWOBJECT([Chilkat.Email])

Part of the process of putting the actual CREATEOBJECT or NEWOBJECT function is to simply put all the pieces together in one statement. There's the prefix (either now "Chilkat_9_5_0" or "Chilkat"), the dot separator, and the name of the class. Slap all that together and you get something like "Chilkat_9_5_0.Email". The problem is with the new Chilkat syntax at run time. Attempting a NEWOBJECT([Chilkat.Email]) doesn't run Chilkat's email object, it runs VFP's Email object. And since by definition an OLE object such as Chilkat is the the last path to search, there's nothing I can do to fix that with the class library having the same name as the OLE prefix.

Or in other words, try this: 

### SET CLASSLIB TO ChilkatVFP ALIAS Chikat

...and then instantiate the ChilkatVFP's email object. It's not pretty.