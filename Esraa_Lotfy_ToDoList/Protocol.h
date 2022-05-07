//
//  Protocol.h
//  Esraa_Lotfy_ToDoList
//
//  Created by Esraa Lotfy  on 4/14/22.
//  Copyright © 2022 Esraa Lotfy . All rights reserved.
//

#import "Task.h"

@protocol protocol <NSObject>
-(void) fillRow:(NSString*)noteName :(NSString*)noteDesc :(NSString*)notePriorty;

-(void) editNote: (Task*)task :(int)index;
@end
