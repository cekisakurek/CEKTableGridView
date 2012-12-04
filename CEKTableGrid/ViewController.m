//
//  ViewController.m
//  CEKTableGrid
//
//  Created by Cihan Emre Kisakurek on 12/4/12.
//  Copyright (c) 2012 cekWare. All rights reserved.
//


#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
    TableGridView *gridView=[[TableGridView alloc]initWithFrame:self.view.bounds];
    [gridView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [gridView setDelegate:self];
    [gridView setDataSource:self];
    [self.view addSubview:gridView];
    [gridView reloadData];
    
}
-(NSInteger)rowCount{
    return 5;
}
-(NSInteger)columnCount{
    return 5;
}
- (CGFloat)tableGridView:(TableGridView *)tableView heightForRowAtIndexPath:(TableGridIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableGridView:(TableGridView *)tableView widthForRowAtIndexPath:(TableGridIndexPath *)indexPath{
    if (indexPath.column==0) {
        return 100;
    }
    else
        return 70;
}
- (TableGridCell *)tableGridView:(TableGridView *)tableGridView cellForRowAtIndexPath:(TableGridIndexPath *)indexPath{
    TableGridCell *cell=[[TableGridCell alloc]initWithFrame:CGRectZero];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    [cell.layer setBorderWidth:1];
    [cell.textLabel setTextAlignment:1];
    [cell.textLabel setText:[NSString stringWithFormat:@"%d-%d",indexPath.row,indexPath.column]];
    return cell;
}

- (UIView *)headerViewFor:(TableGridView *)tableGridView{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    [label setBackgroundColor:[UIColor colorWithWhite:50/255.0 alpha:0.5]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"Header"];
    return label;
}
- (UIView *)footerViewFor:(TableGridView *)tableGridView{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    [label setBackgroundColor:[UIColor colorWithWhite:50/255.0 alpha:0.5]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"Footer"];
    return label;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
