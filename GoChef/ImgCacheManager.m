//
//  ImgCacheManager.m
//  GoChef
//
//  Created by iMario on 29/11/12.
//
//

#import "ImgCacheManager.h"

@implementation ImgCacheManager

static ImgCacheManager *_staticImgCacheManager = nil;

@synthesize cacheImgs =_cacheImgs;

+ (ImgCacheManager*) sharedInstance {
    if (_staticImgCacheManager == nil){
        _staticImgCacheManager = [[self alloc] init];
    }
    return _staticImgCacheManager;
}

-(BOOL) fileCached:(NSString*)file{

    if (!self.cacheImgs) {
        self.cacheImgs = [[NSMutableDictionary alloc] init];
    }
    
    if ([self.cacheImgs objectForKey:file]) {
        return TRUE;
    }
    return FALSE;

}

-(BOOL) storeFile:(NSString*)file withData:(NSData*)data{
    
	NSString *filePath=[NSTemporaryDirectory() stringByAppendingString:file];
    
	[[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        return  FALSE;
    }
    
    if (!self.cacheImgs) {
        self.cacheImgs = [[NSMutableDictionary alloc] init];
    }
    
    [self.cacheImgs setObject:filePath forKey:file];
    return  TRUE;
    
}

-(UIImage*) getFile:(NSString*)file{

    NSString *filePath=[NSTemporaryDirectory() stringByAppendingString:file];

    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        return  nil;
    } else {
        return  [UIImage imageWithContentsOfFile:filePath];
    }
}


@end
