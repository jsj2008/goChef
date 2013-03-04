//
//  CreditCardEntity.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CreditCardEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * bDefault;
@property (nonatomic, retain) NSDate * dExpiration;
@property (nonatomic, retain) NSString * sNumber;
@property (nonatomic, retain) NSString * sCVV;
@property (nonatomic, retain) NSString * sName;
@property (nonatomic, retain) NSString * sType;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * userId;

@end
