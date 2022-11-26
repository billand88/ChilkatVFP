

## Base

Base custom object.

The Base object contains a few methods and a property that are relevant for all subclasses. Developers can override/decorate the DisplayErrorMessage and ProcessErrorMessage methods in the iBase class.

The properties of the Base class are:

| Property | Purpose                        |
|----------|--------------------------------|
|cVersion| Property used to hold the version number of the project. Unused at this time. |


The methods of the Base class are :

| Method | Purpose                        |
|--------|--------------------------------|
|DisplayErrorMessage| Method run to display the error message. |
|ProcessErrorMessage| Method run to process an error message. |
|Release| Method run to cleanly release an object. |

## BaseChilkat

Template Chilkat class with properties/methods that span all Chilkat objects.

The lReturnBitAsLogical property potentially useful for interactive use. If the Chilkat property or method returns a Boolean value (0/1), setting this property to true will return a Visual Foxpro logical value (.f./.t.).

See the How Properties Work document on the usage of the cChilkatProperty and lWriteChilkatProperty properties.


The properties of the BaseChilkat class are:

| Property | Purpose                        |
|----------|--------------------------------|
|cChilkatClass| The Chilkat class name. |
|cChilkatObjectPrefix| The Chilkat prefix as part of the Chilkat object name to instantiate. |
|cChilkatProperty| Property used to set the Chilkat property name if it differs from the Visual Foxpro property name. |
|cEventHandlerClass| The class name of the event handler, if relevant. | 
|cScratch| Scratch character variable.|
|GetImplAddrStr| Undocumented property! It looks like a memory address to the specific class. |
|iBuildNumber| Integer property used to hold the build number for the Chilkat object. |
|iInstanceBuildNumber| The instance object build number, if relevant. |
|lAddEventHandler| Logical property used to determine if the Chilkat object (oChilkat) will add an event handler, if relevant. |
|lReturnBitAsLogical| Property used to determine that bit values are returned as a Visual Foxpro logical value. |
|oChilkat| The reference to the actual Chilkat object. |
|oEventHandler| Object property used to hold a reference to the Chilkat event handler, if relevant. |
|oMsgSvc| Object property used to hold a references to the MsgSvc object. |
|oProcess_Access| Object property used to hold a reference to the Process_Access object. |
|oProcess_Assign| Object property used to hold a reference to the Process_Assign object. |
|qScratch| Scratch VarBinary variable.|
|Version| Version of the component/library, such as "9.5.0.63" |


The methods of the BaseChilkat class are:

| Method | Purpose                        |
|--------|--------------------------------|
|BitToLogical| Method run to covert a bit value to logical. |
|CallAccessObject| Method run from property access methods to run generic property type methods from the Process_Access object. |
|CallAssignObject| Method run from property assign methods to run generic property type methods from the Process_Assign object. |
|CallToChilkatError| Method run when the call to Chilkat's method fails for some reason. |
|cChilkatClass_Assign| Assign method used to retrieve the cChilkatClass property. |
|GetBuildNumber| Method used to determine the build number of the Chilkat object. |
|GetChilkatObject| Method run to retrieve or create the Chilkat object. |
|GetImplAddrStr_Access| Access method used to retrieve the GetImplAddrStr property. |
|GetImplAddrStr_Assign| Assign method used to hold the GetImplAddrStr property of the referenced Chilkat object. |
|iBuildNumber_Access| Access method used to retrieve the iBuildNumber property. |
|iBuildNumber_Assign| Assign method used to hold the iBuildNumber property, generated from the Version number of the Chilkat object. |
|Init_Post | Method used to run a post-initialization process. |
|iInstanceBuildNumber_Assign| Assign method used to retrieve the iInstanceBuildNumber property. |
|InitializeMsgSvc| Method run to initialize MsgSvc. |
|IsImplemented| Method used to determine if the method or property being referenced has been implemented in the current version of the object. |
|IsInstance| Method used to determine if class being referenced has been implemented in the current version of the software. |
|LogicalToBit| Method run to covert a logical value to bit. |
|lAddEventHandler_Assign| Assign method used to determine that an event handler will be bound to the Chilkat object. |
|lReturnBitAsLogical_Assign| Assign method used to determine that bit values are returned as a Visual Foxpro logical value. |
|lWriteChilkatProperty_Assign| Assign method used to determine if we are to write the value out to the Chilkat property name. |
|MissingObjectError| Error method run for when there is a missing Chilkat object when running a method. |
|oEventHandler_Assign| Assign method used to hold a reference to the event handler object. |
|oMsgSvc_Access| Access method used to retrieve a reference to the MsgSvc object. |
|oMsgSvc_Assign| Assign method used to hold a reference to the MsgSvc object. |
|Version_Access| Access method used to retrieve the Version property of the referenced Chilkat object. |
|Version_Assign| Assign method used to hold the Version property of the referenced Chilkat object. |

For clarification, the IsImplemented addresses properties and method implementations while IsInstance determines if a class exists. Both deal with versioning.

## BaseEventHandler

As the time of this writing, Chilkat has 103 classes. ~~33~~ 35 of these classes contain events. This event handler class is the base handler for 27 of those ~~33~~ 35 classes. The other six classes subclass from this base event handler and have even more events.

Note that for each Chilkat event there are four supporting methods in the event handler. For each Chilkat [*event*] there is a corresponding Event Handler [*event*], [*event name*]_pre, [*event name*]_process and [*event name*]_post methods. The event handler methods are "hooked". 

For reference, please read Steven Black's seminal work about the subject here: <a href="http://stevenblack.com/articles/hooks-and-anchors/" target="_blank">http://stevenblack.com/articles/hooks-and-anchors/</a>

The four event handler classes can be used (or for that matter, ignored) any way you want. The intent is thus: 

| Method | Purpose                        |
|--------|--------------------------------|
|*event*| The "governor" of the support event methods. |
|*event*_pre| A pre-processing method. You can set up the environment here.  |
|*event*_process| The "work" is done in this method. |
|*event*_post| A post-processing method to update the environment as necessary. |

Think of the _pre as a Textbox **When** method and the _post as a Textbox **LostFocus** method and you wouldn't be far off at all. 

Do your setup in the _pre method (Do I have a file? Is the directory good? Etc.). 
Do your "real work" in the _process method.
If the "work" is done successfully, call the _post method to "report" the success, clean up, etc.

Why do it this way? Well, the individual pieces of the process can be their own hooks! Hooks can call hooks, etc. No need to repeat Steve's article here...

The methods of the BaseEventHandler class are:

| Method | Purpose                        |
|--------|--------------------------------|
|AbortCheck| Provides the opportunity for a method call to be aborted. The AbortCheck event is fired periodically based on the value of the HeartbeatMs property. If HeartbeatMs is 0, then no AbortCheck events will fire. |
|AbortCheck_Post| Template AbortCheck post-processing method. |
|AbortCheck_Pre| Template AbortCheck pre-processing method. |
|AbortCheck_Process| Template AbortCheck processing method. |
|BinaryData| Added in version 58 but as of the time of this writing is unused. |
|BinaryData_Post| Template BinaryData post-processing method. |
|BinaryData_Pre| Template BinaryData pre-processing method. |
|BinaryData_Process| Template BinaryData processing method. |
|PercentDone| Provides the percentage completed for any method that involves network communications or time-consuming processing (assuming it is a method where a percentage completion can be measured). |
|PercentDone_Post| Template PercentDone post-processing method. |
|PercentDone_Pre| Template PercentDone pre-processing method. |
|PercentDone_Process| Template PercentDone processing method. |
|ProgressInfo| A general name/value event that provides information about what is happening during a method call. To find out what information is available, write code to handle this event and log the name/value pairs. |
|ProgressInfo_Post| Template ProgressInfo post-processing method. |
|ProgressInfo_Pre| Template ProgressInfo pre-processing method. |
|ProgressInfo_Process| Template ProgressInfo processing method. |
|TaskCompleted| Method run when a task is complete. |
|TaskCompleted_Post| Template TaskCompleted post-processing method. |
|TaskCompleted_Pre| Template TaskCompleted pre-processing method. |
|TaskCompleted_Process| Template TaskCompleted processing method. |
|TextData| Added in version 58 but as of the time of this writing is unused. |
|TextData_Post| Template TextData post-processing method. |
|TextData_Pre| Template TextData pre-processing method. |
|TextData_Process| Template TextData processing method. |

## Process

Template processing object.

The process class contains no methods or properties.

## Process_Access

Object used to generically process an Access method.

The methods of the Process_Access class are :

| Method | Purpose                        |
|--------|--------------------------------|
|CallChilkat| Method run to call the Chilkat object to retrieve the property. |
|DateTime| Method run to process the Access method for a property that returns a DateTime from the Chilkat object. |
|DateTimeReadOnly| Method run to process the Access method for a property that returns a DateTime and is read only from the Chilkat object. |
|Long| Method run to process the Access method for a property that returns a Long from the Chilkat object. |
|LongBit| Method run to process the Access method for a property that returns a Long (0 or a 1) from the Chilkat object. |
|LongBitReadOnly| Method run to process the Access method for a property that returns a Long (0 or a 1) and is read only from the Chilkat object. |
|LongReadOnly| Method run to process the Access method for a property that returns a Long and is read only from the Chilkat object. |
|String| Method run to process the Access method for a property that returns a String (character) from the Chilkat object. |
|StringReadOnly| Method run to process the Access method for a property that returns a String and is read only from the Chilkat object. |
|Variant| Method run to process the Access method for a property that returns a VarBinary from the Chilkat object. |
|VariantReadOnly| Method run to process the Access method for a property that returns a Variant and is read only from the Chilkat object. |

## Process_Assign

Object used to generically process an Assign method.

The properties of the Process_Assign class are:

| Property | Purpose                        |
|----------|--------------------------------|
|oValidateProperty| Object property used to hold the property validator object. |

The methods of the Process_Assign class are:

| Method | Purpose                        |
|--------|--------------------------------|
|CallChilkat| Method run to call the Chilkat object to retrieve the property. |
|DateTime| Method run to process the Assign method for property that returns a DateTime from the Chilkat object. |
|DateTimeReadOnly| Method run to process the Assign method for a property that returns a DateTime and is read only from the Chilkat object. |
|Long| Method run to process the Assign method for property that returns a Long bit from the Chilkat object. |
|LongBit| Method run to process the Assign method for property that returns a Long bit (0 or a 1) from the Chilkat object. |
|LongBitReadOnly| Method run to process the Access method for a property that returns a Long (0 or a 1) and is read only from the Chilkat object. |
|LongReadOnly| Method run to process the Access method for a property that returns a Long and is read only from the Chilkat object. |
|oValidateProperty_Access| Access method used to retrieve a reference to the property validation object. |
|oValidateProperty_Assign| Assign method used to hold a reference to the property validation object. |
|String| Method run to process the Assign method for a property that returns a String from the Chilkat object. |
|StringReadOnly| Method run to process the Assign method for a property that returns a String and is read only from the Chilkat object. |
|Variant| Method run to process the Assign method for a property that returns a Variant from the Chilkat object. |
|VariantReadOnly| Method run to process the Assign method for a property that returns a Variant and is read only from the Chilkat object. |


## ValidateProperty

Class used to validate property values.

The methods of the ValidateProperty class are:

| Method | Purpose                        |
|--------|--------------------------------|
|Algorithm_Compression| Method run to validate the data for the Compression Algorithm property. |
|Algorithm_EdDSA| Method run to validate the data for the EdDSA Algorithm property. |
|AuthMethod| Method run to validate the data for the AuthMethod property. |
|AWSSignatureVersion| Method run to validate the data for the AWSSignatureVersion property. |
|AWSSubResources| Method run to validate the data for the AWSSubResources property. |
|BCryptWorkFactor| Method run to validate the data for the BCryptWorkFactor property. |
|Behaviors| Method run to validate the data for the Behaviors property. |
|BgPercentDone| Method run to validate the data for the BgPercentDone property. |
|Charset| Method run to validate the data for the various charset properties. |
|CipherMode| Method run to validate the data for the CipherMode property. |
|ClientPort| Method run to validate the data for the ClientPort property. |
|CodeChallengeMethod| Method run to validate the data for the CodeChallengeMethod property. |
|CompressionLevel| Method run to validate the data for the CompressionLevel property. |
|CompressionMethod| Method run to validate the data for the CompressionMethod property. |
|CRLFMode| Method run to validate the data for the CRLFMode property. |
|CryptAlgorithm| Method run to validate the data for the CryptAlgorithm property. |
|DataProtection| Method run to validate the data for the DataProtection property. |
|Day| Method run to validate the data for the Day property. |
|DefaultNTLMVersion| Method run to validate the data for the DefaultNTLMVersion property. |
|DeflateLevel| Method run to validate the data for the DeflateLevel property. |
|DKIMAlg| Method run to validate the data for the DKIMAlg property. |
|DKIMCanon| Method run to validate the data for the DKIMCanon property. |
|DomainKeyAlg| Method run to validate the data for the DomainKeyAlg property. |
|DomainKeyCanon| Method run to validate the data for the DomainKeyCanon property. |
|DSNNotify| Method run to validate the data for the DSNNotify property. |
|DSNRet| Method run to validate the data for the DSNRet property. |
|EncodingMode_Compression| Method run to validate the data for the Compression EncodingMode property. |
|EncodingMode_Crypt2| Method run to validate the data for the Crypt2 EncodingMode property. |
|EncodingMode_NTLM| Method run to validate the data for the NTLM EncodingMode property. |
|Encryption| Method run to validate the data for the Encryption property. |
|EncryptKeyLength| Method run to validate the data for the EncryptKeyLength property. |
|ForceCipher| Method run to validate the data for the ForceCipher property. |
|ForcePortIPAddress| Method run to validate the data for the ForcePortIPAddress property. |
|FromCharset| Method run to validate the data for the FromCharset property. |
|HashAlgorithm_Crypt2| Method run to validate the data for the Crypt2 HashAlgorithm property. |
|HashAlgorithm_CSR| Method run to validate the data for the CSR HashAlgorithm property. |
|HAVALRounds| Method run to validate the data for the HAVALRounds property. |
|HostKeyAlg| Method run to validate the data for the HostKeyAlg property. |
|Hour| Method run to validate the data for the Hour property. |
|HTTPProxyAuthMethod| Method run to validate the data for the HTTPProxyAuthMethod property. |
|KeyInfoType| Method run to validate the data for the KeyInfoType property. |
|LegacyKeySpec| Method run to validate the data for the LegacyKeySpec property. |
|Level| Method run to validate the data for the Level property. |
|LMFactor| Method run to validate the data for the LMFactor property. |
|MACAlgorithm| Method run to validate the data for the MACAlgorithm property. |
|MaintainHash| Method run to validate the data for the MaintainHash property. |
|MaxThreads| Method run to validate the data for the MaxThreads property. |
|MGFHashAlg| Method run to validate the data for the MGFHashAlg property. |
|MicAlg| Method run to validate the data for the MicAlg property. |
|Minute| Method run to validate the data for the Minute property. |
|Month| Method run to validate the data for the Month property. |
|NBSp| Method run to validate the data for the NBSp property. |
|NTLMVersion| Method run to validate the data for the NTLMVersion property. |
|NumCacheLevels| Method run to validate the data for the NumCacheLevels property. |
|OAEPHash| Method run to validate the data for the OAEPHash property. |
|OAEPHash_RSA| Method run to validate the data for the RSA OAEPHash property. |
|OAEPMGFHash| Method run to validate the data for the OAEPMGFHash property. |
|OAEPMgfHash_RSA| Method run to validate the data for the RSA OAEPMgfHash property. |
|OAuthMethod| Method run to validate the data for the OAuthMethod property. |
|OAuthSigMethod| Method run to validate the data for the OAuthSigMethod property. |
|PaddingScheme| Method run to validate the data for the PaddingScheme property. |
|PBES2CryptAlg| Method run to validate the data for the PFX PBES2CryptAlg property. |
|PBES2HMACAlg| Method run to validate the data for the PFX PBES2HMACAlg property. |
|PercentDoneScale| Method run to validate the data for the PercentDoneScale property. |
|PKCS7CryptAlg| Method run to validate the data for the PKCS7CryptAlg property. |
|PKCS7KeyLength| Method run to validate the data for the PKCS7KeyLength property. |
|PKCS8EncryptAlg| Method run to validate the data for the PKCS8EncryptAlg property. |
|PreferredCharset| Method run to validate the data for the PreferredCharset property. |
|PrivateKeyFormat| Method run to validate the data for the PrivateKeyFormat property. |
|ProxyAuthMethod| Method run to validate the data for the ProxyAuthMethod property. |
|ProxyMethod| Method run to validate the data for the ProxyMethod property. |
|PublicKeyFormat| Method run to validate the data for the PublicKeyFormat property. |
|RC2EffectiveKeyLength| Method run to validate the data for the RC2EffectiveKeyLength property. |
|RSAPaddingHash| Method run to validate the data for the RSAPaddingHash property. |
|RSAPaddingScheme| Method run to validate the data for the RSAPaddingScheme property. |
|Scheme| Method run to validate the data for the Scheme property. |
|Second| Method run to validate the data for the Second property. |
|Service| Method run to validate the data for the Service property. |
|SessionLogEncoding| Method run to validate the data for the SessionLogEncoding property. |
|SigLocationMod| Method run to validate the data for the SigLocationMod property. |
|SignatureMethod| Method run to validate the data for the SignatureMethod property. |
|SigniedInfoCanonAlg| Method run to validate the data for the SigniedInfoCanonAlg property. |
|SignedInfoDigestMethod| Method run to validate the data for the SignedInfoDigestMethod property. |
|SigningHashAlg| Method run to validate the data for the SigningHashAlg property. |
|SMTPAuthMethod| Method run to validate the data for the SMTPAuthMethod property. |
|SOCKSVersion| Method run to validate the data for the SOCKSVersion property. |
|SSLAllowedCiphers| Method run to validate the data for the SSLAllowedCiphers property. |
|SSLProtocol| Method run to validate the data for the SSLProtocol property. |
|StructTmMonth| Method run to validate the data for the StructTmMonth property. |
|UncommonOptions_crypt2| Method run to validate the data for the UncommonOptions property of the Crypt2 object. |
|UncommonOptions_Email| Method run to validate the data for the UncommonOptions property of the Email object. |
|UncommonOptions_FTP2| Method run to validate the data for the UncommonOptions property of the FTP2 object. |
|UncommonOptions_HTTP| Method run to validate the data for the UncommonOptions property of the HTTP object. |
|UncommonOptions_HTTPResponse| Method run to validate the data for the UncommonOptions property of the HTTPResponse object. |
|UncommonOptions_IMAP| Method run to validate the data for the UncommonOptions property of the IMAP object. |
|UncommonOptions_Mailman| Method run to validate the data for the UncommonOptions property of the Mailman object. |
|UncommonOptions_OAuth1| Method run to validate the data for the UncommonOptions property of the OAuth1 object. |
|UncommonOptions_PDF| Method run to validate the data for the UncommonOptions property of the PDF object. |
|UncommonOptions_PFX| Method run to validate the data for the PFX UncommonOptions property. |
|UncommonOptions_Rest| Method run to validate the data for the UncommonOptions property of the Rest object. |
|UncommonOptions_SCP| Method run to validate the data for the UncommonOptions property of the SCP object. |
|UncommonOptions_SFTP| Method run to validate the data for the UncommonOptions property of the SFTP object. |
|UncommonOptions_Socket| Method run to validate the data for the UncommonOptions property of the Socket object. |
|UncommonOptions_SSH| Method run to validate the data for the UncommonOptions property of the SSH object. |
|UncommonOptions_SSHKey| Method run to validate the data for the UncommonOptions property of the SSHKey object. |
|UncommonOptions_SSHTunnel| Method run to validate the data for the UncommonOptions property of the SSHTunnel object. |
|UncommonOptions_WebSocket| Method run to validate the data for the UncommonOptions property of the WebSocket object. |
|UncommonOptions_ZIP| Method run to validate the data for the UncommonOptions property of the ZIP object. |
|WriteFormat| Method run to validate the data for the WriteFormat property. |
|X509Type| Method run to validate the data for the X509Type property. |
|ZipDefaultAlg| Method run to validate the data for the ZipDefaultAlg property. |

#### Contact: chilkat VFP at gmail dot com.

  [1]: http://stevenblack.com/articles/hooks-and-anchors/
