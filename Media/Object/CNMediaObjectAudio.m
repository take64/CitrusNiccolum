//
//  CNMediaObjectAudio.m
//  CitrusNiccolum
//
//  Created by kouhei.takemoto on 2018/05/20.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CNMediaObjectAudio.h"

@implementation CNMediaObjectAudio

#pragma mark - synthesize
//
// synthesize
//
@synthesize trackId;
@synthesize trackType;
@synthesize trackNumber;
@synthesize trackCount;

//@synthesize identifier;
@synthesize name;
@synthesize artworkImage;
@synthesize fileSize;

//@synthesize size;
@synthesize totalTime;
@synthesize discNumber;
@synthesize discCount;
@synthesize year;
@synthesize dateModified;
@synthesize dateAdded;
@synthesize bitRate;
@synthesize sampleRate;
@synthesize compilation;
@synthesize persistantId;
@synthesize disabled;
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
//    [self setIdentifier:[mediaObject identifier]];
    [self setArtworkImage:[mediaObject artworkImage]];
    
//    if ([[self identifier] isEqualToString:@"3160F5D6408F5D9F"] == YES)
//    {
//        CFLog(@"%@", mediaObject);
//    }

    // 要素キーペア
    NSDictionary *parseKeys = [CNMediaObjectAudio callMediaObjectParseKeys];
    // 除外要素キー
    NSArray *ignoreKeys     = [CNMediaObjectAudio callMediaObjectIgnoreKeys];
    
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
            [self replaceValue:[attrs objectForKey:attrKey]  forKey:newKey];
        }
        // 要素がない
        else
        {
            CFLog(@"none key = %@, value = %@", attrKey, [attrs objectForKey:attrKey]);
        }
    }
}

// iTunes Library.xml読み込み
- (void)loadXml:(NSDictionary *)xmlDic
{
    // 要素キーペア
    NSDictionary *parseKeys = [CNMediaObjectAudio callItunesXmlParseKeys];
    // 除外要素キー
    NSArray *ignoreKeys     = [CNMediaObjectAudio callItunesXmlIgnoreKeys];
    
    // パースする
    NSDictionary *attrs = xmlDic;
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
            [self replaceValue:[attrs objectForKey:attrKey]  forKey:newKey];
        }
        // 要素がない
        else
        {
            CFLog(@"none key = %@, value = %@", attrKey, [attrs objectForKey:attrKey]);
        }
    }
}



#pragma mark - private
//
// private
//

// 要素の置き換え
- (void)replaceValue:(id)value forKey:(NSString *)key
{
    // 旧値の取得
    id oldValue = [self valueForKey:key];
    // 旧値がnilの場合は設定
    if (oldValue == nil)
    {
        [self setValue:value forKey:key];
    }
    else
    {
        // 比較のため文字列化
        NSString *newValueString = [NSString stringWithFormat:@"%@", value];
        NSString *oldValueString = [NSString stringWithFormat:@"%@", oldValue];
        if ([newValueString isEqualToString:oldValueString] == NO)
        {
            CFLog(@"not compare key = %@, old = %@, new = %@", key, oldValue, value);
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



#pragma mark - caller
//
// caller
//

// MLMediaObject要素キーペア
+ (NSDictionary *)callMediaObjectParseKeys
{
    static NSDictionary *parseKeys = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parseKeys = @{
                      @"Name"           :@"name",
                      @"fileSize"       :@"fileSize",
                      @"Sample Rate"    :@"sampleRate",
                      @"Kind"           :@"kind",
                      @"Track ID"       :@"trackId",
                      @"Track Number"   :@"trackNumber",
                      @"Track Count"    :@"trackCount",
                      @"Date Added"     :@"dateAdded",
                      @"Date Modified"  :@"dateModified",
                      @"Year"           :@"year",
                      @"Composer"       :@"composer",
                      @"Artist"         :@"artist",
                      @"Bit Rate"       :@"bitRate",
                      @"Total Time"     :@"totalTime",
                      @"Genre"          :@"genre",
                      @"URL"            :@"location",
                      @"Album"          :@"album",
                      };
    });
    return parseKeys;
}

// MLMediaObject除外要素キー
+ (NSArray *)callMediaObjectIgnoreKeys
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

// iTunesXml要素キーペア
+ (NSDictionary *)callItunesXmlParseKeys
{
    static NSDictionary *parseKeys = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parseKeys = @{
                      @"Track Type"     :@"trackType",
                      @"Sample Rate"    :@"sampleRate",
                      @"Disc Number"    :@"discNumber",
                      @"Kind"           :@"kind",
                      @"File Type"      :@"fileType",
                      @"Track Count"    :@"trackCount",
                      @"Date Added"     :@"dateAdded",
                      @"Name"           :@"name",
                      @"Track Number"   :@"trackNumber",
                      @"Size"           :@"fileSize",
                      @"Year"           :@"year",
                      @"Composer"       :@"composer",
                      @"Location"       :@"location",
                      @"Artist"         :@"artist",
                      @"Bit Rate"       :@"bitRate",
                      @"Disc Count"     :@"discCount",
                      @"Persistent ID"  :@"trackId",
                      @"Total Time"     :@"totalTime",
                      @"Date Modified"  :@"dateModified",
                      @"Album"          :@"album",
                      @"Genre"          :@"genre",
                      @"Disabled"       :@"disabled",
                      @"Compilation"    :@"compilation",
                      @"Album Artist"   :@"albumArtist",
                      };
    });
    return parseKeys;
}

// iTunesXml除外要素キー
+ (NSArray *)callItunesXmlIgnoreKeys
{
    static NSArray *ignoreKeys = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ignoreKeys = @[
                       @"Skip Date",
                       @"Play Date",
                       @"Play Date UTC",
                       @"Skip Count",
                       @"Play Count",
                       @"Artwork Count",
                       @"Library Folder Count",
                       @"File Folder Count",
                       @"Comments",
                       
                       @"Sort Composer",
                       @"Sort Artist",
                       @"Sort Album",
                       @"Sort Name",
                       @"Track ID",
                       ];
    });
    return ignoreKeys;
}

@end
