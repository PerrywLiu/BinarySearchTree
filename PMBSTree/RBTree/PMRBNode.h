//
//  PMRBNode.h
//  PMBSTree
//
//  Created by LiuPW on 2020/4/30.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMTreeNode.h"

NS_ASSUME_NONNULL_BEGIN

#define RED    YES
#define BLACK  NO

@interface PMRBNode : PMTreeNode

/// 默认为红色
@property (nonatomic, assign) BOOL color;

@end

NS_ASSUME_NONNULL_END
