//
//  CNCCursor.h
//  CitrusNiccolum
//
//  Created by kouhei.takemoto on 2019/10/06.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCCursor : NSObject



// カーソルを一つ上に移動
+ (void) moveUp;

// カーソルをnつ上に移動
+ (void) moveUp:(int)n;

// カーソルを一つ下に移動
+ (void) moveDown;

// カーソルをnつ下に移動
+ (void) moveDown:(int)n;

// カーソルを一つ右に移動
+ (void) moveRight;

// カーソルをnつ右に移動
+ (void) moveRight:(int)n;

// カーソルを一つ左に移動
+ (void) moveLeft;

// カーソルをnつ左に移動
+ (void) moveLeft:(int)n;



@end

NS_ASSUME_NONNULL_END
