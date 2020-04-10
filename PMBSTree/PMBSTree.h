//
//  PMBSTree.h
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMTreeNode.h"

NS_ASSUME_NONNULL_BEGIN

/// 二叉搜索树
@interface PMBSTree : NSObject



/// 添加元素
/// @param element 节点元素
- (void)addElement:(id)element;

/// 删除节点元素
/// @param element 节点元素
- (void)removeElement:(id)element;

/// 删除节点
/// @param node 节点
- (void)removeNode:(PMTreeNode*)node;

/// 判断树中是否包含节点元素
/// @param element 节点元素
- (BOOL)containsElement:(id)element;

/// 从根节点开始前序遍历
- (void)preOrderTraversal;

/// 从某个节点开始前序遍历
/// @param node 遍历的节点
- (void)preOrderTraversal:(PMTreeNode *)node;

/// 从根节点开始中序遍历
- (void)inOrderTraversal;

/// 从某个节点开始中序遍历
/// @param node 开始遍历的节点
- (void)inOrderTraversal:(PMTreeNode *)node;

/// 从根节点开始后序遍历
- (void)postOrderTraversal;

/// 从某个节点开始后序遍历
/// @param node 开始后序遍历的节点
- (void)postOrderTraversal:(PMTreeNode *)node;

/// 层序遍历
- (void)levelOrderTraversal;

/// 是否是完全二叉树
- (BOOL)isComplete;

/// 从根节点开始的二叉树高度
- (NSUInteger)treeHeight;

/// 从某个节点开始的二叉搜索树高度
/// @param node 节点
- (NSUInteger)treeHeightFromNode:(PMTreeNode *)node;

/// 比较两个节点的大小 0:value1 == value2,  1:value1>value2,   -1:value1<value2
/// @param value1 节点1
/// @param value2 节点2
- (NSInteger)compareE1:(id)value1 withE2:(id)value2;

/// 寻找前驱节点
/// @param node 当前节点
- (PMTreeNode *)predecessorNode:(PMTreeNode *)node;

/// 寻找node的后继节点
/// @param node 当前节点
- (PMTreeNode *)successorNode:(PMTreeNode *)node;

/// 获取二叉搜索树节点元素个数
- (NSUInteger)treeSize;

/// 获取根节点
- (PMTreeNode *)rootNode;

@end

NS_ASSUME_NONNULL_END
