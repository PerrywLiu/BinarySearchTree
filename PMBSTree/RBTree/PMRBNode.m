//
//  PMRBNode.m
//  PMBSTree
//
//  Created by LiuPW on 2020/4/30.
//  Copyright © 2020 LiuPW. All rights reserved.
//

#import "PMRBNode.h"

@implementation PMRBNode
- (instancetype)initValue:(id)value withParent:(PMTreeNode *)parent
{
    self = [super initValue:value withParent:parent];
    if (self) {
        self.color = RED;
    }
    return self;
}

- (NSString *)description
{
    if (self.color == RED) {
        return [NSString stringWithFormat:@"R_%@", [super description]];
    }
    
    return [super description];
}
@end
