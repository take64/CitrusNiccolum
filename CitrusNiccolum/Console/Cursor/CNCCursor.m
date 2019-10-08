//
//  CNCCursor.m
//  CitrusNiccolum
//
//  Created by kouhei.takemoto on 2019/10/06.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CNCCursor.h"

@implementation CNCCursor



#pragma mark - static public method
//
// static public method
//

// カーソルを一つ上に移動
+ (void) moveUp
{
    [self moveUp:1];
}

// カーソルをnつ上に移動
+ (void) moveUp:(int)n
{
    [self pushCommand:[NSString stringWithFormat:@"\033[%dA", n]];
}

// カーソルを一つ下に移動
+ (void) moveDown
{
    [self moveDown:1];
}

// カーソルをnつ下に移動
+ (void) moveDown:(int)n
{
    [self pushCommand:[NSString stringWithFormat:@"\033[%dB", n]];
}

// カーソルを一つ右に移動
+ (void) moveRight
{
    [self moveRight:1];
}

// カーソルをnつ右に移動
+ (void) moveRight:(int)n
{
    [self pushCommand:[NSString stringWithFormat:@"\033[%dC", n]];
}

// カーソルを一つ左に移動
+ (void) moveLeft
{
    [self moveLeft:1];
}

// カーソルをnつ左に移動
+ (void) moveLeft:(int)n
{
    [self pushCommand:[NSString stringWithFormat:@"\033[%dD", n]];
}



#pragma mark - static private method
//
// static private method
//

// コンソールにコマンドを送信
+ (void) pushCommand:(NSString *)commond
{
    printf("%s", [commond UTF8String]);
}


@end
