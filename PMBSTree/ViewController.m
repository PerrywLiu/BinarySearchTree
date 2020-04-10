//
//  ViewController.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "ViewController.h"
#import "PMBSTree.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testBSTree];
}

- (void)testBSTree
{
    PMBSTree *tree = [[PMBSTree alloc]init];
    [tree addElement:@"10"];
    [tree addElement:@"8"];
    [tree addElement:@"6"];
    [tree addElement:@"9"];
    [tree addElement:@"15"];
    [tree addElement:@"13"];
    [tree addElement:@"17"];
    
    ///前序遍历
    [tree preOrderTraversal];
    ///中序遍历
    [tree inOrderTraversal];
    ///后续遍历
    [tree postOrderTraversal];
    
    ///寻找前驱节点
    PMTreeNode *node = [[PMTreeNode alloc]initValue:@"6" withParent:nil];
    PMTreeNode *p = [tree predecessorNode:node];
    NSLog(@"p = %@",p.value);
}

@end
