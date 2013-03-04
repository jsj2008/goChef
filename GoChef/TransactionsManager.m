//
//  TransactionsManager.m
//  GoChef
//
//  Created by iMario on 30/11/12.
//
//

#import "TransactionsManager.h"
#import "SingletonGlobal.h"
#import "tpvDAO.h"
#import "OrderClass.h"
#import "JSONparseClass.h"

@interface  TransactionsManager (Private)

-(void) didRecibeDevolutionNotification:(NSNotification*)note;
-(void) transFinishedOk;
-(void) transFinishedFail;
-(void) updateOrderStatusOk;
-(void) updateOrderStatusFail;
-(void) exectTransWithDictionary:(NSMutableDictionary*)dict;

@end

@implementation TransactionsManager

@synthesize queueTrans = _queueTrans;
@synthesize transInfo = _transInfo;

static TransactionsManager *_staticTransactionsManager = nil;

+ (TransactionsManager*) sharedInstance {
    if (_staticTransactionsManager == nil){
        _staticTransactionsManager = [[self alloc] init];
    }
    return _staticTransactionsManager;
}

-(void) registerForNotifications{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRecibeDevolutionNotification:) name:_NOTIFICATION_ORDERSDEVOLUTIONS_PARSE_JSON_ object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrderStatusOk) name:_NOTIFICATION_UPDATE_ORDER_STATUS_SUCCESSFUL_ object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrderStatusFail) name:_NOTIFICATION_UPDATE_ORDER_STATUS_ERROR_ object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transFinishedOk) name:@"tpvOperationConfirmedCanceledOkNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transFinishedFail) name:@"tpvOperationConfirmedCanceledFailNotification" object:nil];
}

#pragma mark - private methods

-(void) updateOrderStatusOk{
    
    [self.queueTrans removeLastObject];
    [[SingletonGlobal sharedGlobal] showAlerMsgWith:_ALERT_TITLE_TPV_ message:[SingletonGlobal sharedGlobal].NSS_msg_error];

     if ([self.queueTrans count]) {
         [self exectTransWithDictionary:[self.queueTrans lastObject]];
     }
}

-(void) updateOrderStatusFail{
    
    [self.queueTrans removeLastObject];
    [[SingletonGlobal sharedGlobal] showAlerMsgWith:_ALERT_TITLE_TPV_ message:[SingletonGlobal sharedGlobal].NSS_msg_error];
    
     if ([self.queueTrans count]) {
         [self exectTransWithDictionary:[self.queueTrans lastObject]];
     }
}

-(void) didRecibeDevolutionNotification:(NSNotification*)note{
    
    NSMutableArray *devolutions = (NSMutableArray*) note.object;
    self.queueTrans = devolutions;
    [self exectTransWithDictionary:[self.queueTrans lastObject]];
    
}

-(void) transFinishedOk{
    
    OrderClass *order = (OrderClass*)[(NSMutableDictionary*)[self.queueTrans lastObject] objectForKey:@"order"];
    [order setTOS_status:TOS_devolucion_efectuada];
    [[SingletonGlobal sharedGlobal].JPC_json UMNI_updateOrderStatus:order];

}
-(void) transFinishedFail{
    
    OrderClass *order = (OrderClass*)[(NSMutableDictionary*)[self.queueTrans lastObject] objectForKey:@"order"];
    [order setTOS_status:TOS_devolucion_fallida];
    [[SingletonGlobal sharedGlobal].JPC_json UMNI_updateOrderStatus:order];
}

-(void) exectTransWithDictionary:(NSMutableDictionary*)dict{

    OrderClass *order = (OrderClass*)[dict objectForKey:@"order"];
    NSDictionary *cardPayment = [dict objectForKey:@"payment_info"];
    
    if (order) {
        int amount = [[NSNumber numberWithFloat:order.CGF_total*100] intValue];
        [[tpvDAO sharedInstance] requestCancelOrConfirmWithPaymentId:[cardPayment valueForKey:@"idorder_tpv"] amount:amount andOperation:@"3"];
    }
}
@end
