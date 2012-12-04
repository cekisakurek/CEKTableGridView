//
//  TableGridView.m
//  CEKTableGrid
//
//  Created by Cihan Emre Kisakurek on 12/4/12.
//  Copyright (c) 2012 cekWare. All rights reserved.
//

#import "TableGridView.h"


@interface TableGridView (){
    UIScrollView *scrollView;
    UIView *headerView;
    UIView *footerView;
    
}
@property(nonatomic,strong)NSMutableArray *labelIndexes;
@end

@implementation TableGridView
@synthesize dataSource,delegate;
@synthesize rowCount,columnCount;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        scrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:scrollView];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [scrollView setFrame:self.bounds];
    [self reloadData];
    
}
-(void)reloadData{
    [self clearTable];
    [self buildTable];
}
-(void)clearTable{
    for (UIView *view in scrollView.subviews) {
        [view removeFromSuperview];
    }
    if(headerView){
        [headerView removeFromSuperview];
    }
    if(footerView){
        [footerView removeFromSuperview];
    }

}
-(void)buildTable{
    
    headerView=[delegate headerViewFor:self];
    if (headerView){
        [headerView setFrame:CGRectMake(0, 0, self.bounds.size.width, headerView.bounds.size.height)];
        [self addSubview:headerView];
    }
    
    float topMargin=headerView.bounds.size.height;
    
    
    [self setRowCount:[dataSource rowCount]];
    [self setColumnCount:[dataSource columnCount]];
    
    
    float totalHeight=topMargin;
    float totalWidth=self.bounds.size.width;
    float currentWidth=0;
    NSMutableArray *indexes=[NSMutableArray array];
    
    for (int i=0; i<self.rowCount; i++) {
        float cellHeight=[delegate tableGridView:self heightForRowAtIndexPath:[TableGridIndexPath gridIndexPathWithRow:i column:0]];
        
        for (int j=0; j<self.columnCount; j++) {
            
            float cellWidth=[delegate tableGridView:self widthForRowAtIndexPath:[TableGridIndexPath gridIndexPathWithRow:i column:j]];
            
            TableGridCell *cell=[dataSource tableGridView:self cellForRowAtIndexPath:[TableGridIndexPath gridIndexPathWithRow:i column:j]];
            [cell setFrame:CGRectMake(currentWidth, (i*cellHeight)+topMargin, cellWidth, cellHeight)];
            [cell setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
            [scrollView addSubview:cell];
            [indexes addObject:cell];
            
            
            currentWidth+=cellWidth;
            if (currentWidth>totalWidth) {
                totalWidth=currentWidth;
            }
            
        }
        totalHeight+=cellHeight;
        currentWidth=0;
    }
    
    footerView=[delegate footerViewFor:self];
    
    if (footerView) {
        [footerView setFrame:CGRectMake(0, self.bounds.size.height-footerView.bounds.size.height, self.bounds.size.width, footerView.bounds.size.height)];
        [self addSubview:footerView];
        totalHeight+=footerView.bounds.size.height;
    }
    
    
    [self setLabelIndexes:indexes];
    [scrollView setContentSize:CGSizeMake(totalWidth<self.bounds.size.width?self.bounds.size.width:totalWidth, totalHeight)];

}




-(TableGridCell*)gridCellAtIndexPath:(TableGridIndexPath*)path{
    int index=path.row+path.column;
    return [self.labelIndexes objectAtIndex:index];
}

@end


@implementation TableGridIndexPath
@synthesize row,column;

-(id)initWithRowIndex:(int)_rowIndex columnIndex:(int)_columnIndex{
    self = [super init];
    if (self) {
        [self setRow:_rowIndex];
        [self setColumn:_columnIndex];
    }
    return self;
}
+(id)gridIndexPathWithRow:(int)row column:(int)column{
    return [[TableGridIndexPath alloc]initWithRowIndex:row columnIndex:column];
}

@end

@implementation TableGridCell
@synthesize textLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        textLabel=[[UILabel alloc]initWithFrame:self.bounds];
        [textLabel setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self addSubview:textLabel];
    }
    return self;
}
@end