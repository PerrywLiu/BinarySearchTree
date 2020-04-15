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

/// 添加元素，生成二叉搜索树
/// @param element 待添加元素
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

- (void)removeElement:(id)element
{
    PMTreeNode *node = [self nodeOfElement:element];
    [self removeNode:node];
}

- (void)removeNode:(PMTreeNode *)node
{
    if(node == nil)return;
    
    ///度为2的节点，将前驱节点的值与node进行替换，替换后删除node节点
    if ([node hasTwoChildren]) {
        ///寻找前驱节点
        PMTreeNode *preNode = [self predecessorNode:node];
        ///将前驱节点的值改为待删除节点的值
        node.value = preNode.value;
        
        ///删除前驱节点
        node = preNode;
    }
    
    ///度为1 或 度为0的节点
    PMTreeNode *childNode = node.left ? node.left : node.right;
    PMTreeNode *parentNode = node.parent;
    if ([node isEqual:parentNode.left]) {
        parentNode.left = childNode;
    }
    else
    {
        parentNode.right = childNode;
    }
    
    node.parent = nil;
    
    _size--;
}

/// 寻找某一个节点
/// @param element 节点元素
- (PMTreeNode *)nodeOfElement:(id)element
{
    PMTreeNode *node = _rootNode;
    while (node != nil) {
        NSInteger cmp = [self compareE1:element withE2:node.value];
        if (cmp == 0) {
            return node;
        }
        else if(cmp > 0)
        {
            node = node.right;
        }
        else if (cmp < 0)
        {
            node = node.left;
        }
    }
    
    return node;
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
    
    ///node 没有左子树
    while (node.parent && [node isEqual:node.parent.left]) {
        node = node.parent;
    }
    
    return node.parent;
}

/// 寻找后继节点
/// @param node 当前节点
- (PMTreeNode *)successorNode:(PMTreeNode *)node
{
    ///后继节点在右子树 node.right.left.left
    if (node.right) {
        PMTreeNode *pNode = node.right;
        while (pNode.left) {
            pNode = pNode.left;
        }
        return pNode;
    }
    
    ///右子树为空
    if (node.parent && [node.parent.right isEqual:node]) {
        node = node.parent;
    }
    
    return node.parent;
}

- (BOOL)isComplete
{
    __block BOOL result = YES;
    __block BOOL isLeaf = NO;
    [self levelOrderTraversal:^(PMTreeNode * _Nullable node) {
        if (isLeaf && (node.left || node.right)) {
            result = NO;
        }
        if (node.left == nil && node.right == nil) {
            isLeaf = YES;
        }
    }];
    return result;
}

- (PMTreeNode *)rootNode
{
    return _rootNode;
}

- (NSUInteger)treeSize
{
    return _size;
}

- (NSUInteger)treeHeight
{
    return [self treeHeightFromNode:_rootNode];
}

- (NSUInteger)treeHeightFromNode:(PMTreeNode *)node
{
    if (node == nil) {
        return 0;
    }
    
    return 1 + MAX([self treeHeightFromNode:node.left], [self treeHeightFromNode:node.right]);
}

- (BOOL)containsElement:(id)element
{
    return [self nodeOfElement:element] ? YES : NO;
}

#pragma mark - 遍历
///前序遍历
- (void)preOrderTraversal:(TraversalAccomplishBlock)accomplishBlock
{
    [self preOrderTraversal:_rootNode accomplish:accomplishBlock];
}

- (void)preOrderTraversal:(PMTreeNode *)node accomplish:(nonnull TraversalAccomplishBlock)accomplishBlock
{
    if (node == nil) {
        return;
    }
    
    if (accomplishBlock) {
        accomplishBlock(node);
    }
    
    [self preOrderTraversal:node.left accomplish:accomplishBlock];
    [self preOrderTraversal:node.right accomplish:accomplishBlock];
}

/// 中序遍历
- (void)inOrderTraversal:(TraversalAccomplishBlock)accomplishBlock
{
    [self inOrderTraversal:_rootNode accomplish:accomplishBlock];
}

- (void)inOrderTraversal:(PMTreeNode *)node accomplish:(nonnull TraversalAccomplishBlock)accomplishBlock
{
    if (node == nil) {
        return;
    }
    
    [self inOrderTraversal:node.left accomplish:accomplishBlock];

    if (accomplishBlock) {
        accomplishBlock(node);
    }
    [self inOrderTraversal:node.right accomplish:accomplishBlock];
}

/// 后序遍历
- (void)postOrderTraversal:(TraversalAccomplishBlock)accomplishBlock
{
    [self postOrderTraversal:_rootNode accomplish:accomplishBlock];
}

- (void)postOrderTraversal:(PMTreeNode *)node accomplish:(nonnull TraversalAccomplishBlock)accomplishBlock
{
    if (node == nil) {
        return;
    }
    
    [self postOrderTraversal:node.left accomplish:accomplishBlock];
    [self postOrderTraversal:node.right accomplish:accomplishBlock];
    
    if (accomplishBlock) {
        accomplishBlock(node);
    }
}

- (void)levelOrderTraversal:(TraversalAccomplishBlock)accomplishBlock
{
    [self levelOrderTraversal:_rootNode accomplish:accomplishBlock];
}

- (void)levelOrderTraversal:(PMTreeNode *)node accomplish:(TraversalAccomplishBlock)accomplishBlock
{
    if (node == nil) {
        return;
    }
    
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    [mArray addObject:node];
    while (mArray.count > 0) {
        PMTreeNode *node = [mArray objectAtIndex:0];
        if (accomplishBlock) {
            accomplishBlock(node);
        }
        [mArray removeObjectAtIndex:0];
        
        if (node.left) {
            [mArray addObject:node.left];
        }
        if (node.right) {
            [mArray addObject:node.right];
        }
    }
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
