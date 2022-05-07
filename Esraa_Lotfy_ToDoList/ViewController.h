//
//  ViewController.h
//  Esraa_Lotfy_ToDoList
//
//  Created by Esraa Lotfy  on 4/14/22.
//  Copyright © 2022 Esraa Lotfy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "Protocol.h"

@interface ViewController: UIViewController

@property NSMutableArray * tasks;
@property NSMutableArray * displayedTasks;
@property NSMutableArray * searchTasksArray;
@property Task * currentTask;
@property Task *selectedTask;
@property long selectedSegment;

- (void) setTable;
@end

//  table category
@interface ViewController (ViewControllerTableCategory) <UITableViewDelegate, UITableViewDataSource>

@end

//  protocol category
@interface ViewController (ProtocolCategory) <protocol>

@end


//  search bar category
@interface ViewController (SearchBarCategory) <UISearchBarDelegate, UISearchDisplayDelegate>

@end
