//
//  CNMediaItunes.h
//  CitrusNiccolum
//
//  Created by kouhei.takemoto on 2018/05/20.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MediaLibrary/MediaLibrary.h>

#import "CNMediaObjectAudio.h"

typedef NSString* CNMediaLibraryPropertyKey;
#define CNMediaLibraryPropertyKeyMediaSources   @"mediaSources"
#define CNMediaLibraryPropertyKeyMediaGroup     @"rootMediaGroup"
#define CNMediaLibraryPropertyKeyMediaObjects   @"mediaObjects"

@interface CNMediaItunes : NSObject
{
    MLMediaLibrary *library;
}

//
// property
//
@property (nonatomic, retain) MLMediaLibrary *library;


//
// method
//

// iTunesライブラリの読み込み
- (void)loadItunesLibrary;

@end