//
//  TianViewController.h
//  UIToolBarDemo
//
//  Created by fang on 16/1/7.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TianViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *trash;
@property (strong, nonatomic) NSArray *aArray;
@property (assign, nonatomic) int k;

- (IBAction)addContent:(UIBarButtonItem *)sender;
- (IBAction)removeContent:(UIBarButtonItem *)sender;


@end
