//
//  PMBinaryTree.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/16.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMBinaryTree.h"
@interface PMBinaryTree()

@end

@implementation PMBinaryTree

- (PMTreeNode *)createNode:(id)element andParent:(PMTreeNode  * _Nullable  )parentNode
{
    return nil;
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
    
    ///递归法
    return 1 + MAX([self treeHeightFromNode:node.left], [self treeHeightFromNode:node.right]);
}

- (NSUInteger)treeHeightAlternateFromNode:(PMTreeNode *)node
{
    if (node == nil) {
        return 0;
    }
    
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    [mArray addObject:_rootNode];
    NSUInteger height = 0;
    NSUInteger levelSize = 1;
    
    while (mArray.count > 0) {
        levelSize--;
        PMTreeNode *node = [mArray objectAtIndex:0];
        [mArray removeObjectAtIndex:0];
        
        if (node.left) {
            [mArray addObject:node.left];
        }
        if (node.right) {
            [mArray addObject:node.right];
        }
        
        if (levelSize == 0) {
            levelSize = mArray.count;
            height++;
        }
    }
    
    return height;
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

- (void)reversalTree
{
    [self reversalTreeFromNode:_rootNode];
}

- (void)reversalTreeFromNode:(PMTreeNode *)node
{
    if (node == nil) {
        return;
    }
    
    NSLog(@"%@",node.value);
    
    PMTreeNode *tmp = node.left;
    node.left = node.right;
    node.right = tmp;
    
    [self reversalTreeFromNode:node.left];
    [self reversalTreeFromNode:node.right];
}

@end
