//
//  TianViewController.m
//  UIToolBarDemo
//
//  Created by fang on 16/1/7.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "TianViewController.h"

@interface TianViewController ()

@end

@implementation TianViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.aArray = @[@"Alva",@"Ben",@"Charles",@"David",@"Edison",@"Ford",@"Gabriel",@"Hank",@"Jordan"];
    self.k = 1;
    self.trash.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark -- Action
- (IBAction)addContent:(UIBarButtonItem *)sender
{
    [self addSubview];
}

- (IBAction)removeContent:(UIBarButtonItem *)sender
{
    UIView *lastView = [self.view.subviews lastObject];
    [UIView animateWithDuration:1.2 animations:^
    {
        //UIView *lastView = [self.view.subviews lastObject];
        lastView.frame = CGRectMake(320, lastView.frame.origin.y, 320, 44);
        lastView.alpha = 0;
    } completion:^(BOOL finished)
    {
        [lastView removeFromSuperview];
        if (self.view.subviews.count == 1)
        {
            self.trash.enabled = NO;
        }
    }];
    
}

#pragma mark -- addSubview
- (void)addSubview
{
    UIView *lastView = [self.view.subviews lastObject];
    
    CGRect temp = lastView.frame;
    
    UIView *addView = [[UIView alloc] init];
    [addView setTag:self.k];
    self.k += 1;
    addView.frame = CGRectMake(320, temp.origin.y + temp.size.height + 4, 320, 44);
    addView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:addView];
    addView.alpha = 0;
    
    //动画包装
    [UIView animateWithDuration:1.2 animations:^
     {
         addView.frame = CGRectMake(0, temp.origin.y + temp.size.height + 4, 320, 44);
         addView.alpha = 1;   //透明度动画包装
     }];
    //包装结束
    
    if (!(self.view.subviews.count == 1))
    {
        self.trash.enabled = YES;
    }
    
    //添加打印各自名字按钮
    UIButton *aButton = [[UIButton alloc] init];
    aButton.frame = CGRectMake(40, 2, 40, 40);
    int i = arc4random_uniform(9);
    [aButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"01%d.png",i]] forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(showName:) forControlEvents:UIControlEventTouchUpInside];
    [addView addSubview:aButton];
    
    //添加放置各自名字的Label
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.frame = CGRectMake(200, 2, 80, 40);
    int j = arc4random_uniform(9);
    aLabel.text = [self.aArray objectAtIndex:j];
    [addView addSubview:aLabel];
    
    //添加每个条目自删除Button
    UIButton *deletButton = [[UIButton alloc] init];
    deletButton.frame = CGRectMake(306, 0, 10, 10);
    [deletButton setTitle:@"X" forState:UIControlStateNormal];
    [deletButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deletButton.showsTouchWhenHighlighted = YES;
    [deletButton addTarget:self action:@selector(deleteThisView:) forControlEvents:UIControlEventTouchUpInside];
    [addView addSubview:deletButton];
    
    NSLog(@"我就加了这一行代码");
}


#pragma mark -- showName  Action
- (void)showName:(UIButton *)sender
{
    NSInteger tempTag = sender.superview.tag;
    UIView *tempView = [sender.superview viewWithTag:tempTag];
    UILabel *tempLabel = [tempView.subviews objectAtIndex:1];
    NSLog(@"tempLabel.text = %@",tempLabel.text);
}


#pragma mark -- deleteThisView Action
- (void)deleteThisView:(UIButton *)sender
{
    NSInteger stepWeStart = [sender.superview.superview.subviews indexOfObject:sender.superview];
    [sender.superview removeFromSuperview];
    
    [self sequenceByItSelf:stepWeStart];
}


#pragma mark -- 每次删除之后进行自动排序方法
- (void)sequenceByItSelf:(NSInteger)startNumber
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.2];
    
    NSInteger numberOfViews = self.view.subviews.count;
    for (NSInteger i = startNumber; i < numberOfViews; i ++)
    {
        UIView *tempView = [self.view.subviews objectAtIndex:i];
        tempView.frame = CGRectMake(0, tempView.frame.origin.y - 48, 320, 44);
    }
    
    if (self.view.subviews.count == 1)
    {
        self.trash.enabled = NO;
    }
    [UIView commitAnimations];
}




@end
