//
//  ViewController.h
//  firstLua
//
//  Created by April Lee on 2015/9/30.
//  Copyright © 2015年 april. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

@interface ViewController : UIViewController
{
    lua_State *Lua;
    NSTimer *timer;
}

- (IBAction)pressLeftButton:(id)sender;
- (IBAction)pressRightButton:(id)sender;
- (IBAction)pressTopButton:(id)sender;
- (IBAction)pressBottomButton:(id)sender;

@end

