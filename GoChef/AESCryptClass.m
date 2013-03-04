//
//  AESCryptClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>
#import "AESCryptClass.h"


@implementation AESCryptClass

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: AES128EncryptWithKey:data:
//#	Fecha Creación	: 01/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/03/2012  (pjoramas)
//# Descripción		: 
//#
-(NSData *) AES128EncryptWithKey:(NSString *)key data:(NSData *)NSD_in {
    
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused) // oorspronkelijk 256
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [NSD_in length];
	
	//See the doc: For block ciphers, the output size will always be less than or 
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode,
										  keyPtr, kCCKeySizeAES128, // oorspronkelijk 256
										  NULL /* initialization vector (optional) */,
										  [NSD_in bytes], dataLength, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesEncrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
	}
	
	free(buffer); //free the buffer;
	return nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: AES128DecryptWithKey:data:
//#	Fecha Creación	: 01/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/03/2012  (pjoramas)
//# Descripción		: 
//#
-(NSData *) AES128DecryptWithKey:(NSString *)key data:(NSData *)NSD_in {
    
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused) // oorspronkelijk 256
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [NSD_in length];
	
	//See the doc: For block ciphers, the output size will always be less than or 
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode,
										  keyPtr, kCCKeySizeAES128, // oorspronkelijk 256
										  NULL /* initialization vector (optional) */,
										  [NSD_in bytes], dataLength, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
	}
	
	free(buffer); //free the buffer;
	return nil;
}

- (NSString *)hexadecimalString:(NSData *)NSD_in {
    
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[NSD_in bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [NSD_in length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: stringWithHexBytes
//#	Fecha Creación	: 01/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/03/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString*) stringWithHexBytes:(NSData *)NSD_in {
    
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:([NSD_in length] * 2)];
    
    const unsigned char *dataBuffer = [NSD_in bytes];
    int i;
    
    for (i = 0; i < [NSD_in length]; ++i)
        [stringBuffer appendFormat:@"%02lX", (unsigned long)dataBuffer[ i ]];
    
    return [stringBuffer copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: strToChar
//#	Fecha Creación	: 01/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/03/2012  (pjoramas)
//# Descripción		: 
//#
unsigned char strToChar (char a, char b) {
    
    char encoder[3] = {'\0','\0','\0'};
    encoder[0] = a;
    encoder[1] = b;
    return (char) strtol(encoder,NULL,16);
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: decodeFromHexidecimal
//#	Fecha Creación	: 01/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/03/2012  (pjoramas)
//# Descripción		: 
//#
-(NSData *) decodeFromHexidecimal:(NSString *)NSS_in {
    
    const char * bytes = [NSS_in cStringUsingEncoding: NSUTF8StringEncoding];
    NSUInteger length = strlen(bytes);
    unsigned char * r = (unsigned char *) malloc(length / 2 + 1);
    unsigned char * index = r;
    
    while ((*bytes) && (*(bytes +1))) {
        *index = strToChar(*bytes, *(bytes +1));
        index++;
        bytes+=2;
    }
    *index = '\0';
    
    NSData * result = [NSData dataWithBytes: r length: length / 2];
    free(r);
    
    return result;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: decodeFromHexidecimal
//#	Fecha Creación	: 01/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/03/2012  (pjoramas)
//# Descripción		: 
//#
-(unsigned char *) decodeFromHexidecimal_:(NSString *)NSS_in {
    
    const char * bytes = [NSS_in cStringUsingEncoding: NSUTF8StringEncoding];
    NSUInteger length = strlen(bytes);
    unsigned char * r = (unsigned char *) malloc(length / 2 + 1);
    unsigned char * index = r;
    
    while ((*bytes) && (*(bytes +1))) {
        *index = strToChar(*bytes, *(bytes +1));
        index++;
        bytes+=2;
    }
    *index = '\0';
    
    return r;
}

@end