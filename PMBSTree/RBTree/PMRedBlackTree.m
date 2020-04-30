//
//  PMRedBlackTree.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/30.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMRedBlackTree.h"
#import "PMRBNode.h"

@implementation PMRedBlackTree

- (PMTreeNode *)createNode:(id)element andParent:(PMTreeNode *)parentNode
{
    return [[PMRBNode alloc]initValue:element withParent:parentNode];
}

- (void)afterAdd:(PMTreeNode *)node
{
    PMTreeNode *parent = node.parent;
    if (parent == nil) {
        ///添加节点为根节点，或者上溢为根节点
        [self colorNode:node color:BLACK];
        return;
    }
    
    /**
     *1.父节点为黑色节点，直接添加
     */
    if ([self isBlackNode:parent]) {
        return;
    }
    
    /**
     *2.父节点为红色，出现两个红节点相连的情况，不符合红黑树性质
     *  2.1叔父节点为红色，产生上溢，此时将父节点和叔父节点染黑，将祖父节点作为新添加节点处理，递归
     *  2.2叔父节点为黑色，分LL，LR，RR，RL情况，进行旋转
     *      LL：祖父节点右旋转；
     *          父节点染黑，祖父节点染红
     *      LR：父节点左旋转，祖父节点右旋转；
     *          祖父节点染红，当前节点染黑
     *      RR：祖父节点左旋转；
     *          父节点染黑，祖父节点染红
     *      RL：父节点右旋转，祖父节点左旋转；
     *          祖父节点染红，当前节点染黑
     */
    
    PMTreeNode *uncle = parent.sibling;
    PMTreeNode *grand = parent.parent;
    if ([self isRedNode:uncle]) {
        ///叔父节点为红
        [self colorNode:parent color:BLACK];
        [self colorNode:uncle color:BLACK];
        [self colorNode:grand color:RED];
        
        ///此时叔父节点变为黑节点，再次执行调整代码
        [self afterAdd:grand];
        return;
    }
    else
    {
        ///叔父节点为黑色
        if ([parent isLeftChild]) {
            if ([node isLeftChild]) {
                ///LL
                [self colorNode:parent color:BLACK];
                [self colorNode:grand color:RED];
                                
                [self rotateRight:grand];
            }
            else
            {
                ///LR
                [self colorNode:node color:BLACK];
                [self colorNode:grand color:RED];
                
                [self rotateLeft:parent];
                [self rotateRight:grand];
            }
        }
        else
        {
            if ([node isRightChild]) {
                ///RR
                [self colorNode:grand color:RED];
                [self colorNode:parent color:BLACK];
                
                [self rotateLeft:grand];
            }
            else
            {
                ///RL
                [self colorNode:node color:BLACK];
                [self colorNode:grand color:RED];
                
                [self rotateRight:parent];
                [self rotateLeft:grand];
            }
        }
    }
}

- (void)afterRemove:(PMTreeNode *)node
{}

#pragma mark - privateMethod

/// 给节点染色
/// @param node 需要染色的节点
/// @param color 要染的颜色
- (PMTreeNode *)colorNode:(PMTreeNode *)node color:(BOOL)color
{
    if (node == nil) {
        return nil;
    }
    
    ((PMRBNode *)node).color = color;
    return node;
}

/// 给节点染成红色
/// @param node 要染色的节点
- (PMTreeNode *)redNode:(PMTreeNode *)node
{
    return [self colorNode:node color:RED];
}

/// 给节点染成黑色
/// @param node 要染色的节点
- (PMTreeNode *)blackNode:(PMTreeNode *)node
{
    return [self colorNode:node color:BLACK];
}

- (BOOL)colorOfNode:(PMTreeNode *)node
{
    return node == nil ? BLACK : ((PMRBNode *)node).color == RED;
}

/// 判断节点是否为黑节点
/// @param node 节点
- (BOOL)isBlackNode:(PMTreeNode *)node
{
    return [self colorOfNode:node] == BLACK;
}

/// 判断节点是否为红节点
/// @param node 节点
- (BOOL)isRedNode:(PMTreeNode *)node
{
    return [self colorOfNode:node] == RED;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
