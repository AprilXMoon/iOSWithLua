//
//  ViewController.m
//  firstLua
//
//  Created by April Lee on 2015/9/30.
//  Copyright © 2015年 april. All rights reserved.
//

#import "ViewController.h"
#import "ShipController.h"


ShipController *playerShipController;
ShipController *enemyShipController;

@interface ViewController ()

@end

static int player_ship_position(lua_State *L)
{
    lua_pushnumber(L, playerShipController.posX);
    lua_pushnumber(L, playerShipController.posY);
    
    return 2;
}

static int press_right_button(lua_State *L) {
    ShipController *sc = (__bridge ShipController *)(lua_touserdata(L, 1));
    [sc pressBottomButton];
    return 0;
}

static int press_left_button(lua_State *L) {
    ShipController *sc = (__bridge ShipController *)(lua_touserdata(L, 1));
    [sc pressLeftButton];
    return 0;
}

static int press_top_button(lua_State *L) {
    ShipController *sc = (__bridge ShipController *)(lua_touserdata(L, 1));
    [sc pressTopButton];
    return 0;
}

static int press_bottom_button(lua_State *L) {
    ShipController *sc = (__bridge ShipController *)(lua_touserdata(L, 1));
    [sc pressBottomButton];
    return 0;
}

static int get_ship_position(lua_State *L) {
    ShipController *sc = (__bridge ShipController *)(lua_touserdata(L, 1));
    
    //push x and y position on the stack
    lua_pushnumber(L, sc.posX);
    lua_pushnumber(L, sc.posY);
    
    //let the caller know how many results are available on the stack
    return 2;
}


static const struct luaL_Reg shiplib_f [] = {
    {"player_ship_position", player_ship_position},
    {"press_right_button", press_right_button},
    {"press_left_button", press_left_button},
    {"press_top_button", press_top_button},
    {"press_bottom_button", press_bottom_button},
    {"get_ship_position", get_ship_position},
    {NULL,NULL}
};

int luaopen_mylib (lua_State *L) {
    lua_newtable(L);
    luaL_setfuncs(L, shiplib_f, 0);
    return 1;
}
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    playerShipController = [[ShipController alloc] initWithX:100 Y:100 Speed:2.0 Name:@"player_ship"];
    enemyShipController = [[ShipController alloc] initWithX:105 Y:102 Speed:1.0 Name:@"enemy_ship"];
    
    // initialize Lua and our load our lua file
    
    Lua = luaL_newstate();  //create a new state structure for the interpreter
    luaL_openlibs(Lua);     //load all the basic libraries into the interpreter
    
    lua_settop(Lua, 0);
    
    int err;
    
    NSString *luaFilePath = [[NSBundle mainBundle] pathForResource:@"enemy_ship" ofType:@"lua"];
    err = luaL_loadfile(Lua, [luaFilePath cStringUsingEncoding:[NSString defaultCStringEncoding]]);
    
    if (0 != err) {
        luaL_error(Lua, "cannot compile lua file: %s",lua_tostring(Lua, -1));
        return;
    }
    
    err =  lua_pcall(Lua, 0, 0, 0);
    if (0 != err) {
        luaL_error(Lua, "cannot run lua file: %s",lua_tostring(Lua, -1));
        return;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runLoop:) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runLoop:(id)sender
{
    NSLog(@"Player ship at (%f,%f)",playerShipController.posX, playerShipController.posY);
    
    // put the pointer to the lua function we want on top of the stack
    lua_getglobal(Lua, "process");
    
    lua_pushlightuserdata(Lua, (__bridge void *)(enemyShipController));
    
    //call the function on top of the stack
    int err = lua_pcall(Lua, 1, 0, 0);
    
    if (0 != err) {
        luaL_error(Lua, "cannot run lua file: %s", lua_tostring(Lua, -1));
        return;
    }
    
    NSLog(@"%@ at (%f,%f)", playerShipController.name, playerShipController.posX, playerShipController.posY);
    NSLog(@"%@ ship at (%f,%f)", enemyShipController.name, enemyShipController.posX, playerShipController.posY);
}

- (IBAction)pressLeftButton:(id)sender
{
    [playerShipController pressLeftButton];
}

- (IBAction)pressRightButton:(id)sender
{
    [playerShipController pressRightButton];
}

- (IBAction)pressTopButton:(id)sender
{
    [playerShipController pressTopButton];
}

- (IBAction)pressBottomButton:(id)sender
{
    [playerShipController pressBottomButton];
}

@end
