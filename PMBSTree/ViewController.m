//
//  ViewController.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "ViewController.h"
#import "PMBSTree.h"
#import "PMBinaryTree.h"
#import "PMAVLTree.h"
#import "MJLevelOrderPrinter.h"
#import "PMRedBlackTree.h"
#import "PMRBNode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testBSTree];
    [self testAVLTree];
//    [self testRBTree];
}

- (void)testBSTree
{
    PMBSTree *tree = [[PMBSTree alloc]initWithCampare:^NSInteger(NSString * _Nonnull element1, NSString *  _Nonnull element2) {
        NSInteger v1 = element1.integerValue;
        NSInteger v2 = element2.integerValue;
        if (v1 > v2) return 1;
        else if (v1 == v2) return 0;
        else return -1;
        
    }];
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
    NSLog(@"中序遍历");
    [tree inOrderTraversal:^(PMTreeNode * _Nullable node) {
        NSLog(@"%@",node.value);
    }];
    
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
    PMTreeNode *node = [tree nodeOfElement:@"14"];
//    PMTreeNode *preNode = [tree predecessorNode:node];
//    NSLog(@"%@的前驱结点为 = %@",node.value,preNode.value);
//
//    ///寻找后继节点
//
//    node = [tree nodeOfElement:@"17"];
//    PMTreeNode *successorNode = [tree successorNode:node];
//    NSLog(@"%@的后继节点为：%@",node.value,successorNode.value);
//
    ///删除节点
    NSLog(@"删除节点：%@后的中序遍历：",node.value);
    [tree removeNode:node];
    [tree inOrderTraversal:^(PMTreeNode * _Nullable node) {
        NSLog(@"%@",node.value);
    }];
//
//    [tree removeNode:node];
//    NSLog(@"删除节点后的中序遍历：");
//    [tree inOrderTraversal:^(PMTreeNode * _Nullable node) {
//        NSLog(@"%@",node.value);
//    }];
//
    ///求二叉树高度
//    NSUInteger height = [tree treeHeight];
//    NSLog(@"高度为：%ld",height);
//
//    NSUInteger height2 = [tree treeHeightAlternateFromNode:[tree rootNode]];
//    NSLog(@"利用层序遍历 高度为：%ld",height2);
//
//    ///求二叉树元素个数
//    NSUInteger size = [tree treeSize];
//    NSLog(@"二叉搜索树共有%ld个元素",size);
//
//    ///是否是完全二叉树
//    BOOL isComplete = [tree isComplete];
//    NSLog(@"是否为完全二叉树：%d",isComplete);
    
    ///翻转二叉树
//    [tree reversalTree];
}

- (void)testAVLTree
{
    PMAVLTree *avlTree = [[PMAVLTree alloc]initWithCampare:^NSInteger(NSString * _Nonnull element1, NSString *  _Nonnull element2) {
            NSInteger v1 = element1.integerValue;
            NSInteger v2 = element2.integerValue;
            if (v1 > v2) return 1;
            else if (v1 == v2) return 0;
            else return -1;
            
        }];
    
    NSArray *elementArray = @[@"10",@"8",@"6",@"9",@"15",@"13",@"17",@"5",@"11",@"14",@"12",@"16",@"40"];
    for (NSString *e in elementArray) {
        [avlTree addElement:e];
    }
    
    [avlTree preOrderTraversal:^(PMTreeNode * _Nullable node) {
        [node print];
    }];
    
    ///求二叉树高度
    NSUInteger height = [avlTree treeHeight];
    NSLog(@"高度为：%ld",height);
    
//    PMTreeNode *node = [avlTree nodeOfElement:@"15"];
//    [avlTree removeNode:node];
//    NSLog(@"删除元素15后");
//    [avlTree preOrderTraversal:^(PMTreeNode * _Nullable node) {
//        [node print];
//    }];
//
//    [avlTree removeNode:[avlTree nodeOfElement:@"13"]];
//    NSLog(@"删除元素13后");
//    [avlTree preOrderTraversal:^(PMTreeNode * _Nullable node) {
//        [node print];
//    }];
//
//    [avlTree removeNode:[avlTree nodeOfElement:@"6"]];
//    NSLog(@"删除元素6后");
//    [avlTree preOrderTraversal:^(PMTreeNode * _Nullable node) {
//        [node print];
//    }];
//
//    [avlTree removeNode:[avlTree nodeOfElement:@"5"]];
//    NSLog(@"删除元素5后");
//    [avlTree preOrderTraversal:^(PMTreeNode * _Nullable node) {
//        [node print];
//    }];
//
//    ///求二叉树高度
//    height = [avlTree treeHeight];
//    NSLog(@"高度为：%ld",height);
}

/// 测试红黑树
- (void)testRBTree
{
    PMRedBlackTree *rbTree = [[PMRedBlackTree alloc]initWithCampare:^NSInteger(NSString *  _Nonnull element1, NSString * _Nonnull element2) {
         NSInteger v1 = element1.integerValue;
         NSInteger v2 = element2.integerValue;
         if (v1 > v2) return 1;
         else if (v1 == v2) return 0;
         else return -1;
    }];
    
    NSArray *elementArray = @[@"10",@"8",@"6",@"9",@"15",@"13",@"17",@"5",@"11",@"14",@"12",@"16",@"40"];
    for (NSString *e in elementArray) {
        [rbTree addElement:e];
    }
 
    [rbTree inOrderTraversal:^(PMTreeNode * _Nullable node) {
        PMRBNode *rbNode = (PMRBNode *)node;
        NSLog(@"%@",[rbNode description]);
    }];
}

@end
