//
//  Main2ViewController.m
//  Visionear
//
//  Created by CPE KMUTT on 5/19/2558 BE.
//  Copyright (c) 2558 CPE KMUTT. All rights reserved.
//

#import "Main2ViewController.h"
#import "NMSSH/NMSSH.h"
#import "NMSSH/NMSSHChannel.h"
#import "MainCustomCell.h"
#import "Global.h"
#import "Main3ViewController.h"

@interface Main2ViewController () <NMSSHChannelDelegate, NMSSHSessionDelegate>

@end

@implementation Main2ViewController

@synthesize tableView;
@synthesize navBar2;

int r;
int indexToSegue;
UIImage *imgToSegue;
UIImagePickerController *picker;
UIAlertView *alert3;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Display NavigationBar, hidden in the previous view
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //Simple affectation of the number of rows in the tableview
    r = nbRows;
    
    alert3 = [[UIAlertView alloc] initWithTitle:@"Uploading the photo\rPlease wait..."message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Setting the number of rows in the tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return r;
}

//Setting the content of each row in the tableView
- (UITableViewCell *)tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *SimpleIdentifier = @"Cell";
    
    MainCustomCell *cell = [tabView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    //Initializing the cell, when doesn't already exists
    if(cell == nil) {
        cell = [[MainCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    
    //Setting of the label
    cell.cellLabel.text = [fileMainArray objectAtIndex: indexPath.row];
    cell.imgView.image = [self loadImage:[imgMainArray objectAtIndex:indexPath.row]];
    NSLog(@"imgMainArray:\r%@",[imgMainArray objectAtIndex:indexPath.row]);
    
    return cell;
}

//When the user selects a row
-(void)tableView:(UITableView *)tabView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCustomCell *cell = (MainCustomCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    //Here we save some data to send it by segue to the next view
    indexToSegue = (int)indexPath.row;
    imgToSegue = cell.imgView.image;
    
    //Perform the segue
    [self performSegueWithIdentifier:@"rowSelected" sender:self.view];
    
    //Dismiss the highlight of the cell
    [cell setSelected:NO];
}

//Load an image, previously downloaded from the RPi
- (UIImage*)loadImage:(NSString *) name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:name];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"rowSelected"]){
        Main3ViewController *controller = [segue destinationViewController];
        
        controller.indexFromSegue = indexToSegue;
        controller.img = imgToSegue;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)TakePhoto:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    [alert3 show];
    
    imgToSegue = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    indexToSegue = 0;
    
    [self saveNewImage];
    
    //Perform the segue
    //[self performSegueWithIdentifier:@"rowSelected" sender:self.view];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)saveNewImage {
    
    maxIndex ++;
    
    NSString *str = [NSString stringWithFormat:@"%@%@%i", defaultImgPathToDl, defaultImgName, maxIndex];
    [fileMainArray insertObject:str atIndex:0];
    NSLog(@"fileMainArray capacity: %i", (int) fileMainArray.count);
    
    str = [NSString stringWithFormat:@"%@%i.png", defaultImgName, maxIndex];
    NSLog(@"\r%@\r", str);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:str];
    
    [session.channel uploadFile:filePath to:[NSString stringWithFormat:@"%@%@%i",defaultImgPathToDl, defaultImgName, maxIndex]];
    
    [UIImagePNGRepresentation(imgToSegue) writeToFile:filePath atomically:YES];
    [imgMainArray insertObject:str atIndex:0];
    
    r++;
    nbRows++;
    
    [alert3 dismissWithClickedButtonIndex:0 animated:YES];
    
}

@end
