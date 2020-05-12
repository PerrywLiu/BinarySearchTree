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
{
    ///如果删除的节点是红色，
    ///或者用于取代删除节点的子节点是红色，即删除的是黑色节点，该节点有红色子节点
    if ([self isRedNode:node]) {
        [self blackNode:node];
        return;
    }
    
    PMTreeNode *parent = node.parent;
    /// 删除的是根节点
    if (parent == nil) {
        return;
    }
    
    ///删除的是黑色叶子节点，产生下溢
    ///1.红兄弟
    ///  父节点染红，兄弟节点染黑，旋转，更新兄弟节点，又回到黑兄弟的情况
    ///2.黑兄弟
    ///  a.兄弟节点至少有一个红色子节点，进行旋转
    ///  b.兄弟没有子节点，父节点染黑，兄弟节点染红，将父节点当做删除后的节点进行处理，递归调用
    
    ///判断被删除的节点是左还是右
    BOOL left = parent.left == nil || node.isLeftChild;
    PMTreeNode *sibling = left ? parent.right : parent.left;
    if (left) {
        ///左节点
        
        if ([self isRedNode:sibling]) {
            ///红兄弟
            [self blackNode:sibling];
            [self redNode:parent];
            
            [self rotateLeft:parent];
            sibling = parent.right;
        }
       
        ///兄弟节点必然是黑色
        if ([self isBlackNode:sibling.left] && [self isBlackNode:sibling.right]) {
            ///兄弟节点没有红子节点，不能借出，父节点与兄弟节点合并
            BOOL parentBlack = [self isBlackNode:parent];
            [self redNode:sibling];
            [self blackNode:parent];
            if (parentBlack) {
                [self afterRemove:parent];
            }
        }
        else
        {
            ///兄弟节点至少一个红色子节点，向兄弟节点借元素
            if ([self isBlackNode:sibling.right]) {
                [self rotateRight:sibling];
                sibling = parent.right;
            }
            
            ///将sibling染成父节点的颜色
            BOOL parentColor = [self isRedNode:parent];
            [self colorNode:sibling color:parentColor];
            
            [self blackNode:sibling.right];
            [self blackNode:parent];
            [self rotateLeft:parent];
        }
    }
    else
    {
        ///被删除节点在右侧
//        PMTreeNode *sibling = node.sibling;
        if ([self isRedNode:sibling]) {
            
            [self blackNode:sibling];
            [self redNode:parent];
            [self rotateRight:parent];
            sibling = parent.left;
        }
        
        ///兄弟节点都是黑色
        ///兄弟节点有红色子节点，可以借出
        ///兄弟节点没有红色子节点，不可以借出元素
        if ([self isBlackNode:sibling.left] && [self isBlackNode:sibling.right]) {
            ///兄弟节点不能借出元素，父节点与兄弟节点合并
            BOOL parentIsBlack = [self isBlackNode:parent];
            [self blackNode:parent];
            [self redNode:sibling];
            
            if (parentIsBlack) {
                [self afterRemove:parent];
            }
        }
        else
        {
            ///兄弟节点可以借出元素
            if ([self isBlackNode:sibling.left]) {
                [self rotateLeft:sibling];
                sibling = parent.left;
            }
            
            ///将兄弟节点染成父节点的颜色
            BOOL parentColor = [self isRedNode:parent];
            [self colorNode:sibling color:parentColor];
            ///将sibling左右子树染黑
            [self blackNode:sibling.left];
            [self blackNode:parent];
            [self rotateRight:parent];
            
        }
    }
}

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
