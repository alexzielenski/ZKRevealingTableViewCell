//
//  ZKRevealingTableViewController.h
//  ZKRevealingTableViewCell
//
//  Created by Alex Zielenski on 4/29/12.
//  Copyright (c) 2012 Alex Zielenski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKRevealingTableViewCell.h"

@interface ZKRevealingTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, ZKRevealingTableViewCellDelegate>
@property (nonatomic, retain) ZKRevealingTableViewCell *currentlyRevealedCell;
@end
