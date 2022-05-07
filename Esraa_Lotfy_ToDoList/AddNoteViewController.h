//
//  AddNoteViewController.h
//  Esraa_Lotfy_ToDoList
//
//  Created by Esraa Lotfy  on 4/14/22.
//  Copyright © 2022 Esraa Lotfy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"


@interface AddNoteViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property id<protocol> FirstVC;
@property NSString *selection;

@end

