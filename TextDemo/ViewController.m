//
//  ViewController.m
//  TextDemo
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 200, 40)];
    imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mole01"]];
    [self.view addSubview:imageView];
    NSString *string = @"If you were a teardrop;In my eye,For fear of losing you,I would never cry.And if the golden sun,Should cease to shine its light,Just one smile from you,Would make my whole world bright.";
    //文件容器，它定义文本布局的区域，类似画布，它可以制定那部分来布局，那部分不能布局
    NSTextContainer  *textContainer = [[NSTextContainer alloc]initWithSize:self.view.bounds.size];
    NSTextStorage *textStorage = [[NSTextStorage alloc]initWithString:string];
    [textStorage beginEditing];
    NSDictionary *attDict = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:30]};
    [textStorage addAttributes:attDict range:NSMakeRange(0, string.length-20)];
    [self storeWorldUsingRedColorUndleLine:@"Would" textStore:textStorage];
    [textStorage endEditing];
    //布局管理器,协调3个协同工作
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    UITextView *textView = [[UITextView alloc]initWithFrame:self.view.bounds textContainer:textContainer];
    [self.view insertSubview:textView aboveSubview:imageView];
    CGRect rect = [textView convertRect:imageView.frame fromView:self.view];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    //排除路径，指定那个部分不能绘制内容
    textContainer.exclusionPaths = @[path];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)storeWorldUsingRedColorUndleLine:(NSString *)world textStore:(NSTextStorage *)textStore{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:world options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *string = @"If you were a teardrop;In my eye,For fear of losing you,I would never cry.And if the golden sun,Should cease to shine its light,Just one smile from you,Would make my whole world bright.";

    NSArray *resultArray = [regular matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    for (NSTextCheckingResult *result in resultArray) {
        NSDictionary *dict = @{NSForegroundColorAttributeName: [UIColor redColor], NSUnderlineStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
        [textStore addAttributes:dict range:result.range];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
