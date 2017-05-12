//
//  JoyStick.m
//  Created by Michael Lowe on 5/11/17.
//
/*
 Example GameScene.m:
 
 #import "GameScene.h"
 #import "JoyStick.h"
 
 @implementation GameScene {
 
 JoyStick *your_joystick;
 SKSpriteNode *player;
 }
 
 - (void)didMoveToView:(SKView *)view {
 
 [self createJoystick];
 
 player = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship.png"];
 CGSize scr = self.scene.frame.size;
 SKConstraint *c = [SKConstraint
 positionX:[SKRange rangeWithLowerLimit:-scr.width/2 upperLimit:scr.width/2]
 Y:[SKRange rangeWithLowerLimit:-scr.height/2 upperLimit:scr.height/2]];
 player.constraints = @[c];
 [self addChild:player];
 }
 
 - (void) createJoystick {
 your_joystick = [[JoyStick alloc] init];
 your_joystick.position = CGPointMake(0, -500);
 [your_joystick setSpeed:1];
 [self addChild:your_joystick];
 }
 
 -(void)update:(CFTimeInterval)currentTime {
 [player runAction:[SKAction moveBy:your_joystick.velocity duration:0.1]];
 }
 
 @end
 */

#import "JoyStick.h"

@implementation JoyStick {
    BOOL touchedThumbstick;
    SKSpriteNode *thumbstick;
}

- (id) init {
    if (self = [super init]) {
        self = [JoyStick spriteNodeWithImageNamed:@"circle.png"];
        self.userInteractionEnabled = YES;
        [self setJoyStickDetails];
        [self setThumbstickDetails];
    }
    return self;
}

-(void) setJoyStickDetails {
    self.name = @"joystick";
    self.anchorPoint = CGPointMake(0.5f, 0.5f);
    self.alpha = 0.5;
    self.speed = 1;
    self.angle = 0;
    
}


- (void) setThumbstickDetails {
    thumbstick = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"];
    thumbstick.name = @"thumbstick";
    thumbstick.zPosition = 1;
    thumbstick.xScale = 0.5f;
    thumbstick.yScale = 0.5f;
    thumbstick.position = self.position;
    SKConstraint *tc = [SKConstraint distance:[SKRange rangeWithLowerLimit:0.f upperLimit:self.size.width/2] toPoint:self.position];
    thumbstick.constraints = @[tc];
    [self addChild:thumbstick];
}

- (CGFloat) pointPairToAngle:(CGPoint)startingPoint secondPoint:(CGPoint) endingPoint {
    float dx = endingPoint.x  - startingPoint.x;
    float dy = endingPoint.y  - startingPoint.y;
    float deltaAngle = atan2(dy,dx);
    float angleDegrees = deltaAngle * (180.0f / M_PI);
    return angleDegrees;
}

- (void)handleTouchedPoint:(CGPoint)touchedPoint {
    SKNode *touchedNode = [self nodeAtPoint:touchedPoint];
    if ([touchedNode.name isEqualToString:@"thumbstick"]) {
        touchedThumbstick = true;
    }
}

- (void) handleJoystickPosition:(CGPoint)pos {
    thumbstick.position = pos;
    CGFloat dx = (thumbstick.position.x)/(10/self.speed);
    CGFloat dy = (thumbstick.position.y)/(10/self.speed);
    self.velocity = CGVectorMake(dx, dy);
    if(thumbstick.position.y > 0) {
        self.angle = [self pointPairToAngle:CGPointMake(0, 0) secondPoint:thumbstick.position];
    } else {
        self.angle = 180 + [self pointPairToAngle:thumbstick.position secondPoint:CGPointMake(0, 0)];
    }
    self.angle = (M_PI/180) * self.angle;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    [self handleTouchedPoint:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    if (touchedThumbstick) {
        [self handleJoystickPosition:location];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    touchedThumbstick = false;
    thumbstick.position = CGPointMake(0, 0);
    self.velocity = CGVectorMake(0, 0);
    
}

@end
