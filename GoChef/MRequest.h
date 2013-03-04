//
//  MRequest.h
//  GoChef
//
//  Created by iMario on 26/11/12.
//
//

#import <Foundation/Foundation.h>

@interface MRequest : NSObject {
    NSString *mainUrl;
}

@property (nonatomic, assign) SEL okSel;
@property (nonatomic, assign) SEL koSel;

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *finalDestination;
@property (nonatomic, retain) NSMutableURLRequest *theRequest;
@property (nonatomic, retain) NSMutableArray *connectionRedirects;
@property (nonatomic, retain) NSString *errorRequest;
@property (nonatomic, retain) NSString *method;
@property (nonatomic) BOOL inProgress;
@property (nonatomic, retain) NSString *cookie;

@property (nonatomic, assign) id delegate;


+ (MRequest*) sharedInstance;

- (void) connect:(NSString*)Url withParams:(NSMutableDictionary*) params withMethods:(NSString*)method withOkSelector:(SEL)okSelector andKoSelector:(SEL)koSelector;

@end
