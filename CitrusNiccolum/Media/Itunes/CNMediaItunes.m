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
static NSString * const kMediaSources   = @"mediaSources";
static NSString * const kMediaGroup     = @"rootMediaGroup";
static NSString * const kMediaObjects   = @"mediaObjects";
static NSString * const kXmlTracks      = @"Tracks";


@interface CNMediaItunes()

@property MLMediaLibrary *library;
@property MLMediaSource *source;
@property MLMediaGroup *group;
@property NSMutableArray<CNMediaObjectAudio *> *mediaObjects;
@property CitrusFerrumCompleteBlock completeBlock;

@end



@implementation CNMediaItunes

#pragma mark - method
//
// method
//

// 初期化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setMediaObjects:[NSMutableArray new]];
    }
    return self;
}

// iTunesライブラリの読み込み
- (void)loadItunesLibraryWithComplete:(CitrusFerrumCompleteBlock)block;
{
    // ライブラリ
    MLMediaLibrary *_library = [self callLibrary];
    [_library addObserver:self forKeyPath:kMediaSources options:NSKeyValueObservingOptionNew context:nil];
    [_library mediaSources];
    // 実行ブロック
    [self setCompleteBlock:block];
}

// iTunesライブラリの読み込み(iTunes Library.xmlから)
- (void)loadItunesLibraryFromXml:(NSString *)xmlPath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:xmlPath] == NO)
    {
        CFLog(@"ない");
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:xmlPath];
//    CFLog(@"%@", dic[kXmlTracks]);
    
    for (id key in dic[kXmlTracks])
    {
//        CFLog(@"key = %@", key);
        NSDictionary *val = dic[kXmlTracks][key];
//        CFLog(@"val = %@", val);
        NSString *persistentId = [val objectForKey:@"Persistent ID"];
        CNMediaObjectAudio *mediaObject = [self searchOfTrackId:persistentId];
//        CFLog(@"%@", mediaObject);
        [mediaObject loadXml:val];
    }
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
        if (self.completeBlock != nil)
        {
            self.completeBlock();
        }
        
        // 通知を全て止める
        [[self library] removeObserver:self forKeyPath:kMediaSources];
        [[self source] removeObserver:self forKeyPath:kMediaGroup];
        [[self group] removeObserver:self forKeyPath:kMediaObjects];
        
        CFLog(@"end");
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



#pragma mark - method
//
// method
//

// mediaObjectsの検索
- (CNMediaObjectAudio *)searchOfTrackId:(NSString *)trackId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"trackId = %@", trackId];
    NSArray<CNMediaObjectAudio *> *results = [[self mediaObjects] filteredArrayUsingPredicate:predicate];
    if ([results count] > 0)
    {
        return [results objectAtIndex:0];
    }
    return nil;
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
