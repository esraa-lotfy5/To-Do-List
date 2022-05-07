//
//  Task.h
//  Esraa_Lotfy_ToDoList
//
//  Created by Esraa Lotfy  on 4/14/22.
//  Copyright © 2022 Esraa Lotfy . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Task : NSObject

@property NSString * name;
@property NSString * taskDescription;
@property NSString * priorty;
@property NSString * date;
@property UIImage * stateImage;
@property NSString * state;

@end

