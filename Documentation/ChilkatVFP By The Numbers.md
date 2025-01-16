## ChilkatVFP By The Numbers

This document is "navel gazing" more than anything. 

Chilkat is big. Very big. 

Writing the code to implement what I'm calling the ChilkatVFP instance classes - the classes that map to their associated Chilkat objects - took 7 months to complete. If you load ChilkatVFP in the Class Browser, the ChilkatVFP instance classes subclass from the iBaseChilkat class.

No, I didn't work on it every day but it was a lot of work. Whatever...it got done. The point here is recently I started to ask the question - how big is it really, and by definition, how big is ChilkatVFP to support it?

So one day I just wrote some code to tease this out.

Note that the totals are somewhat skewed. When I match a Chilkat method in ChilkatVFP, there's one associated ChilkatVFP method. When I match a Chilkat property, there's one ChilkatVFP property plus an associated Access and Assign method. That counts as one property and two methods. 

I ran the numbers and here's what I got:

ChilkatVFP version - **1.40**

Total Properties - **2509**

Total Methods - **9095**

Total Access methods - **2461**

Total Assign methods - **2472**

--

Total Elements - **11604**

Total NonAccess/Assign Methods - **4162**

Total Properties and NonAccess/Assign Methods - **6671**

--

So why do the total number of properties not match the total number of Access/Assign methods? Turns out some of the Chilkat properties map to Visual Foxpro properties. For instance, the Chilkat ASN class has a Tag property. That's an existing Visual Foxpro property. So the count for that object has an Access method, an Assign method but no tally in the Properties count, since it is already established.

The ZIP class has a Comment property, etc.

-- 

There is one property I couldn't just tack on an Access/Assign method. The Chilkat MIME class has a Name property. 

If you wish to make VFP 9 as flaky as can be, try to add an Access method to the Name property and work with it before the Name property is defined.

VFP is not happy. 

A couple things. Instantiating a ChilkatVFP object with an Access/Assign method on the Name property will trigger the Name Access method. The ChilkatVFP object instantiation (in this case, MIME) tries to first set up oMsgSvc (I think, looking at the code. I don't care to try this again...). When it reached the end of the oMsgSvc Access method, the Name Access method ran three times and then hung. 

That's rather odd... I reran it several times to ensure I wasn't hallucinating. I wasn't.

In researching I noted the *la_Stack* variable, which holds the call stack from an ASTACKINFO() call, was three levels deep. That matched the amount of Name Access calls, so I tried redefining the *la_Stack* array to be empty before the method ended.

The Name Access stopped being called and it stopped blowing up at that point, only to blow up later down the line. At that point I decided this was too much work and went in a different direction.

I got a few things out of this exercise: 1) Internally, ASTACKINFO() is internally "tickling" the objects in the call stack when it's released. 2) It appears that even though the Name Access method hasn't been externally defined the first time you hit it, internally VFP probably has a reference to it. And that gets VFP quite confused. 3) In case it helped somehow, I have added code to shorten and redefine the *la_Stack* variable to all the methods that use ASTACKINFO().

--

The ChilkatVFP MailMan AutoFixSettings method is not a method with a direct mapping to a Chilkat Mailman method. When a ChilkatVFP Mailman connection is made, this method is called to set other values on the ChilkatVFP object. And in Version 1.32 I added the ChilkatChangeLog method. There may be other methods like this within ChilkatVFP but these are the only one I can remember offhand.