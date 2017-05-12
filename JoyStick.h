//
//  JoyStick.h
//  Created by Michael Lowe on 5/11/17.
//

#import <SpriteKit/SpriteKit.h>

@interface JoyStick : SKSpriteNode

//Velocity output from joystick for player movement
//Usage: [your_sprite runAction:[SKAction moveBy:your_joystick.velocity duration:0.1]];
@property (nonatomic) CGVector velocity;

//Angle output from joystick for player rotation
//Usage: [your_sprite setZRotation:your_joystick.angle];
@property (nonatomic) CGFloat angle;

//for best results, use speeds between 1-10
@property (nonatomic) CGFloat speed;

@end
