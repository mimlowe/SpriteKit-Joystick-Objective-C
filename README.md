# SpriteKit JoyStick Obj-C

A joystick input class written in Objective-C with SpriteKit

### Example

```
// ===== Definition =====
@implementation GameScene {
    JoyStick *joystick;
    SKSpriteNode *player;
}

// ===== Initialization =====
- (void)didMoveToView:(SKView *)view {
  joystick = [[JoyStick alloc] init];

  joystick.position = CGPointMake(x, y);
  joystick.xScale = 1.5f;
  joystick.yScale = 1.5f;
  [joystick setSpeed:1];

  // Add joystick to view
  [self addChild:joystick];
  
  player = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship.png"];
  player.anchorPoint = CGPointMake(0.5f, 0.5f);
  CGSize scr = self.scene.frame.size;
  SKConstraint *c = [SKConstraint
                       positionX:[SKRange rangeWithLowerLimit:-scr.width/2 upperLimit:scr.width/2]
                       Y:[SKRange rangeWithLowerLimit:-scr.height/2 upperLimit:scr.height/2]];
    player.constraints = @[c];
    [self addChild:player];
}

// ===== Implementation =====
-(void)update:(CFTimeInterval)currentTime {
    // Rotational Implementation
    // [player setZRotation:joystick.angle];
    // Linear Implementation
    [player runAction:[SKAction moveBy:joystick.velocity duration:0.1]];
}
```
