//
//  CTViewController.m
//  CTVideoView
//
//  Created by root on 12/25/2015.
//  Copyright (c) 2015 root. All rights reserved.
//

#import "CTViewController.h"
#import "CTTestViewController.h"

@interface CTViewController ()

@end

@implementation CTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)click:(id)sender{
    
    [self presentViewController:[[CTTestViewController alloc]init] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
