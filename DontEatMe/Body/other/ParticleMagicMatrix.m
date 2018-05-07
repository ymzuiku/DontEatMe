//
//  ParticleMagicMatrix.m
//  DontEatMe
//
//  Created by 木尔 铁 on 24/12/14.
//  Copyright (c) 2014 ymMac. All rights reserved.
//

#import "ParticleMagicMatrix.h"

@implementation ParticleMagicMatrix
{
    NSArray *magicePositionArray;
    int p;
    int q;
    NSTimeInterval particleRotationTime;
}

-(id)init
{
    return [self initWithBackGroundIamge:@"matrix-5.png"];
}

-(id)initWithBackGroundIamge:(NSString *)ImageName
{
    if (self = [super init]) {
        self.backGroundImage = [[SKSpriteNode alloc] initWithImageNamed:ImageName];
        [self addChild:self.backGroundImage];
        self.particleImageName = @"sparkParticle";
        particleRotationTime = 0.5;
        
        self.xScale = 0.45;
        self.yScale = 0.35;
    }
    return self;
}

-(void)startup
{
    magicePositionArray = @[
                            @"{0,183}",@"{25,182}",@"{50,178}",@"{75,170}",@"{100,159}",@"{125,145}",@"{150,124}",@"{175,96}",@"{192,67}",@"{202,38}",@"{205,0}",
                           @"{202,-38}",@"{192,-67}",@"{175,-96}",@"{150,-124}",@"{125,-145}",@"{100,-159}",@"{75,-170}",@"{50,-178}",@"{25,-182}",@"{0,-183}",
                            @"{-25,-182}",@"{-50,-178}",@"{-75,-170}",@"{-100,-159}",@"{-125,-145}",@"{-150,-124}",@"{-175,-96}",@"{-192,-67}",@"{-202,-38}",@"{-205,0}",
                            @"{-202,38}",@"{-192,67}",@"{-175,96}",@"{-150,124}",@"{-125,145}",@"{-100,159}",@"{-75,170}",@"{-50,178}",@"{-25,182}"
                            ];
    
    SKEmitterNode *fireEmitter1;
    fireEmitter1.name = @"fire1";
    fireEmitter1 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:self.particleImageName ofType:@"sks"]];
    
    [self addChild:fireEmitter1];
    fireEmitter1.hidden = NO;
    
    SKEmitterNode *fireEmitter2;
    fireEmitter2.name = @"fire2";
    fireEmitter2 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:self.particleImageName ofType:@"sks"]];
    
    [self addChild:fireEmitter2];
    fireEmitter2.hidden = NO;

    SKEmitterNode *fireEmitter3;
    fireEmitter3.name = @"fire3";
    fireEmitter3 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:self.particleImageName ofType:@"sks"]];
    
    [self addChild:fireEmitter3];
    fireEmitter3.hidden = NO;
    
    SKEmitterNode *fireEmitter4;
    fireEmitter4.name = @"fire4";
    fireEmitter4 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:self.particleImageName ofType:@"sks"]];
    
    [self addChild:fireEmitter4];
    fireEmitter4.hidden = NO;
    
    SKEmitterNode *fireEmitter5;
    fireEmitter5.name = @"fire5";
    fireEmitter5 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:self.particleImageName ofType:@"sks"]];
    
    [self addChild:fireEmitter5];
    fireEmitter5.hidden = NO;
    
    SKEmitterNode *fireEmitter6;
    fireEmitter6.name = @"fire6";
    fireEmitter6 = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:self.particleImageName ofType:@"sks"]];
    
    [self addChild:fireEmitter6];
    fireEmitter6.hidden = NO;

    
    p = 0;
    
//    int distance = 6;
    SKAction *wait = [SKAction waitForDuration:0.03];
    SKAction *magiceBLock = [SKAction runBlock:^{
        
        if (p<39) {
            p = p+1;
        }else{
            p = 0;
        }
        if (q<39) {
            q = q+1;
        }else{
            q = 0;
        }
        
        SKAction *fire1Position = [SKAction moveTo:CGPointFromString([magicePositionArray objectAtIndex:(p>39?p-40:p)]) duration:particleRotationTime];
        SKAction *fire2Position = [SKAction moveTo:CGPointFromString([magicePositionArray objectAtIndex:(p+13>39?p+13-40:p+13)]) duration:particleRotationTime];
        SKAction *fire3Position = [SKAction moveTo:CGPointFromString([magicePositionArray objectAtIndex:(p+26>39?p+26-40:p+26)]) duration:particleRotationTime];
        
        SKAction *fire4Position = [SKAction moveTo:CGPointFromString([magicePositionArray objectAtIndex:(q>39?q-40:q)]) duration:particleRotationTime];
        SKAction *fire5Position = [SKAction moveTo:CGPointFromString([magicePositionArray objectAtIndex:(q+13>39?q+26-40:q+13)]) duration:particleRotationTime];
        SKAction *fire6Position = [SKAction moveTo:CGPointFromString([magicePositionArray objectAtIndex:(q+26>39?q+26-40:q+26)]) duration:particleRotationTime];
        

        [fireEmitter1 runAction:fire1Position];
        [fireEmitter2 runAction:fire2Position];
        [fireEmitter3 runAction:fire3Position];
        
        [fireEmitter4 runAction:fire4Position];
        [fireEmitter5 runAction:fire5Position];
        [fireEmitter6 runAction:fire6Position];
        
    }];
    SKAction *endBLock = [SKAction runBlock:^{

    }];
    SKAction *seq = [SKAction sequence:@[magiceBLock,wait,endBLock]];
    [self runAction:[SKAction repeatActionForever:seq] withKey:@"magice"];
    
}

@end
