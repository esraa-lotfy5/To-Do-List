//
//  AddNoteViewController.m
//  Esraa_Lotfy_ToDoList
//
//  Created by Esraa Lotfy  on 4/14/22.
//  Copyright © 2022 Esraa Lotfy . All rights reserved.
//

#import "AddNoteViewController.h"
#import "ViewController.h"

@interface AddNoteViewController ()
- (IBAction)saveButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *priortyPicker;
@property (weak, nonatomic) IBOutlet UITextView *addDescription;
@property (strong, nonatomic) IBOutlet UITextField *addName;

@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _priortyPicker.delegate =self;
    _priortyPicker.dataSource = self;
    _selection = @"low";
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 3;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = nil;
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
    return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (row) {
        case 0:
            _selection = @"low";
            break;
        case 1:
            _selection = @"mid";
            break;
        case 2:
            _selection = @"high";
            break;
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButton:(id)sender {
    //NSLog(@"from add : des:%@ , pr:%@ \n", [_addDescription text] ,_selection );
    [_FirstVC fillRow: [_addName text]:[_addDescription text] :_selection];
    [self.navigationController popViewControllerAnimated:YES];

}
@end
