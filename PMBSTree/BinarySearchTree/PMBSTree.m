//
//  PMBSTree.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/10.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMBSTree.h"
@interface PMBSTree()

@end

@implementation PMBSTree

- (instancetype)initWithCampare:(PMBSTCompareBlock)compareBlock
{
    self = [super init];
    if (self) {
        _compareBlock = compareBlock;
    }
    
    return self;
}

/// 添加元素，生成二叉搜索树
/// @param element 待添加元素
- (void)addElement:(id)element
{
    ///添加第一个节点
    if (_rootNode == nil) {
        _rootNode = [self createNode:element andParent:nil];
        [self afterAdd:_rootNode];
        _size ++;
        return;
    }
    
    PMTreeNode *parent = _rootNode;
    PMTreeNode *node = _rootNode;
    
    ///遍历寻找父节点
    while (node != nil) {
        NSInteger cmp = [self compareE1:node.value withE2:element];
        parent = node;
        if (cmp < 0) {
            node = node.right;
        }
        else if (cmp > 0)
        {
            node = node.left;
        }
        else if (cmp == 0)
        {
            ///替换元素
            node.value = element;
            return;
        }
    }
    
    NSInteger cmp = [self compareE1:parent.value withE2:element];
    PMTreeNode *newNode = [self createNode:element andParent:parent];
    if (cmp > 0) {
        parent.left = newNode;
    }
    else if(cmp < 0)
    {
        parent.right = newNode;
    }
    
    [self afterAdd:newNode];
    
    _size++;
}

- (PMTreeNode *)createNode:(id)element andParent:(PMTreeNode *)parentNode
{
    return [[PMTreeNode alloc]initValue:element withParent:parentNode];
}

- (void)afterAdd:(PMTreeNode *)node
{
    
}

- (void)removeElement:(id)element
{
    PMTreeNode *node = [self nodeOfElement:element];
    [self removeNode:node];
}

- (void)removeNode:(PMTreeNode *)node
{
    if(node == nil)return;
    
    ///度为2的节点，将前驱节点的值与node进行替换，替换后删除node节点
    if ([node hasTwoChildren]) {
        ///寻找前驱节点
        PMTreeNode *preNode = [self predecessorNode:node];
        ///将前驱节点的值改为待删除节点的值
        node.value = preNode.value;
        
        ///删除前驱节点
        node = preNode;
    }
    
    ///度为1 或 度为0的节点
    PMTreeNode *childNode = node.left ? node.left : node.right;
    PMTreeNode *parentNode = node.parent;
    if ([node isEqual:parentNode.left]) {
        parentNode.left = childNode;
        childNode.parent = parentNode;
    }
    else
    {
        parentNode.right = childNode;
        childNode.parent = parentNode;
    }
    
    [self afterRemove:parentNode];
    
    node.parent = nil;
    
    _size--;
}

- (void)afterRemove:(PMTreeNode *)node
{
    
}

/// 寻找某一个节点
/// @param element 节点元素
- (PMTreeNode *)nodeOfElement:(id)element
{
    PMTreeNode *node = _rootNode;
    while (node != nil) {
        NSInteger cmp = [self compareE1:element withE2:node.value];
        if (cmp == 0) {
            return node;
        }
        else if(cmp > 0)
        {
            node = node.right;
        }
        else if (cmp < 0)
        {
            node = node.left;
        }
    }
    
    return node;
}

- (BOOL)containsElement:(id)element
{
    return [self nodeOfElement:element] ? YES : NO;
}

- (NSInteger)compareE1:(id)value1 withE2:(id)value2
{
    if (_compareBlock) {
        return _compareBlock(value1, value2);
    }
    else if ([_compareDelegate respondsToSelector:@selector(compareElement1:withOther:)])
    {
        return [_compareDelegate compareElement1:value1 withOther:value2];
    }
    else
    {
        return [value1 compare:value2];
    }
}


#pragma mark - private method

@end
