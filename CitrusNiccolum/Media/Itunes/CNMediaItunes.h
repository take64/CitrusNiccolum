//
//  CNMediaItunes.h
//  CitrusNiccolum
//
//  Created by kouhei.takemoto on 2018/05/20.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MediaLibrary/MediaLibrary.h>

#import <CitrusFerrum/CitrusFerrumTypedef.h>

@interface CNMediaItunes : NSObject

//
// method
//

// iTunesライブラリの読み込み
- (void)loadItunesLibraryWithComplete:(CitrusFerrumCompleteBlock)block;

// iTunesライブラリの読み込み(iTunes Library.xmlから)
- (void)loadItunesLibraryFromXml:(NSString *)xmlPath;

@end
