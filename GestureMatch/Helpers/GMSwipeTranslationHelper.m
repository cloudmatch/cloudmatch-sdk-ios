//
//  GMSwipeTranslationUtils.m
//  GestureMatchSDK
//
//  Created by Fabio Tiriticco on 22/01/2014.
//  Copyright (c) 2014 LimeBamboo. All rights reserved.
//

#import "GMSwipeTranslationHelper.h"

@implementation GMSwipeTranslationHelper

+ (Movement)decodeMovement:(NSString*)movementStr
{
    if ([movementStr length] < 2) {
        return kMovementInvalid;
    }
    
    ViewArea firstArea = (ViewArea)[[movementStr substringToIndex:1] integerValue];
    ViewArea secondArea = (ViewArea)[[movementStr substringFromIndex:1] integerValue];
    
    Movement movement = kMovementInvalid;
    switch (firstArea) {
        case kViewAreaInner:
            switch (secondArea) {
                case kViewAreaBottom:
                    movement = kMovementInnerBottom;
                    break;
                case kViewAreaLeft:
                    movement = kMovementInnerLeft;
                    break;
                case kViewAreaRight:
                    movement= kMovementInnerRight;
                    break;
                case kViewAreaTop:
                    movement = kMovementInnerTop;
                    break;
                default:
                    break;
            }
            break;
            
        case kViewAreaBottom:
            switch (secondArea) {
                case kViewAreaInner:
                    movement = kMovementBottomInner;
                    break;
                case kViewAreaLeft:
                    movement = kMovementBottomLeft;
                    break;
                case kViewAreaRight:
                    movement = kMovementBottomRight;
                    break;
                case kViewAreaTop:
                    movement = kMovementBottomTop;
                    break;
                default:
                    break;
            }
        case kViewAreaLeft:
            switch (secondArea) {
                case kViewAreaInner:
                    movement = kMovementLeftInner;
                    break;
                case kViewAreaBottom:
                    movement = kMovementLeftBottom;
                    break;
                case kViewAreaRight:
                    movement = kMovementLeftRight;
                    break;
                case kViewAreaTop:
                    movement = kMovementLeftTop;
                    break;
                default:
                    break;
            }
        case kViewAreaRight:
            switch (secondArea) {
                case kViewAreaInner:
                    movement = kMovementRightInner;
                    break;
                case kViewAreaBottom:
                    movement = kMovementRightBottom;
                    break;
                case kViewAreaLeft:
                    movement = kMovementRightLeft;
                    break;
                case kViewAreaTop:
                    movement = kMovementRightTop;
                    break;
                default:
                    break;
            }
        case kViewAreaTop:
            switch (secondArea) {
                case kViewAreaInner:
                    movement = kMovementTopInner;
                    break;
                case kViewAreaBottom:
                    movement = kMovementTopBottom;
                    break;
                case kViewAreaLeft:
                    movement = kMovementTopLeft;
                    break;
                case kViewAreaRight:
                    movement = kMovementTopRight;
                    break;
                default:
                    break;
            }
        default:
            break;
    }
    return movement;
}

+ (SwipeType)decodeSwipe:(Movement)movement
{
    switch (movement) {
        case kMovementInnerBottom:
        case kMovementInnerLeft:
        case kMovementInnerRight:
        case kMovementInnerTop:
            return kSwipeOutgoing;
            break;
            
        case kMovementTopInner:
        case kMovementBottomInner:
        case kMovementLeftInner:
        case kMovementRightInner:
            return kSwipeIncoming;
            break;
            
        case kMovementLeftRight:
        case kMovementLeftTop:
        case kMovementLeftBottom:
        case kMovementBottomRight:
        case kMovementBottomLeft:
        case kMovementBottomTop:
        case kMovementRightTop:
        case kMovementRightLeft:
        case kMovementRightBottom:
        case kMovementTopLeft:
        case kMovementTopRight:
        case kMovementTopBottom:
            return kSwipeTransitive;
            break;
            
        default:
            return kSwipeNotSupported;
            break;
    }
}

+ (NSString*)convertViewAreaToString:(ViewArea)viewArea
{
    NSString *area = @"";
    switch (viewArea) {
        case kViewAreaTop:
            area = kGMAreaTop;
            break;
        case kViewAreaRight:
            area = kGMAreaRight;
            break;
        case kViewAreaBottom:
            area = kGMAreaBottom;
            break;
        case kViewAreaLeft:
            area = kGMAreaLeft;
            break;
        case kViewAreaInner:
            area = kGMAreaInner;
            break;
        case kViewAreaInvalid:
            area = kGMAreaInvalid;
            break;
            
        default:
            break;
    }
    
    return area;
}

@end
