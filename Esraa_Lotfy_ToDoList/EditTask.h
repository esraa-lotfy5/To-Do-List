//
//  EditTask.h
//  Esraa_Lotfy_ToDoList
//
//  Created by Esraa Lotfy  on 4/14/22.
//  Copyright © 2022 Esraa Lotfy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "Protocol.h"

@interface EditTask : UIViewController

@property Task* task;
@property NSString * selectionDate;
@property NSString * selectionState;
@property id<protocol> homeScreen;
@property int row;

@end

@interface EditTask (pickerViewCategory) <UIPickerViewDelegate, UIPickerViewDataSource>

@end
