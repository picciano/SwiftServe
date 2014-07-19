//
//  NSData+BaristaExtensions.h
//  Barista
//
//  Created by Steve Streza on 4/28/13.
//  Copyright (c)barista_2013 Mustacheware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (BaristaExtensions)

// ZLIB
- (NSData *)barista_zlibInflate;
- (NSData *)barista_zlibDeflate;

// GZIP
- (NSData *)barista_gzipInflate;
- (NSData *)barista_gzipDeflate;

@end
