//
//  CTTestViewController.m
//  Pods
//
//  Created by 黄成 on 15/12/25.
//
//

#import "CTTestViewController.h"
#import "CTVideoView.h"
#import "CTTableViewCell.h"
#import "CTVideoUtil.h"

@interface CTTestViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *array;
@end

@implementation CTTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [CTVideoUtil switchAudioSession:NO];//设置是否和其他音频输出并行
    
    [self.view addSubview:self.table];
    self.array = [NSMutableArray arrayWithObjects:
                  @"http://7xpas5.com1.z0.glb.clouddn.com/christmas.mp4",
                  @"http://7xpas5.com1.z0.glb.clouddn.com/christmas.mp4",
                  @"http://7xpas5.com1.z0.glb.clouddn.com/christmas.mp4",
                  @"http://7xpas5.com1.z0.glb.clouddn.com/test1.mov",
                  @"http://7xpas5.com1.z0.glb.clouddn.com/test1.mov",
                  @"http://7xpas5.com1.z0.glb.clouddn.com/test1.mov",
                  @"http://7xpas5.com1.z0.glb.clouddn.com/test3.mp4",
                  @"http://7xpas5.com1.z0.glb.clouddn.com/test3.mp4",
                  @"http://7xpas5.com1.z0.glb.clouddn.com/test3.mp4",
                  @"http://7xpas5.com1.z0.glb.clouddn.com/test3.mp4", nil];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.table.frame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTCell"];
    if (!cell) {
        cell = [[CTTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CTCell"];
    }
    if (indexPath.row == 0) {
        
        [cell packageWithUrl:[self.array objectAtIndex:indexPath.row] hasSound:NO play:YES];

    }else{
        [cell packageWithUrl:[self.array objectAtIndex:indexPath.row] hasSound:NO play:NO];

    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350.0;
}

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]init];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

@end
