//
//  EditTask.m
//  Esraa_Lotfy_ToDoList
//
//  Created by Esraa Lotfy  on 4/14/22.
//  Copyright © 2022 Esraa Lotfy . All rights reserved.
//

#import "EditTask.h"
#import "ViewController.h"

@interface EditTask ()
- (IBAction)editButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *priortyPicker;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation EditTask

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // conform data picker protocols
    self.priortyPicker.dataSource = self;
    self.priortyPicker.delegate = self;
    self.statePicker.dataSource = self;
    self.statePicker.delegate = self;
    
    //  addDescriptio UITextView border
    self.descriptionField.layer.borderWidth = 0.5;
    self.descriptionField.layer.cornerRadius = 10;
    self.descriptionField.layer.borderColor = UIColor.systemGray5Color.CGColor;
    
    // set fields
    self.nameField.text = [_task name];
    self.descriptionField.text = [_task taskDescription];
    
    if([self.task.priorty isEqualToString:@"low"]){
        printf("low");
        _selectionDate = @"low";
        [self.priortyPicker selectRow:0 inComponent:0 animated:YES];
    }else{
        if([self.task.priorty isEqualToString:@"mid"]){
            printf("mid");
            _selectionDate = @"mid";
            [self.priortyPicker selectRow:1 inComponent:0 animated:YES];
        }else{
            if([self.task.priorty isEqualToString:@"high"]){
                printf("high");
                _selectionDate = @"high";
                [self.priortyPicker selectRow:2 inComponent:0 animated:YES];
            }
        }
    }
    if([self.task.taskState isEqualToString:@"To Do"]){
        _selectionState = @"To Do";
        [self.statePicker selectRow:0 inComponent:0 animated:YES];
    }else{
        if([self.task.taskState isEqualToString:@"In Progress"]){
            _selectionState = @"In Progress";
            [self.statePicker selectRow:1 inComponent:0 animated:YES];
        }else{
            if([self.task.taskState isEqualToString:@"Done"]){
                _selectionState = @"Done";
                [self.statePicker selectRow:2 inComponent:0 animated:YES];
            }
        }
    }
}



- (IBAction)editButton:(id)sender {
    //Task * task = [Task new];
    _task.name = [_nameField text];
    _task.taskDescription = [_descriptionField text];
    _task.taskState = _selectionState;
    _task.priorty = _selectionDate;
    [self.homeScreen editNote:_task :_row];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)editNote:(Task *)task :(int)index {}

@end


@implementation EditTask (pickerViewCategory)


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 3;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = nil;
    
    switch (pickerView.tag) {
        case 1:
            switch (row) {
                case 0:
                    title = @"low";
                    break;
                case 1:
                    title = @"mid";
                    break;
                case 2:
                    title = @"high";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (row) {
                case 0:
                    title = @"To Do";
                    break;
                case 1:
                    title = @"In Progress";
                    break;
                case 2:
                    title = @"Done";
                    break;
                default:
                    break;
            }
            
        default:
            break;
    }
    return title;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag == 1){
        switch (row) {
            case 0:
                _selectionDate = @"low";
                break;
            case 1:
                _selectionDate = @"mid";
                break;
            case 2:
                _selectionDate = @"high";
                break;
            default:
                break;
        }
    }
    if(pickerView.tag == 2){
        switch (row) {
            case 0:
                _selectionState = @"To Do";
                break;
            case 1:
                _selectionState = @"In Progress";
                break;
            case 2:
                _selectionState = @"Done";
                break;
            default:
                break;
        }
    }
}

@end
