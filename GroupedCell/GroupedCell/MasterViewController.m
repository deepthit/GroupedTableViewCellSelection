//
//  MasterViewController.m
//  GroupedCell
//
//  Created by Deepthi Tayi on 29/10/13.
//  Copyright (c) 2013 D.T. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
  NSArray *items;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    self.title = NSLocalizedString(@"Master", @"Master");
      items = [[NSArray alloc] initWithObjects:@"Test1", @"Test2" , @"Test3", nil];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
  [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
  [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return items.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

  CGRect rect = CGRectMake(0, 0, CGRectGetWidth(cell.bounds) - 20, CGRectGetHeight(cell.bounds));
  cell.selectedBackgroundView = [[UIView alloc] initWithFrame:rect];
  cell.selectedBackgroundView.backgroundColor = [UIColor redColor];
  
  if (indexPath.row == 0 ||
      indexPath.row == items.count - 1)
  {
    UIRectCorner corners = ((indexPath.row == 0)
                            ? (UIRectCornerTopLeft | UIRectCornerTopRight)
                            : (UIRectCornerBottomLeft | UIRectCornerBottomRight));
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:cell.selectedBackgroundView.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(8.0f, 8.0f)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    cell.selectedBackgroundView.layer.mask = shape;
    rounded = nil;
    shape = nil;    
  }
    
  cell.textLabel.text = [items objectAtIndex:indexPath.row];
    return cell;
}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  NSIndexPath *currentSelectedIndexPath = [tableView indexPathForSelectedRow];
//  if (currentSelectedIndexPath != nil)
//  {
//    [[tableView cellForRowAtIndexPath:currentSelectedIndexPath] setBackgroundColor:[UIColor whiteColor]];
//  }
//  
//  return indexPath;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  if (cell.isSelected == YES)
//  {
//    [cell setBackgroundColor:[UIColor redColor]];
//  }
//  else
//  {
//    [cell setBackgroundColor:[UIColor whiteColor]];
//  }
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //[[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor redColor]];
  
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    NSDate *object = _objects[indexPath.row];
    self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
