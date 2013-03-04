//
//  CoreDataClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TpvOrderEntity.h"

@class SingletonGlobal, UserClass, TarjetaClass;

@interface CoreDataClass : NSObject {
    
    SingletonGlobal *globalVar;
    
@private
    NSManagedObjectContext       *_NSMOC_context;
    NSManagedObjectModel         *_NSMOM_model;
    NSPersistentStoreCoordinator *_NSPSC_store;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext       *NSMOC_context;
@property (nonatomic, retain, readonly) NSManagedObjectModel         *NSMOM_model;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *NSPSC_store;

-(void) saveContext;
-(NSURL *) applicationSupportDirectory;


-(void) getUser;
-(void) updateUser:(UserClass *)UC_user;

-(void) getCreaditCardsWithUserId:(NSInteger)userId;
-(void) updateCreaditCard:(TarjetaClass *)TC_credit_card;
-(void) removeCreaditCard:(TarjetaClass *)TC_credit_card;
-(void) removeAllCreaditCard;

-(TpvOrderEntity*) getTpvWithPaymentId:(NSString*)paymentId;
-(TpvOrderEntity*) getTpvWithOrdertId:(NSString*)orderId;
-(void) createTpvWithId:(NSString*)paymentId;
-(void) updateTpvWithId:(NSString*)paymentId setOrderId:(NSString*)orderId;


@end