//
//  Global.h
//  Visionear
//
//  Created by CPE KMUTT on 5/21/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSMutableArray *imgLoadArray;
extern NSString *imgPathToDl;
extern NSString *imgFile;

@interface Global : NSObject
{
    
}

-(NSMutableArray *)loadHelpImageArray;

@end
