/*
 * Copyright 2014 Fabio cloudmatch.io
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

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, ViewArea) {
    kViewAreaTop = 0,
    kViewAreaBottom = 1,
    kViewAreaLeft = 2,
    kViewAreaRight = 3,
    kViewAreaInner = 4,
    kViewAreaInvalid = 5
};

typedef NS_ENUM(NSInteger, Movement){
    kMovementInvalid,
    kMovementInnerTop,
    kMovementInnerLeft,
    kMovementInnerRight,
    kMovementInnerBottom,
    kMovementTopInner,
    kMovementTopLeft,
    kMovementTopRight,
    kMovementTopBottom,
    kMovementBottomInner,
    kMovementBottomLeft,
    kMovementBottomRight,
    kMovementBottomTop,
    kMovementLeftInner,
    kMovementLeftRight,
    kMovementLeftBottom,
    kMovementLeftTop,
    kMovementRightTop,
    kMovementRightInner,
    kMovementRightLeft,
    kMovementRightBottom
};

typedef NS_ENUM(NSInteger, SwipeType) {
    kSwipeIncoming,
    kSwipeOutgoing,
    kSwipeTransitive,
    kSwipeNotSupported
};

@interface CMSwipeConstants : NSObject

@end
