//
//  DBViewController.m
//  DataBaseIteration
//
//  Created by soul on 16/9/21.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "DBViewController.h"
#import "UserInfoDbManager.h"
#import "DBVersionUDTool.h"

@interface DBViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *resultShowLabel;
@property (strong, nonatomic) IBOutlet UITextField *userid;
@property (strong, nonatomic) IBOutlet UITextField *username;
- (IBAction)insert:(UIButton *)sender;
- (IBAction)shengdb:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *insert;
@property (strong, nonatomic) IBOutlet UIButton *shengdb;

@end

@implementation DBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insert:(UIButton *)sender {
    
    if ([UserInfoDbManager saveUserName:self.username.text withUserId:self.userid.text]) {
        self.resultShowLabel.text = @"插入数据成功";

    }else{
        self.resultShowLabel.text = @"插入数据失败";

    }

}

- (IBAction)shengdb:(UIButton *)sender {
    

    __weak typeof(self) weakSelf = self;
    DBVersionUDTool *tool = [[DBVersionUDTool alloc] init];
    [tool userDataBaseVersionUpdataResult:^(BOOL result){
    
        if (result) {
            weakSelf.resultShowLabel.text = @"迭代成功";
        }else{
            weakSelf.resultShowLabel.text = @"迭代失败";
        }
    }];

}
@end
