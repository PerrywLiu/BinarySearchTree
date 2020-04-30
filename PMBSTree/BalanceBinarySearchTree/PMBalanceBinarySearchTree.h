//
//  PMBalanceBinarySearchTree.h
//  PMBSTree
//
//  Created by LiuPW on 2020/4/29.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMBSTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMBalanceBinarySearchTree : PMBSTree

/// 左旋转
/// @param grandNode 第一个打破平衡的节点 祖父节点
- (void)rotateLeft:(PMTreeNode *)grandNode;

/// 右旋转
/// @param grandNode 第一个打破平衡点节点 祖父节点
- (void)rotateRight:(PMTreeNode *)grandNode;

/// 旋转后，更改父节点
/// @param grandNode 祖父节点
/// @param parentNode 父节点
/// @param childNode 子节点
- (void)afterRotate:(PMTreeNode *)grandNode parentNode:(PMTreeNode *)parentNode childNode:(PMTreeNode *)childNode;

@end

NS_ASSUME_NONNULL_END
