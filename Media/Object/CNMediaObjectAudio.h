//
//  CNMediaObjectAudio.h
//  CitrusNiccolum
//
//  Created by kouhei.takemoto on 2018/05/20.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MediaLibrary/MediaLibrary.h>

@interface CNMediaObjectAudio : NSObject
{
    NSString *identifier;
    NSString *name;
    NSImage *artworkImage;
    NSNumber *fileSize;
    
    NSNumber *trackId;
//    NSNumber *size;
    NSNumber *totalTime;
    NSNumber *discNumber;
    NSNumber *discCount;
    NSNumber *trackNumber;
    NSNumber *trackCount;
    NSNumber *year;
    NSDate *dateModified;
    NSDate *dateAdded;
    NSNumber *bitRate;
    NSNumber *sampleRate;
    NSNumber *compilation;
    NSString *persistantId;
    NSNumber *disabled;
    NSString *trackType;
    NSNumber *fileType;
    NSNumber *fileFolderCount;
    NSNumber *libraryFolderCount;
    NSString *artist;
    NSString *albumArtist;
    NSString *composer;
    NSString *album;
    NSString *genre;
    NSString *kind;
    NSString *location;
}



//
// property
//
@property(nonatomic, retain) NSString *identifier;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSImage *artworkImage;
@property(nonatomic, retain) NSNumber *fileSize;

@property(nonatomic, retain) NSNumber *trackId;
//@property(nonatomic, retain) NSNumber *size;
@property(nonatomic, retain) NSNumber *totalTime;
@property(nonatomic, retain) NSNumber *discNumber;
@property(nonatomic, retain) NSNumber *discCount;
@property(nonatomic, retain) NSNumber *trackNumber;
@property(nonatomic, retain) NSNumber *trackCount;
@property(nonatomic, retain) NSNumber *year;
@property(nonatomic, retain) NSDate *dateModified;
@property(nonatomic, retain) NSDate *dateAdded;
@property(nonatomic, retain) NSNumber *bitRate;
@property(nonatomic, retain) NSNumber *sampleRate;
@property(nonatomic, retain) NSNumber *compilation;
@property(nonatomic, retain) NSString *persistantId;
@property(nonatomic, retain) NSNumber *disabled;
@property(nonatomic, retain) NSString *trackType;
@property(nonatomic, retain) NSNumber *fileType;
@property(nonatomic, retain) NSNumber *fileFolderCount;
@property(nonatomic, retain) NSNumber *libraryFolderCount;
//@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *artist;
@property(nonatomic, retain) NSString *albumArtist;
@property(nonatomic, retain) NSString *composer;
@property(nonatomic, retain) NSString *album;
@property(nonatomic, retain) NSString *genre;
@property(nonatomic, retain) NSString *kind;
@property(nonatomic, retain) NSString *location;



//
// method
//

// メディアオブジェクト読み込み
- (void)loadObject:(MLMediaObject *)mediaObject;



//
// static method
//

// メディアオブジェクトを読み込んで生成
+ (instancetype)newWithObject:(MLMediaObject *)mediaObject;

@end
