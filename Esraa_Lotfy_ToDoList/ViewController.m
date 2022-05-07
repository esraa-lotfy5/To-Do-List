//
//  ViewController.m
//  Esraa_Lotfy_ToDoList
//
//  Created by Esraa Lotfy  on 4/14/22.
//  Copyright © 2022 Esraa Lotfy . All rights reserved.
//

#import "ViewController.h"
#import "Task.h"
#import "AddNoteViewController.h"
#import "NoteDetails.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UITableView *ToDoTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)addNewNoteButton:(id)sender;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //  table protocols
    self.ToDoTable.delegate = self;
    self.ToDoTable.dataSource = self;
    
    //  search bar protocols
    self.searchBar.delegate = self;
    
    self.searchTasksArray = [NSMutableArray new];
    self.tasks = [NSMutableArray new];
    _currentTask = [Task new];
    [_currentTask setName:@"First"];
    [_currentTask setPriorty:@"high"];
    [_currentTask setTaskDescription:@"Desciption"];
    [_currentTask setState:@"To Do"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [_currentTask setDate:[dateFormatter stringFromDate:[NSDate date]]];
    //[_currentTask setStateImage: [UIImage imageNamed:@"low-priority.png"]];
    [_tasks addObject: _currentTask];
    self.displayedTasks = [NSMutableArray arrayWithArray:self.tasks];
    self.searchTasksArray = [NSMutableArray arrayWithArray:self.tasks];
    //[self.displayedTasks addObjectsFromArray:self.tasks];
    printf("\n count: %lu \n", (unsigned long)_tasks.count);
}


- (IBAction)addNewNoteButton:(id)sender {}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"addNote"]){
        AddNoteViewController * addScreenObj = segue.destinationViewController;
        [addScreenObj setFirstVC:self];
    }
}

- (IBAction)segmentChange:(id)sender {
     printf("\n you are in segments \n");
    [self setTable];
}

- (void) setTable{
    printf("\n you are in segments \n");
    switch (self.segmentControl.selectedSegmentIndex) {
       //   all notes segment
       case 0:
            [self.displayedTasks removeAllObjects];
            [self.searchTasksArray removeAllObjects];
            printf("\n count: %lu \n", (unsigned long)_tasks.count);
            [self.displayedTasks addObjectsFromArray:self.tasks];
            [self.searchTasksArray addObjectsFromArray:self.tasks];
            [self.ToDoTable reloadData];
            break;
       //   low prioprty notes segment
       case 1:
            [self.displayedTasks removeAllObjects];
            [self.searchTasksArray removeAllObjects];
            for(int i =0 ; i< self.tasks.count ; i ++){
                if([[[self.tasks objectAtIndex:i] priorty] isEqualToString: @"low"]){
                    [self.displayedTasks addObject: self.tasks[i]];
                    [self.searchTasksArray addObject: self.tasks[i]];
                }
            }
        [self.ToDoTable reloadData];
        break;
       //   mid priopty notes segment
       case 2:
            [self.displayedTasks removeAllObjects];
            [self.searchTasksArray removeAllObjects];
            for(int i =0 ; i< self.tasks.count ; i ++){
                if([[[self.tasks objectAtIndex:i] priorty] isEqualToString: @"mid"]){
                    [self.displayedTasks addObject: self.tasks[i]];
                    [self.searchTasksArray addObject: self.tasks[i]];
                }
            }
            [self.ToDoTable reloadData];
            break;
       case 3:
            printf("segment three \n");
            [self.ToDoTable reloadData];
            break;
       case 4:
            printf("segment four \n");
            [self.ToDoTable reloadData];
            break;
       }
}

@end


//  table category
@implementation ViewController (ViewControllerTableCategory)

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     printf("\n you are in drawing cell \n");
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    NSLog(@"prioty %@ \n", [[self.displayedTasks objectAtIndex:indexPath.row] priorty]);
    cell.textLabel.text = [[self.displayedTasks objectAtIndex:indexPath.row] name];
    cell.imageView.image = [[self.displayedTasks objectAtIndex:indexPath.row] stateImage];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     printf("\n you are in count \n");
    return self.displayedTasks.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedTask = [Task new];
    NoteDetails *detailsScreenObj = [self.storyboard instantiateViewControllerWithIdentifier: @"details"];
    [detailsScreenObj setHomeScreen:self];
    [detailsScreenObj setRow: (int)indexPath.row];
    [detailsScreenObj setTask:[self.displayedTasks objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailsScreenObj animated: YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    printf("\n you are in delete \n");
    Task * selected = self.displayedTasks[indexPath.row];
    long index = [self.tasks indexOfObject: selected];
    NSLog(@"\n New Index %ld \n", index);
    [_tasks removeObjectAtIndex:index];
    [self setTable];
    [_ToDoTable reloadData];
}

@end


//  search bar category
@implementation ViewController (SearchBarCategory)

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    printf("You are in textDidChange \n");
    [self.displayedTasks removeAllObjects];
    NSLog(@"searchText: %@", searchText);
    if(searchText.length >0){
        printf("\n count: %lu \n", (unsigned long)self.searchTasksArray.count);
        for(int i =0; i<self.searchTasksArray.count; i++){
            //printf("%s", [[self.searchTasksArray[i] name] hasPrefix:searchText]);
            if([[self.searchTasksArray[i] name] hasPrefix:searchText]){
                [self.displayedTasks addObject: self.searchTasksArray[i]];
            }
        }
    }
    [self.ToDoTable reloadData];
}

//  called when user begin write in search bar or click on "x" in search bar
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    printf("You are in searchBarTextDidBeginEditing \n");
    searchBar.showsCancelButton = YES;
}

//  called immediately after searchBarSearchButtonClicked method called
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    printf("You are in searchBarTextDidEndEditing \n");
    [searchBar resignFirstResponder];
}

//  called when user click on cancel button in search bar
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    printf("You are in searchBarCancelButtonClicked \n");
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    [self setTable];
    [self.ToDoTable reloadData];
}

//  called when user clicked enter after finish writing im search bar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    printf("You are in searchBarSearchButtonClicked \n");
    [searchBar resignFirstResponder];
}
@end

//  protocol category
@implementation ViewController (ProtocolCategory)

-(void) fillRow: (NSString*)noteName :(NSString*)noteDesc :(NSString*) notePriorty{
    //NSLog(@"priorty: %@, description: \n ", notePriorty, noteDesc );
    Task *newTask = [Task new];
    [newTask setName: noteName];
    [newTask setPriorty: notePriorty];
    [newTask setTaskDescription: noteDesc];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    NSLog(@"Data %@",[dateFormatter stringFromDate:[NSDate date]]);
    [newTask setDate: [dateFormatter stringFromDate:[NSDate date]]];
    //[newTask setStateImage: [UIImage imageNamed:@"low-priority.png"]];
    [newTask setState:@"To Do"];
    NSLog(@"name %@",[newTask name]);
    [_tasks addObject: newTask];
    [self setTable];
    [_ToDoTable reloadData];
}

-(void) editNote: (Task*)task :(int)index{
    //NSLog(@" \n index: %d ,task title: %@ \n", index, [[_tasks objectAtIndex:index] name]);
    Task * selected = self.displayedTasks[index];
    long objectIndex = [self.tasks indexOfObject: selected];
    //NSLog(@"\n New Index %ld \n", objectIndex);
    [self.tasks replaceObjectAtIndex:objectIndex withObject:task];
    [self.ToDoTable reloadData];
}

@end
