ZKRevealingTableViewCell
========================

A Sparrow-style Implementation of Swipe-To-Reveal

---

Sparrow for iOS has a different kind of swipe to reveal; its version of the control is that the content view pans with your finger or optionally could swipe.

This Swipe-To-Reveal implementation ***will*** pan with your finger and can swipe. It works **left**, **right**, or **left and right**.

---

Here's a preview:

![image](https://github.com/alexzielenski/ZKRevealingTableViewCell/blob/master/Preview.png?raw=true)

---

Usage
===

Simply link `QuartzCore.framework` and use the [`ZKRevealingTableViewCell`](https://github.com/alexzielenski/ZKRevealingTableViewCell/blob/master/ZKRevealingTableViewCell/ZKRevealingTableViewCell.h) class for your [`UITableViewCell`](http://developer.apple.com/library/ios/#documentation/uikit/reference/UITableViewCell_Class/Reference/Reference.html). To change the reveal view, simply modify the `backView` property of the cell.

```objc
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ZKRevealingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	
	if (!cell) {
		cell = [[[ZKRevealingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
		cell.delegate       = self;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	return cell;
	
}
```

If you want only one item selected at a time, you could do something like this in UITableViewController subclass:

```objc
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

- (BOOL)cellShouldReveal:(ZKRevealingTableViewCell *)cell {
	return YES;
}

- (void)cellDidReveal:(ZKRevealingTableViewCell *)cell {
	NSLog(@"Revealed Cell with title: %@", cell.textLabel.text);
	self.currentlyRevealedCell = cell;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	self.currentlyRevealedCell = nil;
}
```

To programmatically reveal/hide the `backView`, set the `revealing` property.

```objc
// Reveal the backView
cell.revealing = YES;

// Hide the backView
cell.revealing = NO;
```

### Changing the backgroundColor

You may have trouble changing the background color of your `ZKRevealingTableViewCell` instance. The issue that happens is that the contentView's white background color is appearing on the edges of the cell. To fix this just change the contentView's background with the cell's background at the same time.


---

License
===
This is licensed under MIT. Here is some legal jargon:

Copyright (c) 2012 Alex Zielenski

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.