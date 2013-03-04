//
//  TpvOrderEntity.h
//  GoChef
//
//  Created by iMario on 28/11/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TpvOrderEntity : NSManagedObject

@property (nonatomic, retain) NSString * idOrder;
@property (nonatomic, retain) NSString * idPaymentOrder;

@end
