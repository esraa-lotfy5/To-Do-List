//
//  NoteDetails.m
//  Esraa_Lotfy_ToDoList
//
//  Created by Esraa Lotfy  on 4/14/22.
//  Copyright © 2022 Esraa Lotfy . All rights reserved.
//

#import "NoteDetails.h"
#import "EditTask.h"

@interface NoteDetails ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)editButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priortyField;
@property (weak, nonatomic) IBOutlet UILabel *descriptionField;
@property (weak, nonatomic) IBOutlet UILabel *nameField;

@end

@implementation NoteDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameField.text = [_task name];
    _priortyField.text =[_task priorty];
    _descriptionField.text =[_task taskDescription];
    _stateLabel.text = [_task state];
    _dateLabel.text = [_task date];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EditTask * editScreenObj = segue.destinationViewController;
    [editScreenObj setTask:_task];
    [editScreenObj setHomeScreen:_homeScreen];
    [editScreenObj setRow:_row];
}

- (IBAction)editButton:(id)sender {}
@end
