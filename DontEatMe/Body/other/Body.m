//
//  Body.m
//  DontEatMe
//
//  Created by pringlesfox on 9/1/14.
//  Copyright (c) 2014 pringlesfox. All rights reserved.
//



static int idNumberStatic = 1;

@implementation Body
{
    SKAction *changeColorAction;
}

#pragma mark remove
-(void)removeFromParent
{
    [self removeAllActions];
    [self removeAllChildren];
    [super removeFromParent];
}

#pragma mark init
-(id)init
{
    if (self = [super init]) {
        [self createInit];
    }
    return self;
}

-(id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture]) {
        [self createInit];
    }
    return self;
}

-(id)initWithColor:(UIColor *)color size:(CGSize)size
{
    if (self = [super initWithColor:color size:size]) {
        [self createInit];
    }
    return self;
}

-(void)createInit
{
    self.myName = @"body";  //未来在所有body设置完myName之后,记得删掉
    idNumberStatic++;
    self.idNumber = idNumberStatic;
    self.isSkillCDing = YES;
    self.theChangeColor = [UIColor yellowColor];
    self.speedAttack = 1;
    self.speedMove = 1;
    self.speedRest = 1;
    self.speedSkill = 1;
    self.defSpeedAttack = 1;
    self.defSpeedMove = 1;
    self.defSpeedRest = 1;
    self.defSpeedSkill = 1;
    self.paceRate = 1;
    self.dropObj = @"0";
    self.dropMoreObj = @"0";
    self.canNotChangeStatus = @[];
//    self.speed = iSpeed;
    self.speed = 1.4;
}

-(void)startup
{
    [self addHpBar:CGPointMake(hpPosX, hpPosY) name:self.texString_hpBar];
    self.hpBar.hidden = YES;
}

-(void)sitDefaultHP:(int)hp
{
    self.defaultHP = hp;
    self.nowHP = hp;
}

#pragma mark addHP,CD
-(void)addHpBar:(CGPoint)pos name:(NSString *)name;
{
    self.hpBar = [[HPBar alloc] initWithName:name];
    [self addChild:_hpBar];
    _hpBar.position = pos;
    _hpBar.defaultHP_HPBar = _defaultHP;
}

-(void)addSkillBar:(CGPoint)pos name:(NSString *)name skillTime:(float)skillTime;
{
    self.skillBar = [[SkillBar alloc] initWithName:name];
    [self addChild:_skillBar];
    _skillBar.position = pos;
    _skillBar.defaultSkillCD_skillBar = skillTime;
}

-(void)addCDBar:(CGPoint)pos name:(NSString *)name beginName:(NSString *)beginName
{
    _cdBar = [[CDBar alloc] initWithName:name beginName:beginName];
    [self addChild:_cdBar];
    _cdBar.position = pos;
    _cdBar.defaultAllTime = _skillCD;
}

#pragma mark collSprite
-(void)reloadRect
{
    self.attackRect = CGRectMake(self.position.x+self.defAttackRect.origin.x, self.position.y+self.defAttackRect.origin.y, self.defAttackRect.size.width, self.defAttackRect.size.height);
    self.boxRect = CGRectMake(self.position.x+self.defBoxRect.origin.x, self.position.y+self.defBoxRect.origin.y, self.defBoxRect.size.width, self.defBoxRect.size.height);
}

#pragma mark changeColor
-(void)changeColor
{
    if (self.isChangeColoring) {
        return;
    }
    if (changeColorAction == nil) {
        SKAction *changeColorActionDown = [SKAction colorizeWithColor:self.theChangeColor colorBlendFactor:1 duration:0.2];
        SKAction *changeColorActionUp = [SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:0 duration:0.2];
        SKAction *setchangeColor = [SKAction runBlock:^{
            self.isChangeColoring = NO;                  //必须写在 Action 里才能保证不被重复激发
        }];
        changeColorAction = [SKAction sequence:@[changeColorActionDown,changeColorActionUp,setchangeColor]];
    }
    self.isChangeColoring = YES;
    [self runAction:changeColorAction];
}

#pragma mark KillSelf
-(BOOL)changeHP:(int)hurt attacker:(Body *)attacker
{
    if (hurt < 0 && (self.nowHP - hurt) >= self.defaultHP) {
            self.nowHP = self.defaultHP;
            [self.hpBar changeHPBar:self.nowHP];
            return NO;
    }else if (hurt < 0 && (self.nowHP - hurt) < self.defaultHP) {
            self.nowHP += hurt;
            [self.hpBar changeHPBar:self.nowHP];
            return NO;
    }    
    if (self.shieldBuff.isBuffing) {
        [self.shieldBuff shieldChangeHP:hurt];
        return NO;
    }
    if (self.snailBuff.isBuffing) {
        hurt *= self.snailBuff.changeHPRate;
    }
    self.nowHP -= hurt;
    if (attacker.haveBuffSkill) {
        [self beSkillWithAttacker:attacker];
    }
    if (self.nowHP <= 0) {
        self.nowHP = -1;
        attacker.attackBody = nil;
        [self useDie];
    }
    else if (self.nowHP > self.defaultHP) {
        self.nowHP = self.defaultHP;
    }
    else if(self.nowHP > 0){
        if (hurt > 0) {
            [self changeColor];
            
            //变普通小鸡
            if (self.haveNormalChicken_time > 0 && self.nowHP <= self.defaultHP*0.3) {
                [self beBuff_normalChicken];
            }
            if (hurt > 9 && [self.name isEqualToString:@"chicken"]) {
                int random = skRand(0, 2);
                if (random == 0) {
                    [self runAction:self.soundAction_changeHPA];
                }
                else {
                    [self runAction:self.soundAction_changeHPB];
                }
            }
        }
    }
    
    if (self.hpBar.hidden == YES) {
        self.hpBar.hidden = NO;
    }
    [self.hpBar changeHPBar:self.nowHP];
    
    if (self.nowHP > 0) {
        return NO;
    }
    else {
        return YES;  //返回是否死掉
    }
}
-(void)useDie
{
    self.isCanNotCoill = YES;
    self.nowHP = 0;
    self.defBoxRect = CGRectMake(1000, 0, -1, -1);
    [self removeAllActions];
    [self removeFromParent];
}

#pragma mark 基础动画
-(BOOL)changCanStatusRun:(NSString *)s_beBuff;
{
    if ([self.nowStatus isEqualToString:s_die]) {
        return NO;
    }
    BOOL isCanRun = YES;
    for (NSString *status in self.canNotChangeStatus) {
        if ([status isEqualToString:s_beBuff]) {
            isCanRun = NO;
            return NO;
            break;
        }
    }
    if (isCanRun == YES) {
        [self removeActionForKey:self.nowStatus];
        self.nowStatus = s_beBuff;
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark 所有Buff
//负面buff
-(void)beSkillWithAttacker:(Body *)attacker;
{
    if (attacker.haveBinding_time) {
        [self beBuff_binding:attacker.haveBinding_time attack:attacker.haveBinding_attack];
    }
    if (attacker.haveDizzy_time) {
        [self beBuff_dizzy:attacker.haveDizzy_time random:attacker.haveDizzy_random];
    }
    if (attacker.haveDizzyLong_time) {
        [self beBuff_dizzyLong:attacker.haveDizzyLong_time];
    }
    if (attacker.haveIce_time) {
        [self beBuff_ice:attacker.haveIce_time attackSpeed:attacker.haveIce_attackSpeed];
    }
    if (attacker.havePoison_time) {
        [self beBuff_poison:attacker.havePoison_time attack:attacker.havePoison_attack];
    }
    if (attacker.haveSleep_time) {
        [self beBuff_sleep:attacker.haveSleep_time];
    }
    if (attacker.haveSlow_time) {
        [self beBuff_slow:attacker.haveSlow_time moveSpeed:attacker.haveSlow_moveSpeed attackSpeed:attacker.haveSlow_attackSpeed];
    }
    if (attacker.haveSnail_time) {
        [self beBuff_snail:attacker.haveSnail_time changeHPRate:attacker.haveSnail_changeHPRate];
    }
    if (attacker.haveBoom_time) {
        [self beBuff_Boom:attacker.haveBoom_time hurt:attacker.haveBoom_hurt];
    }
    if (attacker.haveFlash_time) {
        [self beBuff_Flash:attacker.haveBoom_time hurt:attacker.haveBoom_hurt];
    }
    if (attacker.haveStave_time) {
        [self beBuff_Stave:attacker.haveStave_time hurt:attacker.haveStave_hurt];
    }
    if (attacker.haveNormalChicken_time > 0) {
        [self beBuff_normalChicken];
    }
    if (attacker.haveYoda_time) {
        [self beBuff_Yoda:attacker.haveYoda_time hurt:attacker.haveYoda_hurt];
    }
    
    //test 增益buff,不在这里使用,只做测试
    if (attacker.haveShield_time) {
        [self beBuff_Shield:attacker.haveShield_time shieldHP:attacker.haveShield_hp noDieTime:attacker.haveShield_noDieTime];
    }
    if (attacker.haveCure_time) {
        [self beBuff_Cure:attacker.haveCure_time hp:attacker.haveCure_rate];
    }
    if (attacker.haveAmok_time) {
        [self beBuff_Amok:attacker.haveAmok_time speed:attacker.haveAmok_speed];
    }
    if (attacker.haveRecovery_time) {
        [self beBuff_recovery:attacker.haveRecovery_time miniCD:attacker.haveRecovery_miniCD hurt:attacker.haveRecovery_hurt];
    }
}


-(void)beBuff_ice:(float)time attackSpeed:(float)attackSpeed;
{
    if (!self.iceBuff) {
        _iceBuff = [[IceBuff alloc] initWithBody:self];
        [self addChild:_iceBuff];
    }
    _iceBuff.time = time;
    _iceBuff.moveSpeed = 0;
    _iceBuff.attackSpeed = attackSpeed;
    [_iceBuff beginBuff];
}
-(void)beBuff_dizzy:(float)time random:(int)random;
{
    int theRandom = arc4random()%100-1;
    if (theRandom > random) {
        return;
    }
    if (!_dizzyBuff) {
        _dizzyBuff = [[DizzyBuff alloc] initWithBody:self];
        [self addChild:_dizzyBuff];
    }
    _dizzyBuff.time = time;
    _dizzyBuff.attackSpeed = 0;
    _dizzyBuff.moveSpeed = 0;
    _dizzyBuff.skillSpeed = 0;
    [_dizzyBuff beginBuff];
}

-(void)beBuff_dizzyLong:(float)time
{
    if (!_dizzyLoingBuff) {
        _dizzyLoingBuff = [[DizzyLongBuff alloc] initWithBody:self];
        [self addChild:_dizzyLoingBuff];
    }
    _dizzyLoingBuff.time = time;
    [_dizzyLoingBuff beginBuff];
}

-(void)beBuff_poison:(float)time attack:(float)value;
{
    if (!_poisonBuff) {
        _poisonBuff = [[PoisonBuff alloc] initWithBody:self];
        [self addChild:_poisonBuff];
    }
    _poisonBuff.time = time;
    _poisonBuff.hurt = value;
    [_poisonBuff beginBuff];
}
-(void)beBuff_slow:(float)time moveSpeed:(float)value attackSpeed:(float)valueB
{
    if (!_slowBuff) {
        _slowBuff = [[SlowBuff alloc] initWithBody:self];
        [self addChild:_slowBuff];
    }
    _slowBuff.time = time;
    _slowBuff.moveSpeed = value;
    _slowBuff.attackSpeed = valueB;
    [_slowBuff beginBuff];
}
-(void)beBuff_binding:(float)time attack:(float)value;
{
    if (!_bindingBuff) {
        _bindingBuff = [[BindingBuff alloc] initWithBody:self];
        [self addChild:_bindingBuff];
    }
    _bindingBuff.time = time;
    _bindingBuff.hurt = value;
    [_bindingBuff beginBuff];
}
-(void)beBuff_sleep:(float)time
{
    if (!_sleepBuff) {
        _sleepBuff = [[SleepBuff alloc] initWithBody:self];
        [self addChild:_sleepBuff];
    }
    _sleepBuff.time = time;
    [_sleepBuff beginBuff];
}
-(void)beBuff_snail:(float)time changeHPRate:(float)value;
{
    if (!_snailBuff) {
        _snailBuff = [[SnailBuff alloc] initWithBody:self];
        [self addChild:_snailBuff];
    }
    _snailBuff.time = time;
    _snailBuff.changeHPRate = value;
    [_snailBuff beginBuff];
}

-(void)beBuff_normalChicken
{
    ViewController *vc = [ViewController single];
    if (!_normalChickenBuff) {
        _normalChickenBuff = [[NormalChickenBuff alloc] initWithBody:self];
        _normalChickenBuff.position = CGPointMake(self.position.x+40, self.position.y);
        _normalChickenBuff.zPosition = self.zPosition;
        [vc.gameScene.war addChild:_normalChickenBuff];
    }
    [_normalChickenBuff beginBuff];
}

-(void)beBuff_Boom:(float)time hurt:(float )theHurt
{
    if (!_boomBuff) {
        _boomBuff = [[BoomBuff alloc] initWithBody:self];
        [self addChild:_boomBuff];
    }
    _boomBuff.time = time;
    _boomBuff.hurt = theHurt;
    [_boomBuff beginBuff];
}

-(void)beBuff_Flash:(float)time hurt:(float )theHurt
{
    if (!_flashBuff) {
        _flashBuff = [[FlashBuff alloc] initWithBody:self];
        [self addChild:_flashBuff];
    }
    _flashBuff.time = time;
    _flashBuff.hurt = theHurt;
    [_flashBuff beginBuff];
}

-(void)beBuff_Yoda:(float)time hurt:(float )theHurt
{
    if (!_yodaBuff) {
        _yodaBuff = [[YodaBuff alloc] initWithBody:self];
        [self addChild:_yodaBuff];
    }
    _yodaBuff.time = time;
    _yodaBuff.hurt = theHurt;
    [_yodaBuff beginBuff];
}

-(void)beBuff_Stave:(float)time hurt:(float )theHurt
{
    if (!_staveBuff) {
        _staveBuff = [[StaveBuff alloc] initWithBody:self];
        [self addChild:_staveBuff];
    }
    _staveBuff.time = time;
    _staveBuff.hurt = theHurt;
    [_staveBuff beginBuff];
}

-(void)beBuff_Floor:(float)time hurt:(float)theHurt
{
    FloorBuff *floorBuff = [[FloorBuff alloc] initWithBody:self];
    ViewController *vc = [ViewController single];
    floorBuff.position = self.position;
    [vc.gameScene.war addChild:floorBuff];
    
    floorBuff.time = time;
    floorBuff.hurt = theHurt;
    [floorBuff beginBuff];
}


//增益buff
-(void)beBuff_Shield:(float)time shieldHP:(int)shieldHP noDieTime:(float)noDieTime;
{
    if (!_shieldBuff) {
        _shieldBuff = [[ShieldBuff alloc] initWithBody:self];
        [self addChild:_shieldBuff];
    }
    
    if (_shieldBuff.shieldHP == -1) {
        _shieldBuff.time = time;
        _shieldBuff.shieldHP = shieldHP;
        _shieldBuff.noDieTime = noDieTime;
        [_shieldBuff beginBuff];
    }
}
-(void)beBuff_Cure:(float)time hp:(float)addHPRate
{
    if (!_cureBuff) {
        _cureBuff = [[CureBuff alloc] initWithBody:self];
        [self addChild:_cureBuff];
    }
    _cureBuff.time = time;
    _cureBuff.addHPRate = addHPRate;
    [_cureBuff beginBuff];
}

-(void)beBuff_Amok:(float)time speed:(float)speed
{
    if (!_amokBuff) {
        _amokBuff = [[AmokBuff alloc] initWithBody:self];
        [self addChild:_amokBuff];
    }
    _amokBuff.time = time;
    _amokBuff.attackSpeed = speed;
    _amokBuff.moveSpeed = speed;
    [_amokBuff beginBuff];
}

-(void)beBuff_recovery:(float)time miniCD:(float)miniCD hurt:(int)hurt
{
    if (!_recoveryBuff) {
        _recoveryBuff = [[RecoveryBuff alloc] initWithBody:self];
        [self addChild:_recoveryBuff];
    }
    _recoveryBuff.time = time;
    _recoveryBuff.hurt = hurt;
    _recoveryBuff.miniCDtime = miniCD;
    [_recoveryBuff beginBuff];
}

#pragma mark 修改speed
-(void)reloadAllSpeed
{
    float oldMove = self.speedMove;
    float oldAttack = self.speedAttack;
    float oldSkill = self.speedSkill;
    
    
    float slowMove = 1;
    float dizzyMove = 1;
    float iceMove = 1;
    float amokMove = 1;
    float bindingMove = 1;
    float snailMove = 1;
    
    float slowAttack = 1;
    float dizzyAttack = 1;
    float iceAttack = 1;
    float amokAttack = 1;
    float bindingAttack = 1;
    
    float slowSkill = 1;
    float dizzySkill = 1;
    float iceSkill = 1;
    float amokSkill = 1;
    float bindingSkill = 1;
    
    if (_slowBuff.isBuffing) {
        slowMove = _slowBuff.moveSpeed;
        slowAttack = _slowBuff.attackSpeed;
        slowSkill = _slowBuff.skillSpeed;
    }
    if (_dizzyBuff.isBuffing) {
        dizzyMove = _dizzyBuff.moveSpeed;
        dizzyAttack = _dizzyBuff.attackSpeed;
        dizzySkill = _dizzyBuff.skillSpeed;
    }
    if (_iceBuff.isBuffing) {
        iceMove = _iceBuff.moveSpeed;
        iceAttack = _iceBuff.attackSpeed;
        iceSkill = _iceBuff.skillSpeed;
    }
    if (_amokBuff.isBuffing) {
        amokMove = _amokBuff.moveSpeed;
        amokAttack = _amokBuff.attackSpeed;
        amokSkill = _amokBuff.skillSpeed;
    }
    if (_bindingBuff.isBuffing) {
        bindingMove = _bindingBuff.moveSpeed;
        bindingAttack = _bindingBuff.attackSpeed;
        bindingSkill = _bindingBuff.skillSpeed;
    }
    if (_snailBuff.isBuffing) {
        snailMove = _snailBuff.moveSpeed;
    }
    self.speedMove = self.defSpeedMove * slowMove * dizzyMove * iceMove * amokMove * bindingMove * snailMove;
    self.speedAttack = self.defSpeedAttack * slowAttack * dizzyAttack * iceAttack * amokAttack * bindingAttack;
    self.speedSkill = self.defSpeedSkill * slowSkill * dizzySkill * iceSkill * amokSkill * bindingSkill;
    
    if (oldMove != self.speedMove) {
        self.moveAction = nil;
    }
    if (oldAttack != self.speedAttack) {
        self.attackAction = nil;
    }
    if (oldSkill != self.speedSkill) {
        self.skillAction = nil;
    }
}

-(void)resetZPostion
{
    self.zPosition = (1999-self.position.y);
}


#pragma mark 子类实现的方法
-(void)useAttack{}
-(void)useAttack:(NSArray *)notChangeArray{}
-(void)useSkill{}
-(void)useSkill:(NSArray *)notChangeArray{}
-(void)useMove{}
-(void)useMove:(NSArray *)notChangeArray{}
-(void)useRest{}
-(void)useRest:(NSArray *)notChangeArray{}
-(void)pause{}
-(void)goon{}
-(void)reloadStartSkill{}

+(void)clearStatic
{
    idNumberStatic = 1;
}

-(void)useDieBase{return;}
-(void)beColliedBy:(Body *)body{return;}

@end
