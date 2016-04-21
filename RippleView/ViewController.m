//
//  ViewController.m
//  RippleView
//
//  Created by eag ers on 21/04/16.
//  Copyright © 2016 eag ers. All rights reserved.
//

#import "ViewController.h"
#import "DemoView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DemoView *demoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.demoView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.demoView.layer.borderWidth = 1.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
