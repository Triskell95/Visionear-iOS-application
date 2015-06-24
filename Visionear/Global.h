//
//  Global.h
//  Visionear
//
//  Created by CPE KMUTT on 5/21/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NMSSH/NMSSH.h"
#import "NMSSH/NMSSHChannel.h"

extern NSMutableArray *imgLoadArray;
extern NSMutableArray *fileMainArray;
extern NSMutableArray *imgMainArray;
extern int nbRows;
extern int maxIndex;
extern NSString *hostIP, *username, *pwd;
extern NSString *defaultImgPathToDl, *defaultImgFile, *defaultImgName, *defaultFileName;
extern NMSSHSession *session;

@interface Global : NSObject
{
    
}

-(NSMutableArray *)loadHelpImageArray;
-(void)initArray:(NSMutableArray *)array setSize:(int)nbElements;

@end
