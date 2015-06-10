//
//  Global.m
//  Visionear
//
//  Created by CPE KMUTT on 5/21/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"


NSMutableArray *imgLoadArray;
int nbRows;

@implementation Global


-(NSMutableArray *)loadHelpImageArray{

    NSInteger nbFrames[5] = {18, 38, 20, 15, 16};
    
    //Initialization of the different arrays
    imgLoadArray = [[NSMutableArray alloc] initWithCapacity:5];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:nbFrames[0]];
    
    //Loading all the pictures in for animated gif
    for(int i = 0; i < 5; i++){
        for(int cmpt2=0; cmpt2 < nbFrames[i]; cmpt2++){
            //NSLog(@"scene%d-frames/frame_%03d.gif added", i+1, cmpt2);
            [tempArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"scene%d-frames/frame_%03d.gif", i+1, cmpt2]]];
        }
        
        [imgLoadArray addObject:[[NSMutableArray alloc] initWithArray:tempArray]];
        [tempArray removeAllObjects];
    }

    return imgLoadArray;
}

@end
