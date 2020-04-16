//
//  PMAVLTreeNode.h
//  PMBSTree
//
//  Created by LiuPW on 2020/4/16.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMTreeNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMAVLTreeNode : PMTreeNode

/// 节点的高度
@property (nonatomic, assign) NSUInteger height;

/// 平衡因子
- (NSInteger)balanceFactor;

/// 更新高度
- (void)updateHeight;

/// 求左右子树中较高的树
- (PMAVLTreeNode *)tallerChild;


@end

NS_ASSUME_NONNULL_END
