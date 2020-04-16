//
//  PMBSTree.h
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PMBinaryTree.h"


///比较节点元素
typedef NSInteger(^PMBSTCompareBlock)(id _Nonnull element1, id _Nonnull element2);

NS_ASSUME_NONNULL_BEGIN

/// 二叉搜索树
@interface PMBSTree : PMBinaryTree
{
@protected
    PMBSTCompareBlock _compareBlock;
    id<PMBStreeCompareProtocol> _compareDelegate;
}

- (instancetype)initWithCampare:(PMBSTCompareBlock)compareBlock;

/// 添加元素
/// @param element 节点元素
- (void)addElement:(id)element;

///添加node节点后，平衡二叉树
- (void)afterAdd:(PMTreeNode *)node;

/// 删除节点元素
/// @param element 节点元素
- (void)removeElement:(id)element;

/// 删除节点
/// @param node 节点
- (void)removeNode:(PMTreeNode*)node;

/// 删除节点后，再平衡
/// @param node 被删除的节点
- (void)afterRemove:(PMTreeNode *)node;

/// 判断树中是否包含节点元素
/// @param element 节点元素
- (BOOL)containsElement:(id)element;


/// 寻找element所在的节点
/// @param element 节点元素值
- (PMTreeNode *)nodeOfElement:(id)element;


@end

NS_ASSUME_NONNULL_END
