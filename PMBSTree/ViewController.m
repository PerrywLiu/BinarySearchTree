//
//  ViewController.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "ViewController.h"
#import "PMBSTree.h"
#import "MJLevelOrderPrinter.h"

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
//    for (int i = 0; i < 100; i++) {
//        NSString *element = [NSString stringWithFormat:@"%d",rand()%100];
//        [tree addElement:element];
//    }
    [tree addElement:@"10"];
    [tree addElement:@"8"];
    [tree addElement:@"6"];
    [tree addElement:@"9"];
    [tree addElement:@"15"];
    [tree addElement:@"13"];
    [tree addElement:@"17"];
//    [tree addElement:@"5"];
    [tree addElement:@"11"];
    [tree addElement:@"14"];
    [tree addElement:@"12"];
    [tree addElement:@"16"];
    
    ///前序遍历
//    NSLog(@"前序遍历");
//    [tree preOrderTraversal];
    
    ///中序遍历
//    NSLog(@"中序遍历");
//    [tree inOrderTraversal];
    
    ///后续遍历
//    NSLog(@"后序遍历");
//    [tree postOrderTraversal];
    
    ///层序遍历
//    NSLog(@"层序遍历");
//    [tree levelOrderTraversal:^(PMTreeNode * _Nullable node) {
//        NSLog(@"%@",node.value);
//    }];
//
//    ///寻找前驱节点
//    PMTreeNode *node = [tree nodeOfElement:@"11"];
//    PMTreeNode *preNode = [tree predecessorNode:node];
//    NSLog(@"%@的前驱结点为 = %@",node.value,preNode.value);
//
//    ///寻找后继节点
//
//    node = [tree nodeOfElement:@"17"];
//    PMTreeNode *successorNode = [tree successorNode:node];
//    NSLog(@"%@的后继节点为：%@",node.value,successorNode.value);
//
//    ///删除节点
//    NSLog(@"删除节点：%@前的中序遍历：",node.value);
//    [tree inOrderTraversal:^(PMTreeNode * _Nullable node) {
//        NSLog(@"%@",node.value);
//    }];
//
//    [tree removeNode:node];
//    NSLog(@"删除节点后的中序遍历：");
//    [tree inOrderTraversal:^(PMTreeNode * _Nullable node) {
//        NSLog(@"%@",node.value);
//    }];
//
    ///求二叉树高度
    NSUInteger height = [tree treeHeight];
    NSLog(@"高度为：%ld",height);
    
    NSUInteger height2 = [tree treeHeightAlternateFromNode:[tree rootNode]];
    NSLog(@"利用层序遍历 高度为：%ld",height2);
//
//    ///求二叉树元素个数
//    NSUInteger size = [tree treeSize];
//    NSLog(@"二叉搜索树共有%ld个元素",size);
//
//    ///是否是完全二叉树
//    BOOL isComplete = [tree isComplete];
//    NSLog(@"是否为完全二叉树：%d",isComplete);
    
    ///翻转二叉树
    [tree reversalTree];
}

@end
