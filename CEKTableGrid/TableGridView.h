//
//  TableGridView.h
//  CEKTableGrid
//
//  Created by Cihan Emre Kisakurek on 12/4/12.
//  Copyright (c) 2012 cekWare. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableGridIndexPath;
@class TableGridCell;

@protocol TableGridViewDataSource;
@protocol TableGridViewDelegate;

@interface TableGridView : UIView

@property(assign)int rowCount;
@property(assign)int columnCount;

@property(weak)id <TableGridViewDataSource> dataSource;
@property(weak)id <TableGridViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;
-(void)reloadData;

@end

@interface TableGridIndexPath : NSObject

@property(assign)int row;
@property(assign)int column;

-(id)initWithRowIndex:(int)rowIndex columnIndex:(int)columnIndex;
+(id)gridIndexPathWithRow:(int)row column:(int)column;

@end

@protocol TableGridViewDataSource
-(NSInteger)rowCount;
-(NSInteger)columnCount;
- (TableGridCell *)tableGridView:(TableGridView *)tableGridView cellForRowAtIndexPath:(TableGridIndexPath *)indexPath;
@end;

@protocol TableGridViewDelegate <NSObject>


- (CGFloat)tableGridView:(TableGridView *)tableView heightForRowAtIndexPath:(TableGridIndexPath *)indexPath;
- (CGFloat)tableGridView:(TableGridView *)tableView widthForRowAtIndexPath:(TableGridIndexPath *)indexPath;

@optional
- (UIView *)headerViewFor:(TableGridView *)tableGridView;
- (UIView *)footerViewFor:(TableGridView *)tableGridView;


@end



@interface TableGridCell : UIView
@property(strong)UILabel *textLabel;
@end