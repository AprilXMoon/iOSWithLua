//
//  ShipController.h
//  firstLua
//
//  Created by April Lee on 2015/9/30.
//  Copyright © 2015年 april. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipController : NSObject
{
    float shipSpeed;
    NSString *shipName;
}

@property (readonly) float posX;
@property (readonly) float posY;
@property (readonly) NSString *name;

- (instancetype) initWithX:(float)x Y:(float)y Speed:(float)speed Name:(NSString *)name;
- (void)pressLeftButton;
- (void)pressRightButton;
- (void)pressTopButton;
- (void)pressBottomButton;

@end
