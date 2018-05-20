//
//  CNMediaObjectAudio.m
//  CitrusNiccolum
//
//  Created by kouhei.takemoto on 2018/05/20.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CNMediaObjectAudio.h"

@implementation CNMediaObjectAudio



//
// synthesize
//
@synthesize identifier;
@synthesize name;
@synthesize artworkImage;
@synthesize fileSize;

@synthesize trackId;
//@synthesize size;
@synthesize totalTime;
@synthesize discNumber;
@synthesize discCount;
@synthesize trackNumber;
@synthesize trackCount;
@synthesize year;
@synthesize dateModified;
@synthesize dateAdded;
@synthesize bitRate;
@synthesize sampleRate;
@synthesize compilation;
@synthesize persistantId;
@synthesize disabled;
@synthesize trackType;
@synthesize fileType;
@synthesize fileFolderCount;
@synthesize libraryFolderCount;
@synthesize artist;
@synthesize albumArtist;
@synthesize composer;
@synthesize album;
@synthesize genre;
@synthesize kind;
@synthesize location;



#pragma mark - method
//
// method
//

// メディアオブジェクト読み込み
- (void)loadObject:(MLMediaObject *)mediaObject
{
    [self setIdentifier:[mediaObject identifier]];
    [self setArtworkImage:[mediaObject artworkImage]];

    // 要素キーペア
    NSDictionary *parseKeys = [CNMediaObjectAudio callParseKeys];
    // 除外要素キー
    NSArray *ignoreKeys     = [CNMediaObjectAudio callIgnoreKeys];
    
    // パースする
    NSDictionary *attrs = [mediaObject attributes];
    for (NSString *attrKey in [attrs allKeys])
    {
        // 除外要素の場合
        if ([ignoreKeys containsObject:attrKey] == YES)
        {
            continue;
        }
        
        // 要素がある
        if ([[parseKeys allKeys] containsObject:attrKey] == YES)
        {
            NSString *newKey = [parseKeys objectForKey:attrKey];
            [self setValue:[attrs objectForKey:attrKey] forKey:newKey];
        }
        // 要素がない
        else
        {
            NSLog(@"none key = %@, value = %@", attrKey, [attrs objectForKey:attrKey]);
        }
    }
}



#pragma mark - static method
//
// static method
//

// メディアオブジェクトを読み込んで生成
+ (instancetype)newWithObject:(MLMediaObject *)mediaObject
{
    CNMediaObjectAudio *object = [self new];
    [object loadObject:mediaObject];
    return object;
}



#pragma mark - singleton
//
// singleton
//

// 要素キーペア
+ (NSDictionary *)callParseKeys
{
    static NSDictionary *parseKeys = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parseKeys = @{
                      @"Name"           :@"name",
                      @"fileSize"       :@"fileSize",
                      @"Sample Rate"    :@"sampleRate",
                      @"Kind"           :@"kind",
                      @"Track Number"   :@"trackNumber",
                      @"Track Count"    :@"trackCount",
                      @"Date Added"     :@"dateAdded",
                      @"Date Modified"  :@"dateModified",
                      @"Year"           :@"year",
                      @"Composer"       :@"composer",
                      @"Artist"         :@"artist",
                      @"Bit Rate"       :@"bitRate",
                      @"Track ID"       :@"trackId",
                      @"Total Time"     :@"totalTime",
                      @"Genre"          :@"genre",
                      @"URL"            :@"location",
                      @"Album"          :@"album",
                      };
    });
    return parseKeys;
}

// 除外要素キー
+ (NSArray *)callIgnoreKeys
{
    static NSArray *ignoreKeys = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ignoreKeys = @[
                       @"name",
                       @"identifier",
                       @"mediaSourceIdentifier",
                       @"modificationDate",
                       @"mediaType",
                       @"contentType",
                       @"Duration",
                       ];
    });
    return ignoreKeys;
}

@end
