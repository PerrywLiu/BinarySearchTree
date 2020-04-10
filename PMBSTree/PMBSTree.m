//
//  PMBSTree.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMBSTree.h"
@interface PMBSTree()
{
    NSUInteger _size;       /// 节点数目
    NSUInteger _height;      /// 树的高度
    PMTreeNode *_rootNode;   /// 根节点
}

@end

@implementation PMBSTree

- (void)addElement:(id)element
{
    ///添加第一个节点
    if (_rootNode == nil) {
        _rootNode = [[PMTreeNode alloc]initValue:element withParent:nil];
        _size ++;
        return;
    }
    
    PMTreeNode *parent = _rootNode;
    PMTreeNode *node = _rootNode;
    
    ///遍历寻找父节点
    while (node != nil) {
        NSInteger cmp = [self compareE1:node.value withE2:element];
        parent = node;
        if (cmp < 0) {
            node = node.right;
        }
        else if (cmp > 0)
        {
            node = node.left;
        }
        else if (cmp == 0)
        {
            ///替换元素
            node.value = element;
            return;
        }
    }
    
    NSInteger cmp = [self compareE1:parent.value withE2:element];
    PMTreeNode *newNode = [[PMTreeNode alloc]initValue:element withParent:parent];
    if (cmp > 0) {
        parent.left = newNode;
    }
    else if(cmp < 0)
    {
        parent.right = newNode;
    }
    
    _size++;
}

///寻找前驱节点
- (PMTreeNode *)predecessorNode:(PMTreeNode *)node
{
    ///前驱节点在左子树 node.left.right.right
    if (node.left) {
        PMTreeNode *p = node.left;
        while (p.right) {
            p = p.right;
        }
        return p;
    }
    
    while (node.parent && [node isEqual:node.parent.left]) {
        node = node.parent;
    }
    
    return node.parent;
}

#pragma mark - 遍历
- (void)preOrderTraversal
{
    [self preOrderTraversal:_rootNode];
}

- (void)preOrderTraversal:(PMTreeNode *)node
{
    if (node == nil) {
        return;
    }
    NSLog(@"%@-",node.value);
    [self preOrderTraversal:node.left];
    [self preOrderTraversal:node.right];
}

- (void)inOrderTraversal
{
    [self inOrderTraversal:_rootNode];
}

- (void)inOrderTraversal:(PMTreeNode *)node
{
    if (node == nil) {
        return;
    }
    
    [self inOrderTraversal:node.left];
    NSLog(@"%@-",node.value);
    [self inOrderTraversal:node.right];
}

- (void)postOrderTraversal
{
    [self postOrderTraversal:_rootNode];
}

- (void)postOrderTraversal:(PMTreeNode *)node
{
    if (node == nil) {
        return;
    }
    
    [self postOrderTraversal:node.left];
    [self postOrderTraversal:node.right];
    NSLog(@"%@-",node.value);
}

- (NSInteger)compareE1:(id)value1 withE2:(id)value2
{
    if ([value1 integerValue] > [value2 integerValue]) {
        return 1;
    }
    else if ([value1 integerValue] == [value2 integerValue]) {
        return 0;
    }
    else if ([value1 integerValue] < [value2 integerValue]) {
        return -1;
    }
    return 0;
}

#pragma mark - private method

@end
