//
//  PMAVLTree.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/16.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMAVLTree.h"
#import "PMAVLTreeNode.h"

@implementation PMAVLTree

- (PMTreeNode *)createNode:(id)element andParent:(PMTreeNode *)parentNode
{
    return [[PMAVLTreeNode alloc]initValue:element withParent:parentNode];
}

- (void)afterAdd:(PMTreeNode *)node
{
    if (node == nil) {
        return;
    }
    
    PMAVLTreeNode *avlNode = (PMAVLTreeNode *)node;
    ///找到第一个不平衡的节点
    while ((avlNode = (PMAVLTreeNode*)avlNode.parent) != nil) {
        if ([self isBalance:avlNode]) {
            [self updateHeight:avlNode];
        }
        else
        {
            ///恢复平衡
            [self reBlance:avlNode];
            ///整棵树恢复平衡
            break;
        }
    }
}

- (void)afterRemove:(PMAVLTreeNode *)avlNode
{
    ///找到第一个不平衡的节点
    while (avlNode != nil) {
        if ([self isBalance:avlNode]) {
            [self updateHeight:avlNode];
        }
        else
        {
            [self reBlance:avlNode];
        }
        
        avlNode = (PMAVLTreeNode*)avlNode.parent;
    }
}

#pragma mark - privateMethod
- (BOOL)isBalance:(PMAVLTreeNode *)avlNode
{
    NSInteger balanceFactor = labs(avlNode.balanceFactor);
    return balanceFactor < 2;
}

- (void)updateHeight:(PMAVLTreeNode *)avlNode
{
    [avlNode updateHeight];
}

- (void)reBlance:(PMAVLTreeNode *)grandAvlNode
{
    PMAVLTreeNode *parentNode = [grandAvlNode tallerChild];
    PMAVLTreeNode *node = [parentNode tallerChild];
    
    /**
     * LL 进行右旋转
     * LR 先左旋转，再右旋转
     * RR 进行坐旋转
     * RL 先右旋转，再左旋转
     */
    if ([parentNode isLeftChild]) {
        if ([node isLeftChild]) {
            ///LL
            [self rotateRight:grandAvlNode];
        }
        else
        {
            ///LR
            [self rotateLeft:parentNode];
            [self rotateRight:grandAvlNode];
        }
    }
    else
    {
        if ([node isRightChild]) {
            ///RR
            [self rotateLeft:grandAvlNode];
        }
        else
        {
            ///RL
            [self rotateRight:parentNode];
            [self rotateLeft:grandAvlNode];
        }
    }
}

/// 旋转后，更改父节点
/// @param grandNode 祖父节点
/// @param parentNode 父节点
/// @param childNode 子节点
- (void)afterRotate:(PMAVLTreeNode *)grandNode parentNode:(PMAVLTreeNode *)parentNode childNode:(PMAVLTreeNode *)childNode
{
    
    [super afterRotate:grandNode parentNode:parentNode childNode:childNode];
    
    [self updateHeight:grandNode];
    [self updateHeight:parentNode];
}

@end
