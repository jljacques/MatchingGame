//
//  HelloWorldLayer.m
//  MatchingGame
//
//  Created by Jeremy Jacques on 12-03-11.
//  Copyright Jacques Development 2012. All rights reserved.
//


// Import the interfaces
#import "Arctic.h"

// HelloWorldLayer implementation
@implementation ArcticLayer
@synthesize spriteArray, visibleSpriteArray, visibleCoverArray;
@synthesize clickNum, box1Num, pic1String, box2Num, pic2String;
@synthesize coverString, backgroundString;
@synthesize iphoneDivider;
@synthesize animalArray, animaliPadArray;
@synthesize score, scoreString, highScore;
@synthesize gameClock, time, timeString, minutes, bestTime, totalSecs, bestMinutes, tempBestTime;
@synthesize matchNumber;
@synthesize soundString, tempString;

-(void)setupSounds {
    soundEngine = [SimpleAudioEngine sharedEngine];
    [CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_MID];
    [soundEngine preloadEffect:@"lion.wav"];
    [soundEngine preloadEffect:@"chimp.wav"];
    [soundEngine preloadEffect:@"elephnt3.wav"];
    [soundEngine preloadEffect:@"pig2.wav"];
    [soundEngine preloadEffect:@"Rhino2.wav"];
    [soundEngine preloadEffect:@"Hippo.wav"];

}

-(void)gameRestart {
    [self removeChild:sprite1 cleanup:YES];
    [self removeChild:sprite2 cleanup:YES];
    [self removeChild:sprite3 cleanup:YES];
    [self removeChild:sprite4 cleanup:YES];
    [self removeChild:sprite5 cleanup:YES];
    [self removeChild:sprite6 cleanup:YES];
    [self removeChild:sprite7 cleanup:YES];
    [self removeChild:sprite8 cleanup:YES];
    [self removeChild:sprite9 cleanup:YES];
    [self removeChild:sprite10 cleanup:YES];
    [self removeChild:sprite11 cleanup:YES];
    [self removeChild:sprite12 cleanup:YES];

    [self removeChild:coverSprite1 cleanup:YES];
    [self removeChild:coverSprite2 cleanup:YES];
    [self removeChild:coverSprite3 cleanup:YES];
    [self removeChild:coverSprite4 cleanup:YES];
    [self removeChild:coverSprite5 cleanup:YES];
    [self removeChild:coverSprite6 cleanup:YES];
    [self removeChild:coverSprite7 cleanup:YES];
    [self removeChild:coverSprite8 cleanup:YES];
    [self removeChild:coverSprite9 cleanup:YES];
    [self removeChild:coverSprite10 cleanup:YES];
    [self removeChild:coverSprite11 cleanup:YES];
    [self removeChild:coverSprite12 cleanup:YES];
    
    [self removeChild:animalSprite1 cleanup:YES];
    [self removeChild:animalSprite2 cleanup:YES];
    [self removeChild:animalSprite3 cleanup:YES];
    [self removeChild:animalSprite4 cleanup:YES];
    [self removeChild:animalSprite5 cleanup:YES];
    [self removeChild:animalSprite6 cleanup:YES];

    [self removeChild:winSprite cleanup:YES];
    [self removeChild:scoreSprite cleanup:YES];
    [self removeChild:againSprite cleanup:YES];
    
    [self removeChild:scoreLabel cleanup:YES];
    [self removeChild:timeLabel cleanup:YES];

    [self removeChild:bestTimeLabel cleanup:YES];
    [self removeChild:highScoreLabel cleanup:YES];
    
    againBox = CGRectMake(0, 0, 0, 0);
    
    time = 0;
    minutes = 0;
    matchNumber = 0;
    totalSecs = 0;
    score = 500;
    gameClock = [[NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self selector:@selector(timerFireMethod)
                                                userInfo:nil repeats:YES] retain];
    clickNum = 0;
    visibleSpriteArray = [[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES], nil] retain];
    visibleCoverArray = [[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES], nil] retain];
    [self performSelector:@selector(randomPictures)];
    [self performSelector:@selector(setupCards)];

}

-(void)gameComplete {
    [soundEngine playEffect:@"applause.wav"];
    bestMinutes = 0;
    highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    bestTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"BestTime"];
    if (totalSecs <= bestTime) {
        [[NSUserDefaults standardUserDefaults] setInteger:totalSecs forKey:@"BestTime"];
        bestTime = totalSecs;
    }
    if (score >= highScore) {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"HighScore"];
        highScore = score;
    }
    
    [self removeChild:scoreLabel cleanup:YES];
    [self removeChild:timeLabel cleanup:YES];

formatBT:
    if (bestTime >= 60) {
        bestMinutes = bestMinutes + 1;
        bestTime = bestTime - 60;
        goto formatBT;
    }
    if (bestMinutes >= 1) {
        tempBestTime = [NSString stringWithFormat:@"%d:%02d mins",bestMinutes,bestTime];
    }
    else if (bestMinutes == 0) {
        tempBestTime = [NSString stringWithFormat:@"%d secs",bestTime];
    }
    
    if (minutes == 0) {
        timeString = [NSString stringWithFormat:@"%d secs",time];
    }
    else {
        timeString = [NSString stringWithFormat:@"%d:%02d mins",minutes,time];
    }
    NSMutableString *tempScore = [NSMutableString stringWithFormat:@"%d",score];
    NSMutableString *tempHighScore = [NSMutableString stringWithFormat:@"%d",highScore];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        winSprite = [CCSprite spriteWithFile:@"youwin-ipad.png"];
        winSprite.position = CGPointMake(532.9f, 843.2f);
        scoreSprite = [CCSprite spriteWithFile:@"scorebox-ipad.png"];
        scoreSprite.position = CGPointMake(-scoreSprite.boundingBox.size.width, 300.4f);
        againSprite = [CCSprite spriteWithFile:@"playagain-ipad.png"];
        againSprite.position = CGPointMake(320+againSprite.boundingBox.size.width, 212.2f);
        againBox = CGRectMake(262.1f, 212.2f, againSprite.boundingBox.size.width, againSprite.boundingBox.size.height);
        bestTimeLabel = [CCLabelTTF labelWithString:tempBestTime fontName:@"Helvetica" fontSize:50];
        bestTimeLabel.position = CGPointMake(scoreSprite.boundingBox.size.width * 0.556,scoreSprite.boundingBox.size.height * 0.343);
        highScoreLabel = [CCLabelTTF labelWithString:tempHighScore fontName:@"Helvetica" fontSize:50];
        highScoreLabel.position = CGPointMake(scoreSprite.boundingBox.size.width * 0.596,scoreSprite.boundingBox.size.height * 0.665);
        
        scoreLabel = [CCLabelTTF labelWithString:tempScore fontName:@"Helvetica" fontSize:50];
        scoreLabel.position = CGPointMake(scoreSprite.boundingBox.size.width * 0.393,scoreSprite.boundingBox.size.height * 0.793);
        timeLabel = [CCLabelTTF labelWithString:timeString fontName:@"Helvetica" fontSize:50];
        timeLabel.position = CGPointMake(scoreSprite.boundingBox.size.width * 0.357,scoreSprite.boundingBox.size.height * 0.474);
        againPoint = CGPointMake(262.1f, 212.2f);
        scorePoint = CGPointMake(98.6f, 300.4f);
    }
    else {
        bestTimeLabel = [CCLabelTTF labelWithString:tempBestTime fontName:@"Helvetica" fontSize:24];
        bestTimeLabel.position = CGPointMake(147.9f,69.6f);
        highScoreLabel = [CCLabelTTF labelWithString:tempHighScore fontName:@"Helvetica" fontSize:24];
        highScoreLabel.position = CGPointMake(158.6f,134.9f);

        scoreLabel = [CCLabelTTF labelWithString:tempScore fontName:@"Helvetica" fontSize:24];
        scoreLabel.position = CGPointMake(104.6f,160.9f);
        timeLabel = [CCLabelTTF labelWithString:timeString fontName:@"Helvetica" fontSize:24];
        timeLabel.position = CGPointMake(94.9f,96.3f);
        winSprite = [CCSprite spriteWithFile:@"youwin-iphone.png"];
        winSprite.position = CGPointMake(220.4f, 397.4f);
        scoreSprite = [CCSprite spriteWithFile:@"scores-iphone.png"];
        scoreSprite.position = CGPointMake(-scoreSprite.boundingBox.size.width, 141.9f);
        againSprite = [CCSprite spriteWithFile:@"play_again-iphone.png"];
        againSprite.position = CGPointMake(320+againSprite.boundingBox.size.width, 100.7f);
        againBox = CGRectMake(104.7f, 100.7f, againSprite.boundingBox.size.width, againSprite.boundingBox.size.height);
        againPoint = CGPointMake(104.7f, 100.7f);
        scorePoint = CGPointMake(28.4f, 141.9f);
    }
    
    bestTimeLabel.anchorPoint = ccp(0.0f,0.0f);
    highScoreLabel.anchorPoint = ccp(0.0f,0.0f);
    [scoreSprite addChild:bestTimeLabel z:200];
    [scoreSprite addChild:highScoreLabel z:200];
    scoreLabel.anchorPoint = ccp(0.0f,0.0f);
    timeLabel.anchorPoint = ccp(0.0f,0.0f);
    [scoreSprite addChild:scoreLabel z:200];
    [scoreSprite addChild:timeLabel z:200];
    winSprite.anchorPoint = ccp(0.5f, 0.5f);
    [self addChild:winSprite z:110];
    scoreSprite.anchorPoint = ccp(0.0f, 0.0f);
    [self addChild:scoreSprite z:100];
    againSprite.anchorPoint = ccp(0.0f, 0.0f);
    [self addChild:againSprite z:110];
    
    id scoreAction = [CCMoveTo actionWithDuration:1.0f position:scorePoint];
    id winRotate = [CCSequence actions:[CCRotateBy actionWithDuration:1.0f angle:25.0f],[CCRotateBy actionWithDuration:1.0f angle:-25.0f], nil];
    id winAction = [CCRepeatForever actionWithAction:winRotate];
    id againAction = [CCMoveTo actionWithDuration:1.0f position:againPoint];
    [scoreSprite runAction:scoreAction];
    [winSprite runAction:winAction];
    [againSprite runAction:againAction];
    
    
}

-(void)timerFireMethod {
    totalSecs = totalSecs + 1;
    time = time + 1;
    if (time >= 60) {
        minutes = minutes + 1;
        time = 0;
    }
    if (minutes == 0) {
        timeString = [NSString stringWithFormat:@"Time: %d",time];
    }
    else {
        timeString = [NSString stringWithFormat:@"Time: %d:%02d",minutes,time];
    }
    timeLabel.string = timeString;
}

-(void)updateScore {
    scoreLabel.string =scoreString;
}

-(void)addAnimal {
    NSMutableString *tempAnimal = [NSMutableString stringWithString:[spriteArray objectAtIndex:box1Num]];
    if ([tempAnimal isEqual:@"LioniPad.png"] || [tempAnimal isEqual:@"Lion.png"]) {
        if ([tempAnimal isEqual:@"LioniPad.png"]) {
        animalSprite1 = [CCSprite spriteWithFile:@"MGlionipad.png"];
        animalSprite1.position = CGPointMake(494.2f, 325.9f);
    }
    else {
        animalSprite1 = [CCSprite spriteWithFile:@"MGlioniphone.png"];
        animalSprite1.position = CGPointMake(197.1f, 153.6f);

    }
    animalSprite1.anchorPoint = ccp(0.0f, 0.0f);
    [self addChild:animalSprite1 z:1];
    }
    
    if ([tempAnimal isEqual:@"ElephantiPad.png"] || [tempAnimal isEqual:@"Elephant.png"]) {
        if ([tempAnimal isEqual:@"ElephantiPad.png"]) {
            animalSprite2 = [CCSprite spriteWithFile:@"MGelephantipad.png"];
            animalSprite2.position = CGPointMake(338.2f, 505.2f);
        }
        else {
            animalSprite2 = [CCSprite spriteWithFile:@"MGelephantiphone.png"];
            animalSprite2.position = CGPointMake(130.5f, 238.9f);
            
        }
        animalSprite2.anchorPoint = ccp(0.0f, 0.0f);
        [self addChild:animalSprite2 z:1];
    }
    
    if ([tempAnimal isEqual:@"HippoiPad.png"] || [tempAnimal isEqual:@"Hippo.png"]) {
        if ([tempAnimal isEqual:@"HippoiPad.png"]) {
            animalSprite3 = [CCSprite spriteWithFile:@"MGhippoipad.png"];
            animalSprite3.position = CGPointMake(38.0f, 113.2f);
        }
        else {
            animalSprite3 = [CCSprite spriteWithFile:@"MGhippoiphone.png"];
            animalSprite3.position = CGPointMake(6.3f, 52.1f);
            
        }
        animalSprite3.anchorPoint = ccp(0.0f, 0.0f);
        [self addChild:animalSprite3 z:1];
    }
    
    if ([tempAnimal isEqual:@"MonkeyiPad.png"] || [tempAnimal isEqual:@"Monkey.png"]) {
        if ([tempAnimal isEqual:@"MonkeyiPad.png"]) {
            animalSprite4 = [CCSprite spriteWithFile:@"MGmonkeyipad.png"];
            animalSprite4.position = CGPointMake(40.6f, 758.4f);
        }
        else {
            animalSprite4 = [CCSprite spriteWithFile:@"MGmonkeyiphone.png"];
            animalSprite4.position = CGPointMake(36.5f, 348.0f);
            
        }
        animalSprite4.anchorPoint = ccp(0.0f, 0.0f);
        [self addChild:animalSprite4 z:1];
    }
    
    if ([tempAnimal isEqual:@"RhinoiPad.png"] || [tempAnimal isEqual:@"Rhino.png"]) {
        if ([tempAnimal isEqual:@"RhinoiPad.png"]) {
            animalSprite5 = [CCSprite spriteWithFile:@"MGrhinoipad.png"];
            animalSprite5.position = CGPointMake(94.4f, 381.1f);
        }
        else {
            animalSprite5 = [CCSprite spriteWithFile:@"MGrhinoiphone.png"];
            animalSprite5.position = CGPointMake(32.2f, 174.9f);
            
        }
        animalSprite5.anchorPoint = ccp(0.0f, 0.0f);
        [self addChild:animalSprite5 z:1];
    }
    
    if ([tempAnimal isEqual:@"WildaiPad.png"] || [tempAnimal isEqual:@"Wilda.png"]) {
        if ([tempAnimal isEqual:@"WildaiPad.png"]) {
            animalSprite6 = [CCSprite spriteWithFile:@"MGwbeastipad.png"];
            animalSprite6.position = CGPointMake(559.8f, 71.7f);
        }
        else {
            animalSprite6 = [CCSprite spriteWithFile:@"MGwbeastiphone.png"];
            animalSprite6.position = CGPointMake(222.4f, 34.0f);
            
        }
        animalSprite6.anchorPoint = ccp(0.0f, 0.0f);
        [self addChild:animalSprite6 z:1];
    }
}

-(void)showCards {
    BOOL visibility1 = [[visibleSpriteArray objectAtIndex:0]boolValue];
    sprite1.visible = visibility1;
    BOOL visibility2 = [[visibleSpriteArray objectAtIndex:1]boolValue];
    sprite2.visible = visibility2;
    BOOL visibility3 = [[visibleSpriteArray objectAtIndex:2]boolValue];
    sprite3.visible = visibility3;
    BOOL visibility4 = [[visibleSpriteArray objectAtIndex:3]boolValue];
    sprite4.visible = visibility4;
    BOOL visibility5 = [[visibleSpriteArray objectAtIndex:4]boolValue];
    sprite5.visible = visibility5;
    BOOL visibility6 = [[visibleSpriteArray objectAtIndex:5]boolValue];
    sprite6.visible = visibility6;
    BOOL visibility7 = [[visibleSpriteArray objectAtIndex:6]boolValue];
    sprite7.visible = visibility7;
    BOOL visibility8 = [[visibleSpriteArray objectAtIndex:7]boolValue];
    sprite8.visible = visibility8;
    BOOL visibility9 = [[visibleSpriteArray objectAtIndex:8]boolValue];
    sprite9.visible = visibility9;
    BOOL visibility10 = [[visibleSpriteArray objectAtIndex:9]boolValue];
    sprite10.visible = visibility10;
    BOOL visibility11 = [[visibleSpriteArray objectAtIndex:10]boolValue];
    sprite11.visible = visibility11;
    BOOL visibility12 = [[visibleSpriteArray objectAtIndex:11]boolValue];
    sprite12.visible = visibility12;

    
    BOOL coverVisibility1 = [[visibleCoverArray objectAtIndex:0]boolValue];
    coverSprite1.visible = coverVisibility1;
    BOOL coverVisibility2 = [[visibleCoverArray objectAtIndex:1]boolValue];
    coverSprite2.visible = coverVisibility2;
    BOOL coverVisibility3 = [[visibleCoverArray objectAtIndex:2]boolValue];
    coverSprite3.visible = coverVisibility3;
    BOOL coverVisibility4 = [[visibleCoverArray objectAtIndex:3]boolValue];
    coverSprite4.visible = coverVisibility4;
    BOOL coverVisibility5 = [[visibleCoverArray objectAtIndex:4]boolValue];
    coverSprite5.visible = coverVisibility5;
    BOOL coverVisibility6 = [[visibleCoverArray objectAtIndex:5]boolValue];
    coverSprite6.visible = coverVisibility6;
    BOOL coverVisibility7 = [[visibleCoverArray objectAtIndex:6]boolValue];
    coverSprite7.visible = coverVisibility7;
    BOOL coverVisibility8 = [[visibleCoverArray objectAtIndex:7]boolValue];
    coverSprite8.visible = coverVisibility8;
    BOOL coverVisibility9 = [[visibleCoverArray objectAtIndex:8]boolValue];
    coverSprite9.visible = coverVisibility9;
    BOOL coverVisibility10 = [[visibleCoverArray objectAtIndex:9]boolValue];
    coverSprite10.visible = coverVisibility10;
    BOOL coverVisibility11 = [[visibleCoverArray objectAtIndex:10]boolValue];
    coverSprite11.visible = coverVisibility11;
    BOOL coverVisibility12 = [[visibleCoverArray objectAtIndex:11]boolValue];
    coverSprite12.visible = coverVisibility12;
    
}

-(void)randomPictures {
    int lionCount = 0;
    int elephantCount = 0;
    int hippoCount = 0;
    int monkeyCount = 0;
    int rhinoCount = 0;
    int wildaCount = 0;
    int j = 0;
    int test;
    
startLoop: 
    
        test = (arc4random() % 6) + 1;
        if (test == 1) {
            if (lionCount <= 1) {
            CCLOG(@"Lion");
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    tempString = [NSMutableString stringWithString: @"LioniPad.png"];
                }
                else {
                    tempString = [NSMutableString stringWithString: @"Lion.png"];

                }
            lionCount ++;
            }
            else {
                goto startLoop;
            }
        }
        else if (test == 2) {
            if (elephantCount <= 1) {
            CCLOG(@"Elephant");
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    tempString = [NSMutableString stringWithString: @"ElephantiPad.png"];
                }
                else {
                    tempString = [NSMutableString stringWithString: @"Elephant.png"];
                    
                }
                elephantCount ++;
            }
            else {
                goto startLoop;
            }
            
        }
        else if (test == 3) {
            if (hippoCount <= 1) {
            CCLOG(@"Hippo");
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    tempString = [NSMutableString stringWithString: @"HippoiPad.png"];
                }
                else {
                    tempString = [NSMutableString stringWithString: @"Hippo.png"];
                    
                }
                hippoCount ++;
            }
            else {
                goto startLoop;
            }
        }
        else if (test == 4) {
            if (monkeyCount <= 1) {
            CCLOG(@"Monkey");
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    tempString = [NSMutableString stringWithString: @"MonkeyiPad.png"];
                }
                else {
                    tempString = [NSMutableString stringWithString: @"Monkey.png"];
                    
                }
                monkeyCount ++;
            }
            else {
                goto startLoop;
            }
        }
        else if (test == 5) {
            if (rhinoCount <=1) {
            CCLOG(@"Rhino");
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    tempString = [NSMutableString stringWithString: @"RhinoiPad.png"];
                }
                else {
                    tempString = [NSMutableString stringWithString: @"Rhino.png"];
                    
                }
                rhinoCount ++;
            }
            else {
                goto startLoop;
            }
        }
        else if (test == 6) {
            if (wildaCount <= 1) {
            CCLOG(@"Wilda");
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    tempString = [NSMutableString stringWithString: @"WildaiPad.png"];
                }
                else {
                    tempString = [NSMutableString stringWithString: @"Wilda.png"];
                    
                }
                wildaCount ++;
            }
            else {
                goto startLoop;
            }
        }
        
        [spriteArray replaceObjectAtIndex:j withObject:tempString];
    if (j <=10) {
        CCLOG(@"Start Loop");
        j++;
        goto startLoop;
    }
}


-(void)matchCheck {
    if (((BOOL)[pic1String isEqual:pic2String]) && !(box1Num==box2Num)) {
        CCLOG(@"winner");
        matchNumber = matchNumber +1;
        [visibleSpriteArray replaceObjectAtIndex:box1Num withObject:[NSNumber numberWithBool:NO]];
        [visibleSpriteArray replaceObjectAtIndex:box2Num withObject:[NSNumber numberWithBool:NO]];
        score = score + 1000;
        scoreString = [NSString stringWithFormat:@"Score: %d",score];
        [self performSelector:@selector(showCards) withObject:nil afterDelay:1.0];
        [self performSelector:@selector(addAnimal)];


    }
    else {
        if ([[visibleSpriteArray objectAtIndex:box1Num]boolValue]) {
        [visibleCoverArray replaceObjectAtIndex:box1Num withObject:[NSNumber numberWithBool:YES]];
        }
        if ([[visibleSpriteArray objectAtIndex:box2Num]boolValue]) {
        [visibleCoverArray replaceObjectAtIndex:box2Num withObject:[NSNumber numberWithBool:YES]];
        }
        [self performSelector:@selector(showCards) withObject:nil afterDelay:1.0];
        score = score - 100;
        scoreString = [NSString stringWithFormat:@"Score: %d",score];


    }
    [self performSelector:@selector(updateScore)];
    if (matchNumber == 6) {
        gameOver = YES;
        [gameClock invalidate];
        CCLOG(@"Game Over");
        [self performSelector:@selector(gameComplete) withObject:nil afterDelay:1.0];
    }
}

-(void)setupCards {
    NSMutableString *tempScore = [NSMutableString stringWithFormat:@"Score: %d",score];
    NSMutableString *tempTime = [NSMutableString stringWithFormat:@"Time: %d",time];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    scoreLabel = [CCLabelTTF labelWithString:tempScore fontName:@"Helvetica" fontSize:46];
    scoreLabel.position = CGPointMake(60,944);
        timeLabel = [CCLabelTTF labelWithString:tempTime fontName:@"Helvetica" fontSize:46];
        timeLabel.position = CGPointMake(708,944);
    }
    else {
        scoreLabel = [CCLabelTTF labelWithString:tempScore fontName:@"Helvetica" fontSize:24];
        scoreLabel.position = CGPointMake(20,440);
        timeLabel = [CCLabelTTF labelWithString:tempTime fontName:@"Helvetica" fontSize:24];
        timeLabel.position = CGPointMake(300,440);
    }
    scoreLabel.color = ccc3(40, 77, 5);
    timeLabel.color = ccc3(40, 77, 5);

    scoreLabel.anchorPoint = ccp(0.0f,0.0f);
    timeLabel.anchorPoint = ccp(1.0f,0.0f);

    [self addChild:scoreLabel z:30];
    [self addChild:timeLabel z:30];

    
    
    NSMutableString *string1 = [NSMutableString stringWithString:[spriteArray objectAtIndex:0]];
    sprite1 = [CCSprite spriteWithFile:string1];
    sprite1.anchorPoint = ccp(0.0f, 0.0f);
    sprite1.position = CGPointMake(xStart,yStart);
    [self addChild:sprite1 z:10];
    spriteBox1 = CGRectMake(sprite1.position.x, sprite1.position.y, sprite1.boundingBox.size.width, sprite1.boundingBox.size.height);
    
    NSMutableString *string2 = [NSMutableString stringWithString:[spriteArray objectAtIndex:1]];
    sprite2 = [CCSprite spriteWithFile:string2];
    sprite2.anchorPoint = ccp(0.0f, 0.0f);
    sprite2.position = CGPointMake(xStart + xBuffer,yStart);
    [self addChild:sprite2 z:10];
    spriteBox2 = CGRectMake(sprite2.position.x, sprite2.position.y, sprite2.boundingBox.size.width, sprite2.boundingBox.size.height);

    
    NSMutableString *string3 = [NSMutableString stringWithString:[spriteArray objectAtIndex:2]];
    sprite3 = [CCSprite spriteWithFile:string3];
    sprite3.anchorPoint = ccp(0.0f, 0.0f);
    sprite3.position = CGPointMake(xStart + xBuffer*2,yStart);
    [self addChild:sprite3 z:10];
    spriteBox3 = CGRectMake(sprite3.position.x, sprite3.position.y, sprite3.boundingBox.size.width, sprite3.boundingBox.size.height);

    
    NSMutableString *string4 = [NSMutableString stringWithString:[spriteArray objectAtIndex:3]];
    sprite4 = [CCSprite spriteWithFile:string4];
    sprite4.anchorPoint = ccp(0.0f, 0.0f);
    sprite4.position = CGPointMake(xStart,yStart + yBuffer);
    [self addChild:sprite4 z:10];
    spriteBox4 = CGRectMake(sprite4.position.x, sprite4.position.y, sprite4.boundingBox.size.width, sprite4.boundingBox.size.height);

    
    NSMutableString *string5 = [NSMutableString stringWithString:[spriteArray objectAtIndex:4]];
    sprite5 = [CCSprite spriteWithFile:string5];
    sprite5.anchorPoint = ccp(0.0f, 0.0f);
    sprite5.position = CGPointMake(xStart + xBuffer,yStart + yBuffer);
    [self addChild:sprite5 z:10];
    spriteBox5 = CGRectMake(sprite5.position.x, sprite5.position.y, sprite5.boundingBox.size.width, sprite5.boundingBox.size.height);

    

    NSMutableString *string6 = [NSMutableString stringWithString:[spriteArray objectAtIndex:5]];
    sprite6 = [CCSprite spriteWithFile:string6];
    sprite6.anchorPoint = ccp(0.0f, 0.0f);
    sprite6.position = CGPointMake(xStart + xBuffer*2,yStart + yBuffer);
    [self addChild:sprite6 z:10];
    spriteBox6 = CGRectMake(sprite6.position.x, sprite6.position.y, sprite6.boundingBox.size.width, sprite6.boundingBox.size.height);

    
    NSMutableString *string7 = [NSMutableString stringWithString:[spriteArray objectAtIndex:6]];
    sprite7 = [CCSprite spriteWithFile:string7];   
    sprite7.anchorPoint = ccp(0.0f, 0.0f);
    sprite7.position = CGPointMake(xStart,yStart + yBuffer * 2);
    [self addChild:sprite7 z:10];
    spriteBox7 = CGRectMake(sprite7.position.x, sprite7.position.y, sprite7.boundingBox.size.width, sprite7.boundingBox.size.height);

    
    NSMutableString *string8 = [NSMutableString stringWithString:[spriteArray objectAtIndex:7]];
    sprite8 = [CCSprite spriteWithFile:string8];
    sprite8.anchorPoint = ccp(0.0f, 0.0f);
    sprite8.position = CGPointMake(xStart + xBuffer,yStart + yBuffer * 2);
    [self addChild:sprite8 z:10];
    spriteBox8 = CGRectMake(sprite8.position.x, sprite8.position.y, sprite8.boundingBox.size.width, sprite8.boundingBox.size.height);
    
    NSMutableString *string9 = [NSMutableString stringWithString:[spriteArray objectAtIndex:8]];
    sprite9 = [CCSprite spriteWithFile:string9];
    sprite9.anchorPoint = ccp(0.0f, 0.0f);
    sprite9.position = CGPointMake(xStart + xBuffer * 2,yStart + yBuffer * 2);
    [self addChild:sprite9 z:10];
    spriteBox9 = CGRectMake(sprite9.position.x, sprite9.position.y, sprite9.boundingBox.size.width, sprite9.boundingBox.size.height);

    
    NSMutableString *string10 = [NSMutableString stringWithString:[spriteArray objectAtIndex:9]];
    sprite10 = [CCSprite spriteWithFile:string10]; 
    sprite10.anchorPoint = ccp(0.0f, 0.0f);
    sprite10.position = CGPointMake(xStart,yStart + yBuffer * 3);
    [self addChild:sprite10 z:10];
    spriteBox10 = CGRectMake(sprite10.position.x, sprite10.position.y, sprite10.boundingBox.size.width, sprite10.boundingBox.size.height);

    
    NSMutableString *string11 = [NSMutableString stringWithString:[spriteArray objectAtIndex:10]];
    sprite11 = [CCSprite spriteWithFile:string11];
    sprite11.anchorPoint = ccp(0.0f, 0.0f);
    sprite11.position = CGPointMake(xStart + xBuffer,yStart + yBuffer * 3);
    [self addChild:sprite11 z:10];
    spriteBox11 = CGRectMake(sprite11.position.x, sprite11.position.y, sprite11.boundingBox.size.width, sprite11.boundingBox.size.height);

    
    NSMutableString *string12 = [NSMutableString stringWithString:[spriteArray objectAtIndex:11]];
    sprite12 = [CCSprite spriteWithFile:string12];
    sprite12.anchorPoint = ccp(0.0f, 0.0f);
    sprite12.position = CGPointMake(xStart + xBuffer *2,yStart + yBuffer * 3);
    [self addChild:sprite12 z:10];
    spriteBox12 = CGRectMake(sprite12.position.x, sprite12.position.y, sprite12.boundingBox.size.width, sprite12.boundingBox.size.height);
    
    coverSprite1 = [CCSprite spriteWithFile:coverString];
    coverSprite1.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite1.position = spriteBox1.origin;
    [self addChild:coverSprite1 z:20];
    
    coverSprite2 = [CCSprite spriteWithFile:coverString];
    coverSprite2.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite2.position = spriteBox2.origin;
    [self addChild:coverSprite2 z:20];
    
    coverSprite3 = [CCSprite spriteWithFile:coverString];
    coverSprite3.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite3.position = spriteBox3.origin;
    [self addChild:coverSprite3 z:20];
    
    coverSprite4 = [CCSprite spriteWithFile:coverString];
    coverSprite4.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite4.position = spriteBox4.origin;
    [self addChild:coverSprite4 z:20];
    
    coverSprite5 = [CCSprite spriteWithFile:coverString];
    coverSprite5.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite5.position = spriteBox5.origin;
    [self addChild:coverSprite5 z:20];
    
    coverSprite6 = [CCSprite spriteWithFile:coverString];
    coverSprite6.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite6.position = spriteBox6.origin;
    [self addChild:coverSprite6 z:20];
    
    coverSprite7 = [CCSprite spriteWithFile:coverString];
    coverSprite7.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite7.position = spriteBox7.origin;
    [self addChild:coverSprite7 z:20];
    
    coverSprite8 = [CCSprite spriteWithFile:coverString];
    coverSprite8.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite8.position = spriteBox8.origin;
    [self addChild:coverSprite8 z:20];
    
    coverSprite9 = [CCSprite spriteWithFile:coverString];
    coverSprite9.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite9.position = spriteBox9.origin;
    [self addChild:coverSprite9 z:20];
    
    coverSprite10 = [CCSprite spriteWithFile:coverString];
    coverSprite10.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite10.position = spriteBox10.origin;
    [self addChild:coverSprite10 z:20];
    
    coverSprite11 = [CCSprite spriteWithFile:coverString];
    coverSprite11.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite11.position = spriteBox11.origin;
    [self addChild:coverSprite11 z:20];
    
    coverSprite12 = [CCSprite spriteWithFile:coverString];
    coverSprite12.anchorPoint = ccp(0.0f, 0.0f);
    coverSprite12.position = spriteBox12.origin;
    [self addChild:coverSprite12 z:20];
    
    backgroundSprite = [CCSprite spriteWithFile:backgroundString];
    backgroundSprite.anchorPoint = ccp(0.0f, 0.0f);
    backgroundSprite.position = CGPointMake(0.0f, 0.0f);
    [self addChild:backgroundSprite z:0];
    
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    CGPoint locationInNodeSpace = [self convertToNodeSpace:location];

    BOOL touch1 = CGRectContainsPoint(spriteBox1, locationInNodeSpace);
    BOOL touch2 = CGRectContainsPoint(spriteBox2, locationInNodeSpace);   
    BOOL touch3 = CGRectContainsPoint(spriteBox3, locationInNodeSpace);   
    BOOL touch4 = CGRectContainsPoint(spriteBox4, locationInNodeSpace);   
    BOOL touch5 = CGRectContainsPoint(spriteBox5, locationInNodeSpace);   
    BOOL touch6 = CGRectContainsPoint(spriteBox6, locationInNodeSpace);   
    BOOL touch7 = CGRectContainsPoint(spriteBox7, locationInNodeSpace);   
    BOOL touch8 = CGRectContainsPoint(spriteBox8, locationInNodeSpace); 
    BOOL touch9 = CGRectContainsPoint(spriteBox9, locationInNodeSpace);   
    BOOL touch10 = CGRectContainsPoint(spriteBox10, locationInNodeSpace);   
    BOOL touch11 = CGRectContainsPoint(spriteBox11, locationInNodeSpace);   
    BOOL touch12 = CGRectContainsPoint(spriteBox12, locationInNodeSpace);
    BOOL touchAgain = CGRectContainsPoint(againBox, locationInNodeSpace);
    
    if ((touch1 && sprite1.visible) || (touch2 && sprite2.visible) || (touch3&& sprite3.visible)|| (touch4 && sprite4.visible)|| (touch5&& sprite5.visible)|| (touch6&& sprite6.visible)|| (touch7&& sprite7.visible)|| (touch8&& sprite8.visible)|| (touch9&& sprite9.visible)|| (touch10&& sprite10.visible)|| (touch11&& sprite11.visible)|| (touch12&& sprite12.visible)) {
        touchedCard = YES;
    }
    else {
        touchedCard = NO;
    }
if (touchedCard) {
    clickNum++;
    if (clickNum ==1) {
    if (touch1) {
        box1Num = 0;
        pic1String = sprite1.texture;
        
    }
    else if (touch2) {
        box1Num = 1;
        pic1String = sprite2.texture;
    }
        else if (touch3) {
            box1Num = 2;
            pic1String = sprite3.texture;
            
        }
        else if (touch4) {
            box1Num = 3;
            pic1String = sprite4.texture;
        }
        else if (touch5) {
            box1Num = 4;
            pic1String = sprite5.texture;
            
        }
        else if (touch6) {
            box1Num = 5;
            pic1String = sprite6.texture;
        }
        else if (touch7) {
            box1Num = 6;
            pic1String = sprite7.texture;
            
        }
        else if (touch8) {
            box1Num = 7;
            pic1String = sprite8.texture;
        }
        else if (touch9) {
            box1Num = 8;
            pic1String = sprite9.texture;
            
        }
        else if (touch10) {
            box1Num = 9;
            pic1String = sprite10.texture;
        }
        else if (touch11) {
            box1Num = 10;
            pic1String = sprite11.texture;
            
        }
        else if (touch12) {
            box1Num = 11;
            pic1String = sprite12.texture;
        }
        NSMutableString *tempAnimal = [NSMutableString stringWithString:[spriteArray objectAtIndex:box1Num]];
        if ([tempAnimal isEqual:@"LioniPad.png"] || [tempAnimal isEqual:@"Lion.png"]) {
            soundString = [NSString stringWithFormat:@"lion.wav"];
        }
        else if ([tempAnimal isEqual:@"MonkeyiPad.png"] || [tempAnimal isEqual:@"Monkey.png"]) {
            soundString = [NSString stringWithFormat:@"chimp.wav"];
        }
        else if ([tempAnimal isEqual:@"ElephantiPad.png"] || [tempAnimal isEqual:@"Elephant.png"]) {
            soundString = [NSString stringWithFormat:@"elephnt3.wav"];
        }
        else if ([tempAnimal isEqual:@"WildaiPad.png"] || [tempAnimal isEqual:@"Wilda.png"]) {
            soundString = [NSString stringWithFormat:@"pig2.wav"];
        }
        else if ([tempAnimal isEqual:@"RhinoiPad.png"] || [tempAnimal isEqual:@"Rhino.png"]) {
            soundString = [NSString stringWithFormat:@"Rhino2.wav"];
        }        
        else if ([tempAnimal isEqual:@"HippoiPad.png"] || [tempAnimal isEqual:@"Hippo.png"]) {
            soundString = [NSString stringWithFormat:@"Hippo.wav"];
        }
        [visibleCoverArray replaceObjectAtIndex:box1Num withObject:[NSNumber numberWithBool:NO]];
        [self performSelector:@selector(showCards)];
    }
    
    if (clickNum ==2) {
        clickNum = 0;
        if (touch1) {
            box2Num = 0;
            pic2String = sprite1.texture;
            
        }
        else if (touch2) {
            box2Num = 1;
            pic2String = sprite2.texture;
        }
        else if (touch3) {
            box2Num = 2;
            pic2String = sprite3.texture;
            
        }
        else if (touch4) {
            box2Num = 3;
            pic2String = sprite4.texture;
        }
        else if (touch5) {
            box2Num = 4;
            pic2String = sprite5.texture;
            
        }
        else if (touch6) {
            box2Num = 5;
            pic2String = sprite6.texture;
        }
        else if (touch7) {
            box2Num = 6;
            pic2String = sprite7.texture;
            
        }
        else if (touch8) {
            box2Num = 7;
            pic2String = sprite8.texture;
        }
        else if (touch9) {
            box2Num = 8;
            pic2String = sprite9.texture;
            
        }
        else if (touch10) {
            box2Num = 9;
            pic2String = sprite10.texture;
        }
        else if (touch11) {
            box2Num = 10;
            pic2String = sprite11.texture;
            
        }
        else if (touch12) {
            box2Num = 11;
            pic2String = sprite12.texture;
        }

        
        NSMutableString *tempAnimal = [NSMutableString stringWithString:[spriteArray objectAtIndex:box2Num]];
        if ([tempAnimal isEqual:@"LioniPad.png"] || [tempAnimal isEqual:@"Lion.png"]) {
            soundString = [NSString stringWithFormat:@"lion.wav"];
        }
        else if ([tempAnimal isEqual:@"MonkeyiPad.png"] || [tempAnimal isEqual:@"Monkey.png"]) {
            soundString = [NSString stringWithFormat:@"chimp.wav"];
        }
        else if ([tempAnimal isEqual:@"ElephantiPad.png"] || [tempAnimal isEqual:@"Elephant.png"]) {
            soundString = [NSString stringWithFormat:@"elephnt3.wav"];
        }
        else if ([tempAnimal isEqual:@"WildaiPad.png"] || [tempAnimal isEqual:@"Wilda.png"]) {
            soundString = [NSString stringWithFormat:@"pig2.wav"];
        }
        else if ([tempAnimal isEqual:@"RhinoiPad.png"] || [tempAnimal isEqual:@"Rhino.png"]) {
            soundString = [NSString stringWithFormat:@"Rhino2.wav"];
        }        
        else if ([tempAnimal isEqual:@"HippoiPad.png"] || [tempAnimal isEqual:@"Hippo.png"]) {
            soundString = [NSString stringWithFormat:@"Hippo.wav"];
        }

    [visibleCoverArray replaceObjectAtIndex:box2Num withObject:[NSNumber numberWithBool:NO]];
    [self performSelector:@selector(showCards)];
    [self performSelector:@selector(matchCheck)];
        }
    [soundEngine playEffect:soundString];
    }
    if (touchAgain && againSprite) {
        [self performSelector:@selector(gameRestart)];
    }

}



-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
  //  [self performSelector:@selector(showCards)];

}



+ (CCScene*) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    ArcticLayer *layer = [ArcticLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        int temp = [[NSUserDefaults standardUserDefaults] integerForKey:@"FirstTime"];
        if (!(temp == 999)) {
            [[NSUserDefaults standardUserDefaults] setInteger:1000 forKey:@"BestTime"];
            [[NSUserDefaults standardUserDefaults] setInteger:999 forKey:@"FirstTime"];
        }
        time = 0;
        minutes = 0;
        totalSecs = 0;
        matchNumber = 0;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            xStart = 61.5;
            xBuffer = 225;
            yStart = 40;
            yBuffer = 225;
            coverString = @"CoveriPad.png";
            backgroundString = @"ArcticMatch_BGipad.png";
        }
        else {
            xStart = 20;
            xBuffer = 100;
            yStart = 20;
            yBuffer = 100;
            coverString = @"Cover.png";
            backgroundString = @"ArcticMatch_BGiphone.png";


        }
        score = 500;
        gameClock = [[NSTimer scheduledTimerWithTimeInterval:1
                                                          target:self selector:@selector(timerFireMethod)
                                                        userInfo:nil repeats:YES] retain];
        spriteArray = [[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil] retain];
        visibleSpriteArray = [[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES], nil] retain];
        visibleCoverArray = [[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES], nil] retain];
        clickNum = 0;
        [self performSelector:@selector(randomPictures)];
        [self performSelector:@selector(setupCards)];
        [self performSelector:@selector(setupSounds)];
        self.isTouchEnabled = YES;



		// ask director the the window size	
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
