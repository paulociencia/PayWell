//
//  UINavigationController+Orientation.m
//  DashPress
//
//  Created by Rajkumar Sharma on 06/10/14.
//  Copyright (c) 2014 MyAppTemplates. All rights reserved.
//

#import "UINavigationController+Orientation.h"


@interface UINavigationController_Orientation ()

@end

@implementation UINavigationController (Orientation)

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(BOOL)shouldAutorotate
{
    return YES;
}
@end

@implementation UINavigationController_Orientation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
