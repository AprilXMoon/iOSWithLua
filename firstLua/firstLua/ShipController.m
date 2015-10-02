//
//  ShipController.m
//  firstLua
//
//  Created by April Lee on 2015/9/30.
//  Copyright © 2015年 april. All rights reserved.
//

#import "ShipController.h"

@implementation ShipController

- (instancetype)initWithX:(float)x Y:(float)y Speed:(float)speed Name:(NSString *)name
{
    self = [super init];
    if (self) {
        _posX = x;
        _posY= y;
        shipSpeed = speed;
        shipName = name;
        _name = shipName;
    }
    
    return self;
}

- (void)pressLeftButton
{
    NSLog(@"Left button pressed for ship %@", self.name);
    _posX = _posX - shipSpeed;
}
- (void)pressRightButton
{
    NSLog(@"Right button pressed for ship %@", self.name);
    _posX = _posX + shipSpeed;
}
- (void)pressTopButton
{
    NSLog(@"Top button pressed for ship %@", self.name);
    _posY = _posY + shipSpeed;
}
- (void)pressBottomButton
{
    NSLog(@"Bottom button pressed for ship %@", self.name);
    _posY = _posY - shipSpeed;
}


@end
