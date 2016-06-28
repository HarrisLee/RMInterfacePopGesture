//
//  IndexViewController.m
//  RMInterfacePopGestureEx
//
//  Created by JianRongCao on 6/28/16.
//  Copyright © 2016 JianRongCao. All rights reserved.
//

#import "IndexViewController.h"
#import "ViewController.h"

@interface IndexViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
}
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加上这句话之后，会使系统的滑动返回操作首先响应。  从而在首页左划时，会导致程序出现无法响应的情况，即假死现象
//    [self.navigationController.interactivePopGestureRecognizer setDelegate:nil];
    
    table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellInfo"];
    [self.view addSubview:table];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 100, 100, 30);
//    [button setTitle:@"点击我" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(tapMe:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"cellInfo" forIndexPath:indexPath];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [table deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *viewController = [[ViewController alloc] init];
    viewController.title = @"tapMe";
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)tapMe:(UIButton *)sender
{
    ViewController *viewController = [[ViewController alloc] init];
    viewController.title = @"tapMe";
    [self.navigationController pushViewController:viewController animated:YES];
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
