//
//  ZKViewController.m
//  ZKRevealingTableViewCell
//
//  Created by Alex Zielenski on 4/29/12.
//  Copyright (c) 2012 Alex Zielenski.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense,  and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "ZKRevealingTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ZKRevealingTableViewController () {
	ZKRevealingTableViewCell *_currentlyRevealedCell;
}
@property (nonatomic, retain) NSArray *objects;
@end

@implementation ZKRevealingTableViewController

@synthesize objects;
@dynamic currentlyRevealedCell;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.objects = [NSArray arrayWithObjects:@"Right", @"Left", @"Both", @"None", nil];
	self.tableView = (UITableView *)self.view;
	self.tableView.rowHeight      = 52.0f;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Accessors

- (ZKRevealingTableViewCell *)currentlyRevealedCell
{
	return _currentlyRevealedCell;
}

- (void)setCurrentlyRevealedCell:(ZKRevealingTableViewCell *)currentlyRevealedCell
{
	if (_currentlyRevealedCell == currentlyRevealedCell)
		return;
	
	[_currentlyRevealedCell setRevealing:NO];
	
	if (_currentlyRevealedCell)
		[_currentlyRevealedCell autorelease];
	
	[self willChangeValueForKey:@"currentlyRevealedCell"];
	_currentlyRevealedCell = [currentlyRevealedCell retain];
	[self didChangeValueForKey:@"currentlyRevealedCell"];
}

#pragma mark - ZKRevealingTableViewCellDelegate

- (BOOL)cellShouldReveal:(ZKRevealingTableViewCell *)cell
{
	return YES;
}

- (void)cellDidReveal:(ZKRevealingTableViewCell *)cell
{
	NSLog(@"Revealed Cell with title: %@", cell.textLabel.text);
	self.currentlyRevealedCell = cell;
}

- (void)cellDidBeginPan:(ZKRevealingTableViewCell *)cell
{
	if (cell != self.currentlyRevealedCell)
		self.currentlyRevealedCell = nil;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	self.currentlyRevealedCell = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return (section == 0) ? @"Bounce" : @"No Bounce";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ZKRevealingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	
	if (!cell) {
		cell = [[[ZKRevealingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
		cell.delegate       = self;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		cell.backgroundView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	}
	
	cell.textLabel.text = [self.objects objectAtIndex:indexPath.row];
	cell.direction      = (ZKRevealingTableViewCellDirection)indexPath.row;
	cell.shouldBounce   = (BOOL)!indexPath.section;
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row = [indexPath row];
	if (row % 2 == 0) {
		cell.backgroundColor = [UIColor whiteColor];
	} else {
		cell.backgroundColor = [UIColor colorWithRed:0.892 green:0.893 blue:0.892 alpha:1.0];
	}
	
//	cell.contentView.backgroundColor = cell.backgroundColor;
}

@end
