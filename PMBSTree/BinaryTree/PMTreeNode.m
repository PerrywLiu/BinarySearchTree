//
//  PMTreeNode.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMTreeNode.h"

@implementation PMTreeNode

- (instancetype)initValue:(id)value withParent:(nullable PMTreeNode *)parent
{
    self = [super init];
    if (self) {
        self.value = value;
        self.parent = parent;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    ///浅拷贝
    return self;
    
    ///深拷贝
//    PMTreeNode *node = [[PMTreeNode alloc]init];
//    node.value = self.value;
//    node.parent = self.parent;
//    node.left = self.left;
//    node.right = self.right;
//    return node;
}

- (BOOL)isLeaf
{
    return self.left == nil && self.right == nil;
}

- (BOOL)hasTwoChildren
{
    return self.left && self.right;
}

- (BOOL)isLeftChild
{
    return self.parent && [self isEqual:self.parent.left];
}

- (BOOL)isRightChild
{
    return self.parent && [self isEqual:self.parent.right];
}

- (void)print
{
    NSLog(@"V(%@)--P(%@)--L(%@)---R(%@)",self.value,self.parent.value,self.left.value,self.right.value);
}
@end
