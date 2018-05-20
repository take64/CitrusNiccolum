//
//  CNMediaItunes.m
//  CitrusNiccolum
//
//  Created by kouhei.takemoto on 2018/05/20.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CNMediaItunes.h"

#import "CNMediaObjectAudio.h"

#pragma mark - static variables
//
// static variables
//
static NSString * const kMediaSources= @"mediaSources";
static NSString * const kMediaGroup  = @"rootMediaGroup";
static NSString * const kMediaObjects= @"mediaObjects";



@interface CNMediaItunes()

@property MLMediaLibrary *library;
@property MLMediaSource *source;
@property MLMediaGroup *group;
@property NSMutableArray<CNMediaObjectAudio *> *mediaObjects;

@end



@implementation CNMediaItunes

//
// synthesize
//
@synthesize library;



#pragma mark - method
//
// method
//

// iTunesライブラリの読み込み
- (void)loadItunesLibrary
{
    // ライブラリ
    MLMediaLibrary *_library = [self callLibrary];
    [_library addObserver:self forKeyPath:kMediaSources options:NSKeyValueObservingOptionNew context:nil];
    [_library mediaSources];
}

// 通知受け取り
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    // 対象オブジェクト
    id value = [change objectForKey:NSKeyValueChangeNewKey];
    // メディアソースの取得
    if (object == [self library] && [keyPath isEqual:kMediaSources] == YES)
    {
        [self setSource:[value objectForKey:MLMediaSourceiTunesIdentifier]];
        [[self source] addObserver:self forKeyPath:kMediaGroup options:NSKeyValueObservingOptionNew context:nil];
        [[self source] rootMediaGroup];
    }
    // メディアグループの取得
    else if (object == [self source] && [keyPath isEqual:kMediaGroup] == YES)
    {
        [self setGroup:value];
        [[self group] addObserver:self forKeyPath:kMediaObjects options:NSKeyValueObservingOptionNew context:nil];
        [[self group] mediaObjects];
    }
    // メディアオブジェクトの取得
    else if (object == [self group] && [keyPath isEqual:kMediaObjects] == YES)
    {
        for (MLMediaObject *object in value)
        {
            [[self mediaObjects] addObject:
             [CNMediaObjectAudio newWithObject:object]
             ];
        }
        NSLog(@"end");
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



#pragma mark - caller
//
// caller
//

// MediaLibrary
- (MLMediaLibrary *)callLibrary
{
    if ([self library] == nil)
    {
        NSDictionary *options = @{
                                  MLMediaLoadSourceTypesKey   :@(MLMediaSourceTypeAudio),
                                  MLMediaLoadIncludeSourcesKey:@[MLMediaSourceiTunesIdentifier],
                                  };
        [self setLibrary:[[MLMediaLibrary alloc] initWithOptions:options]];
    }
    return [self library];
}

@end
