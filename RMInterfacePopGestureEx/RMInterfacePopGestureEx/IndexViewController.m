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

BOOL StringIsEqualToString(NSString *aString,NSString *bString)
{
    if ([aString isKindOfClass:[NSNumber class]]) {
        aString = [NSString stringWithFormat:@"%@",[(NSNumber *)aString stringValue]];
    }
    
    if ([bString isKindOfClass:[NSNumber class]]) {
        bString = [NSString stringWithFormat:@"%@",[(NSNumber *)bString stringValue]];
    }
    
    if ([aString isKindOfClass:[NSString class]] && [bString isKindOfClass:[NSString class]]) {
        return [aString isEqualToString:bString];
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加上这句话之后，会使系统的滑动返回操作首先响应。  从而在首页左划时，会导致程序出现无法响应的情况，即假死现象
//    [self.navigationController.interactivePopGestureRecognizer setDelegate:nil];
    
//    table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    table.delegate = self;
//    table.dataSource = self;
//    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellInfo"];
//    [self.view addSubview:table];
    
    UIImageView *imgh;
    imgh.layer.shouldRasterize = YES;
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 100, 100, 30);
//    [button setTitle:@"点击我" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(tapMe:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSString *name = @"name";
//    name = [[NSNull alloc] init];
    NSLog(@"%@",[name isEqualToString:@"name"] ? @"YES" : @"NO");

//    NSObject *obj = [[NSObject alloc] init];
//    [obj performSelector:NSSelectorFromString(@"showname")];
    
    NSLog(@"%@",StringIsEqualToString(@"1", [NSArray array]) ? @"YES" : @"NO");
    
    name = nil;
    [name isEqualToString:@"1111"];
    
    name = @"{\"key\":1}";
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[name dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    NSLog(@"%@",StringIsEqualToString(@"1", [dic valueForKey:@"key"]) ? @"YES" : @"NO");
    
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:webView];
    
    
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
