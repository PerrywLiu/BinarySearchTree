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
            [self reBlance:avlNode];
        }
    }
    
}

- (PMTreeNode *)createNode:(id)element andParent:(PMTreeNode *)parentNode
{
    return [[PMAVLTreeNode alloc]initValue:element withParent:parentNode];
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

/// 坐旋转
/// @param grandNode 第一个打破平衡的节点 祖父节点
- (void)rotateLeft:(PMAVLTreeNode *)grandNode
{
    PMAVLTreeNode *parentNode = (PMAVLTreeNode *)grandNode.right;
    PMAVLTreeNode *childNode = (PMAVLTreeNode *)parentNode.left;
    grandNode.right = childNode;
    parentNode.left = grandNode;
    [self afterRotate:grandNode parentNode:parentNode childNode:childNode];
}

/// 右旋转
/// @param grandNode 第一个打破平衡点节点 祖父节点
- (void)rotateRight:(PMAVLTreeNode *)grandNode
{
    PMAVLTreeNode *parentNode = (PMAVLTreeNode *)grandNode.left;
    PMAVLTreeNode *childNode = (PMAVLTreeNode *)parentNode.right;
    parentNode.right = grandNode;
    grandNode.left = childNode;
    [self afterRotate:grandNode parentNode:parentNode childNode:childNode];
}

/// 旋转后，更改父节点
/// @param grandNode 祖父节点
/// @param parentNode 父节点
/// @param childNode 子节点
- (void)afterRotate:(PMAVLTreeNode *)grandNode parentNode:(PMAVLTreeNode *)parentNode childNode:(PMAVLTreeNode *)childNode
{
    ///改变父节点的parent指向
    parentNode.parent = grandNode.parent;
    if ([grandNode isLeftChild]) {
        grandNode.parent.left = parentNode;
    }
    else if([grandNode isRightChild])
    {
        grandNode.parent.right = parentNode;
    }
    else
    {
        ///grand 是根节点
        _rootNode = parentNode;
    }
    
    ///更新祖父节点的parent指向
    grandNode.parent = parentNode;
    
    ///更新child节点的parent指向
    if (childNode != nil) {
        childNode.parent = grandNode;
    }
    
    [self updateHeight:grandNode];
    [self updateHeight:parentNode];
}

@end
