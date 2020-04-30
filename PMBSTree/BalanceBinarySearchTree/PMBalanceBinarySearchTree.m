//
//  PMBalanceBinarySearchTree.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/29.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMBalanceBinarySearchTree.h"
#import "PMTreeNode.h"

@implementation PMBalanceBinarySearchTree

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/// 左旋转
/// @param grandNode 第一个打破平衡的节点 祖父节点
- (void)rotateLeft:(PMTreeNode *)grandNode
{
    PMTreeNode *parentNode = (PMTreeNode *)grandNode.right;
    PMTreeNode *childNode = (PMTreeNode *)parentNode.left;
    grandNode.right = childNode;
    parentNode.left = grandNode;
    [self afterRotate:grandNode parentNode:parentNode childNode:childNode];
}

/// 右旋转
/// @param grandNode 第一个打破平衡点节点 祖父节点
- (void)rotateRight:(PMTreeNode *)grandNode
{
    PMTreeNode *parentNode = (PMTreeNode *)grandNode.left;
    PMTreeNode *childNode = (PMTreeNode *)parentNode.right;
    parentNode.right = grandNode;
    grandNode.left = childNode;
    [self afterRotate:grandNode parentNode:parentNode childNode:childNode];
}

/// 旋转后，更改父节点
/// @param grandNode 祖父节点
/// @param parentNode 父节点
/// @param childNode 子节点
- (void)afterRotate:(PMTreeNode *)grandNode parentNode:(PMTreeNode *)parentNode childNode:(PMTreeNode *)childNode
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
}

@end
