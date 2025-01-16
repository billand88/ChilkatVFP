
## How Properties Work

The initial release version of the Chilkat class library is over 21 megabytes in size (as of this writing, the .VCT file is 21,054,424 bytes). A vast majority of this is simply documentation.  Without a consolidated mechanism of processing properties that size would be significantly larger.

## Chilkat Variable/Parameter Types

| Method | Purpose                        |
|--------|--------------------------------|
|DateTime | Returns a VFP DateTime value (undocumented). |
|Long | Returns an numeric value, usually an integer. |
|Object | Returns a Chilkat object (only relevant for methods). |
|String | Returns a character value. |
|Variant | Returns a binary value. |

Chilkat methods and properties can return any of these values. Methods can return a Void, which is in essence returning no value at all. Chilkat properties can be read only.
Chilkat handles Boolean values by returning/setting a 0 for false and 1 for a true value, depending on context. It can also mean failure versus success for Chilkat methods.
 
Chilkat will only return/accept a DateTime value/parameter for undocumented/deprecated methods and properties.

## ChilkatVFP Variable/Parameter Types

| Method | Purpose                        |
|--------|--------------------------------|
|DateTime | Returns a VFP DateTime value (undocumented). |
|Long | Returns an numeric value, usually an integer. |
|LongBit | Returns an integer or logical value, dependent upon the lReturnBitAsLogical property. |
|String | Returns a character value. |
|Variant | Returns a binary value. |

So from a high level we are routing the 8 Chilkat variable types (the 4 in the Chilkat Variable/Parameter Types table, less Object and their read only equivalents) to the 10 ChilkatVFP variable types (the 5 in the ChilkatVFP Variable/Parameter Types and their read only equivalents) via Access and Assign methods on the VFP property. 

## First Try In Late 2019

The first time I toyed with this in late 2019 I tried to set things up as a "pay as you go" system - only update the equivalent Visual Foxpro property only when it is needed. Makes sense. Soon thereafter, while debugging, I ran into a situation where the debugger had one value for a property but if I queried from the command window, I got a second value. And it was both confusing and correct. I don't remember the specific example but it was somewhere along the lines of stopping the program before the VFP property value was updated while checking at the command window "completed the loop" for a second, different value. Any other developer poking around would eventually run into this as well.

I kept none of this first try, it wasn't far enough along. But I did come away with this: Try to keep the Chilkat property and the related Visual FoxPro property as tightly coupled as possible.

## ChilkatVFP Access Methods

ChilkatVFP property access methods pass two parameters. The first parameter is the name of one of the 10 ChilkatVFP Variable/Parameter types mentioned above and the second is the version the property was introduced by Chilkat (usually 0). Note that the actual name of the property isn't passed as a parameter - it's derived via calculation. There's a fair amount of boilerplate code for the access method used to simply return the property value after the call to retrieve the value from Chilkat. This avoids the inevitable typing errors.

## ChilkatVFP Assign Methods

ChilkatVFP property assign methods pass three parameters. The first value is simply the value you wish to assign. The second parameter is the same as the first parameter of the access method, one of the 10 
ChilkatVFP Variable/Parameter types. The third parameter, if relevant, is the name of the method used to validate the value in the first parameter. If not empty, the method should reside in the ValidateProperty class.

#### Contact: chilkatVFP at gmail dot com.