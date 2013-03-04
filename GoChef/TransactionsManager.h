//
//  TransactionsManager.h
//  GoChef
//
//  Created by iMario on 30/11/12.
//
//

#import <Foundation/Foundation.h>

@interface TransactionsManager : NSObject

@property (nonatomic, retain) NSMutableArray *queueTrans;
@property (nonatomic, retain) NSMutableDictionary *transInfo;

+ (TransactionsManager *)sharedInstance;

-(void) registerForNotifications;

@end
