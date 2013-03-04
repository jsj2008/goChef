//
//  AsynchronousImageView.m
//  instapad
//
//  Created by Mario Rosales Maillo on 09/06/11.
//  Copyright 2011 mobivery. All rights reserved.
//

#define CACHE_BUFFER 300
#define CACHE_DELETE_BUFFER 30

#import "AsynchronousImageView.h"
#import "ImgCacheManager.h"

@interface AsynchronousImageView (Private)

- (void) flushToCache:(NSData*)file;
- (void) checkCacheSize;
- (void) randomRemove:(int)numFilesToRemove;

- (void) fadeIn;

@end

@implementation AsynchronousImageView

@synthesize filename;
@synthesize okCache;
@synthesize deletingFiles;

- (id) initWithFrame:(CGRect)frame{

	self = [super initWithFrame:frame];
	return self;
}

- (void)loadImageFromURLString:(NSString *)theUrlString andActiveCache:(BOOL)activeCache{
    
    UIActivityIndicatorView *spiner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [spiner setTag:888];
    [self addSubview:spiner];
    [spiner setFrame:CGRectMake((self.frame.size.width-spiner.frame.size.width)/2,
                                (self.frame.size.height-spiner.frame.size.height)/2,
                                spiner.frame.size.width, spiner.frame.size.height)];
    [spiner startAnimating];
	
	self.filename = theUrlString;
	self.okCache = activeCache;
			
	if (!self.okCache) {
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:theUrlString] 
											  cachePolicy:NSURLRequestReturnCacheDataElseLoad 
											  timeoutInterval:30.0];
		
		connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
    }else if(![self.filename isEqual:[NSNull null]]){
            
		NSString *fName = [self.filename stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        if ([[ImgCacheManager sharedInstance] fileCached:fName] ){
            
            @try {
                NSData *NSD_image = [NSData dataWithData:UIImagePNGRepresentation([[ImgCacheManager sharedInstance] getFile:fName])];
                self.image = [UIImage imageWithData:NSD_image];
                [[self viewWithTag:888] removeFromSuperview];
            }
            @catch (NSException * e) {
                    
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:theUrlString]
                                                    cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                    timeoutInterval:30.0];
                connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            }

        } else {
        
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:theUrlString]
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                timeoutInterval:30.0];
			
			connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        }
				
	}
}
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
    if (data == nil)
        data = [[NSMutableData alloc] initWithCapacity:2048];
	
    [data appendData:incrementalData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [[self viewWithTag:888] removeFromSuperview];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
	
	
    [[self viewWithTag:888] removeFromSuperview];
	
    if (self.image ) 
		self.image  = nil;
	
	[self setAlpha:0.0];
	[self performSelector:@selector(fadeIn) withObject:nil afterDelay:0.1];
	self.image = [UIImage imageWithData:data];
	if (self.okCache) {
		[self flushToCache:data];
	}else {
		data = nil;
		connection = nil;
	}
	
}

-(void) flushToCache:(NSData*)file{
    
    NSString *fName = [self.filename stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    UIImage  *image = [[UIImage alloc] initWithData:file];
    NSData   *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
    [[ImgCacheManager sharedInstance] storeFile:fName withData:data1];

}

-(void) randomRemove:(int)numFilesToRemove{
	
	self.deletingFiles = TRUE;
		
	NSFileManager *fManager = [NSFileManager defaultManager];

	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSArray *origContents = [fManager contentsOfDirectoryAtPath:docDir error:nil];
	
	NSString *jpgFilePath;
	NSMutableDictionary *filesToRemove = [[NSMutableDictionary alloc] init];

	for (int i =  0; i< origContents.count; i++) {
		jpgFilePath = [NSString stringWithFormat:@"%@/%@",docDir,[origContents objectAtIndex:i]];
		NSDictionary *attributes =[fManager attributesOfItemAtPath:jpgFilePath error:nil];
		[filesToRemove setObject:jpgFilePath forKey:[NSString stringWithFormat:@"%@%@",[attributes objectForKey:@"NSFileSystemFileNumber"],[origContents objectAtIndex:i]]];
	}
	
	NSArray *allKeys = [filesToRemove allKeys];
	NSArray *sortedArray = [allKeys sortedArrayUsingSelector:@selector(compare:)];
		
	for (int i = 0; i < numFilesToRemove; i++) {
		jpgFilePath = [NSString stringWithFormat:@"%@",[filesToRemove objectForKey:[sortedArray objectAtIndex:i]]];
		if ([fManager fileExistsAtPath:jpgFilePath]){
			[fManager removeItemAtPath:jpgFilePath error:nil];
		}
	}
	deletingFiles = FALSE;
}

-(void) checkCacheSize{

	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSArray *origContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docDir error:nil];
	if (origContents.count > CACHE_BUFFER) {
		int j = (origContents.count - CACHE_BUFFER) + CACHE_DELETE_BUFFER;
		[self randomRemove:j];
	}
}

- (void) fadeIn{
    
    [UIView animateWithDuration:0.3 animations:^{
    [self setAlpha:1.0];
    }];
}

@end
