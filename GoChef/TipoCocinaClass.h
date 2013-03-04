//
//  TipoCocinaClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface TipoCocinaClass : NSObject {
    
    NSInteger _NSI_id;
    NSString *_NSS_name;
    NSString *_NSS_description;
}

@property (nonatomic, readwrite) NSInteger NSI_id;
@property (nonatomic, retain)    NSString *NSS_name;
@property (nonatomic, retain)    NSString *NSS_description;


@end