/*
 * Copyright 2014 cloudmatch.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "CMSwipeTranslationHelper.h"

#import "CMJsonConstants.h"

@implementation CMSwipeTranslationHelper

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
            area = kCMAreaTop;
            break;
        case kViewAreaRight:
            area = kCMAreaRight;
            break;
        case kViewAreaBottom:
            area = kCMAreaBottom;
            break;
        case kViewAreaLeft:
            area = kCMAreaLeft;
            break;
        case kViewAreaInner:
            area = kCMAreaInner;
            break;
        case kViewAreaInvalid:
            area = kCMAreaInvalid;
            break;
            
        default:
            break;
    }
    
    return area;
}

@end
