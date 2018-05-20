//
//  CNMediaItunes.m
//  CitrusNiccolum
//
//  Created by kouhei.takemoto on 2018/05/20.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CNMediaItunes.h"

@interface CNMediaItunes()

//@property MLMediaLibrary *library;
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
    [_library addObserver:self forKeyPath:CNMediaLibraryPropertyKeyMediaSources options:NSKeyValueObservingOptionNew context:nil];
    [_library mediaSources];
}

// 通知受け取り
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    // メディアソースの取得
    if (object == [self library] && [keyPath isEqual:CNMediaLibraryPropertyKeyMediaSources] == YES)
    {
        id value = [change objectForKey:NSKeyValueChangeNewKey];
        [self setSource:[value objectForKey:MLMediaSourceiTunesIdentifier]];
        [[self source] addObserver:self forKeyPath:CNMediaLibraryPropertyKeyMediaGroup options:NSKeyValueObservingOptionNew context:nil];
        [[self source] rootMediaGroup];
    }
    // メディアグループの取得
    else if (object == [self source] && [keyPath isEqual:CNMediaLibraryPropertyKeyMediaGroup] == YES)
    {
        id value = [change objectForKey:NSKeyValueChangeNewKey];
        [self setGroup:value];
        [[self group] addObserver:self forKeyPath:CNMediaLibraryPropertyKeyMediaObjects options:NSKeyValueObservingOptionNew context:nil];
        [[self group] mediaObjects];
    }
    // メディアオブジェクトの取得
    else if (object == [self group] && [keyPath isEqual:CNMediaLibraryPropertyKeyMediaObjects] == YES)
    {
        id value = [change objectForKey:NSKeyValueChangeNewKey];
        for (MLMediaObject *object in value)
        {
            CNMediaObjectAudio *_mediaObjectAudio = [[CNMediaObjectAudio alloc] init];
            [_mediaObjectAudio loadObject:object];
            [[self mediaObjects] addObject:_mediaObjectAudio];
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
