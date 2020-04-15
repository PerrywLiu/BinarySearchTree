//
//  PMBSTree.h
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMTreeNode.h"

@protocol PMBStreeCompareProtocol <NSObject>

- (NSInteger)compareElement1:(id _Nonnull )element1 withOther:(id _Nonnull)element2;

@end

///遍历后得到的节点元素
typedef void(^TraversalAccomplishBlock)(PMTreeNode * _Nullable node);

///比较节点元素
typedef NSInteger(^PMBSTCompareBlock)(id _Nonnull element1, id _Nonnull element2);

NS_ASSUME_NONNULL_BEGIN

/// 二叉搜索树
@interface PMBSTree : NSObject

- (instancetype)initWithCampare:(PMBSTCompareBlock)compareBlock;

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
- (void)preOrderTraversal:(TraversalAccomplishBlock)accomplishBlock;

/// 从某个节点开始前序遍历
/// @param node 遍历的节点
- (void)preOrderTraversal:(PMTreeNode *)node accomplish:(TraversalAccomplishBlock)accomplishBlock;

/// 从根节点开始中序遍历
- (void)inOrderTraversal:(TraversalAccomplishBlock)accomplishBlock;

/// 从某个节点开始中序遍历
/// @param node 开始遍历的节点
- (void)inOrderTraversal:(PMTreeNode *)node accomplish:(TraversalAccomplishBlock)accomplishBlock;

/// 从根节点开始后序遍历
- (void)postOrderTraversal:(TraversalAccomplishBlock)accomplishBlock;

/// 从某个节点开始后序遍历
/// @param node 开始后序遍历的节点
- (void)postOrderTraversal:(PMTreeNode *)node accomplish:(TraversalAccomplishBlock)accomplishBlock;

/// 层序遍历
- (void)levelOrderTraversal:(TraversalAccomplishBlock)accomplishBlock;

/// 从某个节点开始遍历
/// @param node 进行层序遍历的节点
/// @param accomplishBlock 遍历到的节点元素
- (void)levelOrderTraversal:(PMTreeNode *)node accomplish:(TraversalAccomplishBlock)accomplishBlock;

/// 是否是完全二叉树
- (BOOL)isComplete;

/// 从根节点开始的二叉树高度
- (NSUInteger)treeHeight;

/// 从某个节点开始的二叉搜索树高度，递归
/// @param node 节点
- (NSUInteger)treeHeightFromNode:(PMTreeNode *)node;

/// 利用层序遍历求树的高度
/// @param node 节点
- (NSUInteger)treeHeightAlternateFromNode:(PMTreeNode *)node;

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

/// 寻找element所在的节点
/// @param element 节点元素值
- (PMTreeNode *)nodeOfElement:(id)element;

/// 翻转二叉树
- (void)reversalTree;

/// 从某个节点开始翻转二叉树
/// 前序遍历
/// @param node 开始翻转的节点
- (void)reversalTreeFromNode:(PMTreeNode *)node;
@end

NS_ASSUME_NONNULL_END
