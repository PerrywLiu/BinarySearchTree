//
//  PMAVLTreeNode.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/16.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMAVLTreeNode.h"

@implementation PMAVLTreeNode
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 1;
    }
    return self;
}

- (instancetype)initValue:(id)value withParent:(nullable PMTreeNode *)parent
{
    self = [super initValue:value withParent:parent];
    if (self) {
        self.height = 1;
    }
    return self;
}

- (NSInteger)balanceFactor
{
    return [self leftChild].height - [self rightChild].height;
}

- (void)updateHeight
{
    NSUInteger leftHeight = [self leftChild] ? [self leftChild].height : 0;
    NSUInteger rightHeight = [self rightChild] ? [self rightChild].height : 0;
    self.height = MAX(leftHeight, rightHeight) + 1;
}

- (PMAVLTreeNode *)tallerChild
{
    NSUInteger leftHeight = [self leftChild] ? [self leftChild].height : 0;
    NSUInteger rightHeight = [self rightChild] ? [self rightChild].height : 0;
    if (leftHeight > rightHeight) {
        return [self leftChild];
    }
    else if (leftHeight < rightHeight)
    {
        return [self rightChild];
    }
    return [self isLeftChild] ? [self leftChild] : [self rightChild];
}

- (PMAVLTreeNode *)leftChild
{
    return (PMAVLTreeNode *)self.left;
}

- (PMAVLTreeNode *)rightChild
{
    return (PMAVLTreeNode *)self.right;
}

@end
