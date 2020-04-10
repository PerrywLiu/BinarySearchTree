//
//  PMTreeNode.h
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMTreeNode : NSObject

/// 左子树
@property (nonatomic, strong) PMTreeNode *left;
/// 右子树
@property (nonatomic, strong) PMTreeNode *right;
/// 父节点
@property (nonatomic, strong) PMTreeNode *parent;

/// 节点值
@property (nonatomic, strong) id value;

- (instancetype)initValue:(id)value withParent:(nullable PMTreeNode *)parent;

/// 判断是否是叶子节点
- (BOOL)isLeaf;

/// 是否有左右子树
- (BOOL)hasTwoChildren;

@end

NS_ASSUME_NONNULL_END
