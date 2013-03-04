//
//  MRequest.m
//  GoChef
//
//  Created by iMario on 26/11/12.
//
//

#import "MRequest.h"

#define TIME_OUT_INTERVAL 15.0

@interface  MRequest (Private)

@end

@implementation MRequest

@synthesize receivedData;
@synthesize finalDestination;
@synthesize theRequest;
@synthesize connectionRedirects;
@synthesize inProgress;
@synthesize errorRequest;
@synthesize okSel, koSel;
@synthesize method = method_;
@synthesize cookie = _cookie;
@synthesize delegate = _delegate;

static MRequest* staticMRequest_;

+ (MRequest*) sharedInstance {
    
    if (staticMRequest_ == nil){
        staticMRequest_ = [[self alloc] init];
    }
    return staticMRequest_;
}

- (void) connect:(NSString*)Url withParams:(NSMutableDictionary*) params withMethods:(NSString*)method withOkSelector:(SEL)okSelector andKoSelector:(SEL)koSelector{
	
    mainUrl = [[NSString alloc] initWithFormat:@"%@",Url];
    
    self.inProgress = TRUE;
    self.method = [method uppercaseString];
	receivedData = [NSMutableData alloc];
	connectionRedirects = [[NSMutableArray alloc] init];
	finalDestination = [NSString stringWithFormat:@""];
    theRequest = [[NSMutableURLRequest alloc] init];
    [theRequest setHTTPShouldHandleCookies:TRUE];
    [theRequest setHTTPMethod:self.method];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cookie"] && ![[[NSUserDefaults standardUserDefaults] valueForKey:@"cookie"] isEqualToString:@""]) {
        [theRequest setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"cookie"] forHTTPHeaderField:@"Set-Cookie"];
    }
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    okSel = okSelector;
    koSel = koSelector;
    
    NSString *paramString = [NSString stringWithFormat:@""];
    
	if ([params count]>0){
		//Establecemos los parametros
		NSEnumerator *enumerator = [params keyEnumerator];
		id key;
		while ((key = [enumerator nextObject])) {
            paramString = [paramString stringByAppendingFormat:@"entrada="];
            paramString = [paramString stringByAppendingFormat:@"<%@>",key];
            
            NSEnumerator *enumeratorB = [(NSMutableDictionary*)[params objectForKey:key] keyEnumerator];
            id keyB;
            while ((keyB = [enumeratorB nextObject])) {
                paramString =  [paramString stringByAppendingFormat:@"<%@>%@</%@>",keyB,[[params objectForKey:key] objectForKey:keyB],keyB];
            }
            paramString = [paramString stringByAppendingFormat:@"</%@>",key];
		}        
    }
        
    if ([self.method isEqualToString:@"POST"]) {
        
        theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:Url]
                                        cachePolicy:NSURLRequestReloadIgnoringCacheData
                                        timeoutInterval:TIME_OUT_INTERVAL];
        
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [theRequest setHTTPBody:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
        
    } else if ([self.method isEqualToString:@"GET"]) {
        
        NSString *tmpUrl;
        if (![paramString isEqualToString:@""]) {
            tmpUrl = [NSString stringWithFormat:@"%@?%@",Url,paramString];
        }else{
            tmpUrl = [NSString stringWithFormat:@"%@",Url];
        }
        theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:tmpUrl]
                                        cachePolicy:NSURLRequestReloadIgnoringCacheData
                                        timeoutInterval:TIME_OUT_INTERVAL];
        
        [theRequest setHTTPMethod:@"GET"];
        
    }
    
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
	if (theConnection) {
		receivedData = [NSMutableData data];
	} else {
		self.inProgress = FALSE;
	}    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [receivedData setLength:0];
    
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
	if ([response respondsToSelector:@selector(allHeaderFields)]) {
		dictionary = [httpResponse allHeaderFields];
	}
    
    for (id key in [dictionary allKeys]){
        NSString *tmp = [NSString stringWithFormat:@" %@",[dictionary objectForKey:key]];
        if ([key isEqualToString:@"Set-Cookie"]) {
            if ([dictionary objectForKey:key] && ![[dictionary objectForKey:key] isEqualToString:@""]) {
                if ([tmp rangeOfString:@"JSESSIONID"].location != NSNotFound) {
                    [[NSUserDefaults standardUserDefaults] setValue:[[NSMutableString alloc] initWithString:[dictionary objectForKey:key]] forKey:@"cookie"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	
    self.inProgress = FALSE;
	self.errorRequest = [NSString stringWithFormat:@"%@",error];
    
    if (_delegate && koSel) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_delegate performSelector:koSel withObject:error];
#pragma clang diagnostic pop
        
    }
    
}

- (NSURLRequest *)connection: (NSURLConnection *)inConnection willSendRequest: (NSURLRequest *)inRequest redirectResponse: (NSURLResponse *)inRedirectResponse{
    
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)inRedirectResponse;
	if ([inRedirectResponse respondsToSelector:@selector(allHeaderFields)]) {
		dictionary = [httpResponse allHeaderFields];
	}
    
    for (id key in [dictionary allKeys]){
        NSString *tmp = [NSString stringWithFormat:@" %@",[dictionary objectForKey:key]];
        if ([key isEqualToString:@"Set-Cookie"]) {
            if ([dictionary objectForKey:key] && ![[dictionary objectForKey:key] isEqualToString:@""]) {
                if ([tmp rangeOfString:@"JSESSIONID"].location != NSNotFound) {
                    //NSLog(@"seteamos la cookie %@",[[NSMutableString alloc] initWithString:[dictionary objectForKey:key]]);
                    [[NSUserDefaults standardUserDefaults] setValue:[[NSMutableString alloc] initWithString:[dictionary objectForKey:key]] forKey:@"cookie"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }
        }
    }
    
	NSString *redirect = [NSString stringWithFormat:@"%@",[inRequest URL]];
	[connectionRedirects addObject:redirect];
	return inRequest;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
	self.inProgress = FALSE;
	self.finalDestination = [connectionRedirects lastObject];
        
    if (_delegate && okSel) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_delegate performSelector:okSel withObject:receivedData];
#pragma clang diagnostic pop
    }
}

-(void) dealloc{
    
	self.receivedData = nil;
    self.finalDestination = nil;
    self.theRequest = nil;
    self.connectionRedirects = nil;
    self.errorRequest = nil;
    self.delegate = nil;
    self.koSel = nil;
    self.okSel = nil;
    self.method = nil;
    self.cookie = nil;
    mainUrl = nil;
}
@end
