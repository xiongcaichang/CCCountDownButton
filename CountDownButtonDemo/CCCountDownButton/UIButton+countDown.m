//
//  UIButton+countDown.m
//  CountDownButtonDemo
//
//  Created by bear on 16/6/17.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "UIButton+countDown.h"
#import <objc/runtime.h>


@interface UIButton ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) NSString *titleString;

@property (nonatomic, assign) NSTimeInterval leaveTime;
@end

@implementation UIButton (countDown)

  static NSString *displayLinkKey;
  static NSString *leaveTimeKey;
  static NSString *titleStringKey;

-(void)setDisplayLink:(CADisplayLink *)displayLink{
    
    objc_setAssociatedObject(self, &displayLinkKey, displayLink, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CADisplayLink *)displayLink{
    return  objc_getAssociatedObject(self, &displayLinkKey);
}


-(void)setLeaveTime:(NSTimeInterval)leaveTime{
    objc_setAssociatedObject(self, &leaveTimeKey, @(leaveTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)leaveTime{
     return  [objc_getAssociatedObject(self, &leaveTimeKey) doubleValue];
}


-(void)setTitleString:(NSString *)titleString{
    objc_setAssociatedObject(self, &titleStringKey, titleString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)titleString{
    
    return objc_getAssociatedObject(self, &titleStringKey);
    
}

-(void)countDownWithTimeInterval:(NSTimeInterval) duration{
    self.titleString=self.currentTitle;
    
    self.leaveTime = duration;
    
    self.enabled=NO;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown)];
    self.displayLink.frameInterval=60;
    
    [self.displayLink  addToRunLoop: [NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    
    
}

-(void)countDown{
    self.leaveTime--;
    
    [self setTitle:[NSString stringWithFormat:@"剩余%d秒",(int)self.leaveTime] forState:UIControlStateDisabled];
    if (self.leaveTime == 0) {
        [self.displayLink invalidate];
        self.displayLink=nil;
        self.enabled=YES;
        [self setTitle:self.titleString forState:UIControlStateNormal];
    }
    
}
@end
