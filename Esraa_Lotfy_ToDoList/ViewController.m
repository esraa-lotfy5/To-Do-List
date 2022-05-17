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
    
    //  UI
    //1. Navigation controller
    self.navigationItem.title = @"Tasks";
    
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
    [_currentTask setTaskState:@"To Do"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [_currentTask setDate:[dateFormatter stringFromDate:[NSDate date]]];
    [_tasks addObject: _currentTask];
    self.displayedTasks = [NSMutableArray arrayWithArray:self.tasks];
    self.searchTasksArray = [NSMutableArray arrayWithArray:self.tasks];
}


- (IBAction)addNewNoteButton:(id)sender {}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"addNote"]){
        AddNoteViewController * addScreenObj = segue.destinationViewController;
        [addScreenObj setFirstVC:self];
    }
}

- (IBAction)segmentChange:(id)sender {
    [self setTable];
}

- (void) setTable{
    switch (self.segmentControl.selectedSegmentIndex) {
       //   all notes segment
       case 0:
            [self.displayedTasks removeAllObjects];
            [self.searchTasksArray removeAllObjects];
            [self.displayedTasks addObjectsFromArray:self.tasks];
            [self.searchTasksArray addObjectsFromArray:self.tasks];
            [self.ToDoTable reloadData];
            break;
       //   to do notes segment
       case 1:
            [self.displayedTasks removeAllObjects];
            [self.searchTasksArray removeAllObjects];
            for(int i =0 ; i< self.tasks.count ; i ++){
                if([[[self.tasks objectAtIndex:i] taskState] isEqualToString: @"To Do"]){
                    [self.displayedTasks addObject: self.tasks[i]];
                    [self.searchTasksArray addObject: self.tasks[i]];
                }
            }
        [self.ToDoTable reloadData];
        break;
       //   in progress notes segment
       case 2:
            [self.displayedTasks removeAllObjects];
            [self.searchTasksArray removeAllObjects];
            for(int i =0 ; i< self.tasks.count ; i ++){
                if([[[self.tasks objectAtIndex:i] taskState] isEqualToString: @"In Progress"]){
                    [self.displayedTasks addObject: self.tasks[i]];
                    [self.searchTasksArray addObject: self.tasks[i]];
                }
            }
            [self.ToDoTable reloadData];
            break;
        //  done notes segment
       case 3:
        [self.displayedTasks removeAllObjects];
        [self.searchTasksArray removeAllObjects];
        for(int i =0 ; i< self.tasks.count ; i ++){
           if([[[self.tasks objectAtIndex:i] taskState] isEqualToString: @"Done"]){
               [self.displayedTasks addObject: self.tasks[i]];
               [self.searchTasksArray addObject: self.tasks[i]];
            }
        }
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    //  for cell corner radius
    cell.layer.cornerRadius = 25;
    cell.layer.masksToBounds = YES;
    //  cell text
    cell.textLabel.text = [[self.displayedTasks objectAtIndex:indexPath.row] name];
    //  cell image
    if([[[self.displayedTasks objectAtIndex:indexPath.row] priorty] isEqualToString: @"low"]){
        cell.imageView.image = [UIImage systemImageNamed:@"arrow.down.circle"];
        cell.imageView.tintColor = UIColor.yellowColor;
    }else{
        if([[[self.displayedTasks objectAtIndex:indexPath.row] priorty] isEqualToString: @"mid"]){
            cell.imageView.image = [UIImage systemImageNamed:@"minus.circle"];
            cell.imageView.tintColor = UIColor.greenColor;
        }else{
            if([[[self.displayedTasks objectAtIndex:indexPath.row] priorty] isEqualToString: @"high"]){
                cell.imageView.image = [UIImage systemImageNamed:@"arrow.up.circle"];
                cell.imageView.tintColor = UIColor.redColor;
            }
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
    Task * selected = self.displayedTasks[indexPath.row];
    long index = [self.tasks indexOfObject: selected];
    [_tasks removeObjectAtIndex:index];
    [self setTable];
    [_ToDoTable reloadData];
}

@end


//  search bar category
@implementation ViewController (SearchBarCategory)

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.displayedTasks removeAllObjects];
    if(searchText.length >0){
        for(int i =0; i<self.searchTasksArray.count; i++){
            if([[self.searchTasksArray[i] name] hasPrefix:searchText]){
                [self.displayedTasks addObject: self.searchTasksArray[i]];
            }
        }
    }
    [self.ToDoTable reloadData];
}

//  called when user begin write in search bar or click on "x" in search bar
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
}

//  called immediately after searchBarSearchButtonClicked method called
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

//  called when user click on cancel button in search bar
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    [self setTable];
    [self.ToDoTable reloadData];
}

//  called when user clicked enter after finish writing im search bar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
@end

//  protocol category
@implementation ViewController (ProtocolCategory)

-(void) fillRow: (NSString*)noteName :(NSString*)noteDesc :(NSString*) notePriorty{
    Task *newTask = [Task new];
    [newTask setName: noteName];
    [newTask setPriorty: notePriorty];
    [newTask setTaskDescription: noteDesc];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    [newTask setDate: [dateFormatter stringFromDate:[NSDate date]]];
    [newTask setTaskState:@"To Do"];
    [_tasks addObject: newTask];
    [self setTable];
    [_ToDoTable reloadData];
}

-(void) editNote: (Task*)task :(int)index{
    Task * selected = self.displayedTasks[index];
    long objectIndex = [self.tasks indexOfObject: selected];
    [self.tasks replaceObjectAtIndex:objectIndex withObject:task];
    [self.ToDoTable reloadData];
}

@end
