//
//  ZKRevealingTableViewCell.h
//  ZKRevealingTableViewCell
//
//  Created by Alex Zielenski on 4/29/12.
//  Copyright (c) 2012 Alex Zielenski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKRevealingTableViewCell;

typedef enum {
	ZKRevealingTableViewCellDirectionRight = 0,
	ZKRevealingTableViewCellDirectionLeft,
	ZKRevealingTableViewCellDirectionBoth,
	ZKRevealingTableViewCellDirectionNone,
} ZKRevealingTableViewCellDirection;

@protocol ZKRevealingTableViewCellDelegate <NSObject>

- (BOOL)cellShouldReveal:(ZKRevealingTableViewCell *)cell;
- (void)cellDidReveal:(ZKRevealingTableViewCell *)cell;

@end

@interface ZKRevealingTableViewCell : UITableViewCell

@property (nonatomic, assign, getter = isRevealing) BOOL revealing;
@property (nonatomic, assign) id <ZKRevealingTableViewCellDelegate> delegate;
@property (nonatomic, assign) ZKRevealingTableViewCellDirection direction;
@property (nonatomic, assign) BOOL shouldBounce;

@end
