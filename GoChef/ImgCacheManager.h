//
//  ImgCacheManager.h
//  GoChef
//
//  Created by iMario on 29/11/12.
//
//

#import <Foundation/Foundation.h>

@interface ImgCacheManager : NSObject

@property (nonatomic, retain) NSMutableDictionary *cacheImgs;

+ (ImgCacheManager *)sharedInstance;

-(BOOL) fileCached:(NSString*)file;
-(BOOL) storeFile:(NSString*)file withData:(NSData*)data;
-(UIImage*) getFile:(NSString*)file;
@end
