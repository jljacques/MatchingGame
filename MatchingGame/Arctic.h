//
//  HelloWorldLayer.h
//  MatchingGame
//
//  Created by Jeremy Jacques on 12-03-11.
//  Copyright Jacques Development 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

// HelloWorldLayer
@interface ArcticLayer : CCLayer
{
    CCSprite *animalSprite1;
    CCSprite *animalSprite2;
    CCSprite *animalSprite3;
    CCSprite *animalSprite4;
    CCSprite *animalSprite5;
    CCSprite *animalSprite6;

    
    CCSprite *coverSprite1;
    CCSprite *coverSprite2;
    CCSprite *coverSprite3;
    CCSprite *coverSprite4;
    CCSprite *coverSprite5;
    CCSprite *coverSprite6;
    CCSprite *coverSprite7;
    CCSprite *coverSprite8;
    CCSprite *coverSprite9;
    CCSprite *coverSprite10;
    CCSprite *coverSprite11;
    CCSprite *coverSprite12;

    CCSprite *sprite1;
    CCSprite *sprite2;
    CCSprite *sprite3;
    CCSprite *sprite4;
    CCSprite *sprite5;
    CCSprite *sprite6;
    CCSprite *sprite7;
    CCSprite *sprite8;
    CCSprite *sprite9;
    CCSprite *sprite10;
    CCSprite *sprite11;
    CCSprite *sprite12;
    
    CCSprite *backgroundSprite;

    CCSprite *winSprite;
    CCSprite *scoreSprite;
    CCSprite *againSprite;

    CGPoint scorePoint;
    CGPoint againPoint;
    CGRect spriteBox1;
    CGRect spriteBox2;
    CGRect spriteBox3;
    CGRect spriteBox4;
    CGRect spriteBox5;
    CGRect spriteBox6;
    CGRect spriteBox7;
    CGRect spriteBox8;
    CGRect spriteBox9;
    CGRect spriteBox10;
    CGRect spriteBox11;
    CGRect spriteBox12;
    
    CGRect againBox;

    NSMutableArray *spriteArray;
    NSMutableArray *visibleSpriteArray;
    NSMutableArray *visibleCoverArray;
    NSMutableArray *animalArray;
    NSMutableArray *animaliPadArray;
    NSMutableString *tempString;

    NSInteger highScore;
    NSInteger clickNum;
    NSInteger box1Num;
    NSInteger box2Num;
    NSInteger xStart;
    NSInteger yStart;
    NSInteger xBuffer;
    NSInteger yBuffer;
    NSInteger score;
    NSInteger time;
    NSInteger bestTime;
    NSInteger minutes;
    NSInteger totalSecs;
    NSInteger bestMinutes;

    NSInteger iphoneDivider;
    NSInteger matchNumber;

    NSString *coverString;
    NSString *backgroundString;
    NSString *scoreString;
    NSString *timeString;
    NSString *tempBestTime;
    NSString *soundString;

    NSTimer *gameClock;


    CCLabelTTF *scoreLabel;
    CCLabelTTF *timeLabel;
    CCLabelTTF *highScoreLabel;
    CCLabelTTF *bestTimeLabel;

    CCTexture2D *pic1String;
    CCTexture2D *pic2String;
    BOOL touchedCard;
    BOOL gameOver;
    
    SimpleAudioEngine *soundEngine;

}

@property (nonatomic, retain) NSTimer *gameClock;
@property (nonatomic, retain) NSString *coverString;
@property (nonatomic, retain) NSString *backgroundString;
@property (nonatomic, retain) NSString *scoreString;
@property (nonatomic, retain) NSString *timeString;
@property (nonatomic, retain) NSString *tempBestTime;
@property (nonatomic, retain) NSString *soundString;

@property (nonatomic, retain) NSMutableString *tempString;
@property (nonatomic, retain) NSMutableArray *spriteArray;
@property (nonatomic, retain) NSMutableArray *visibleSpriteArray;
@property (nonatomic, retain) NSMutableArray *visibleCoverArray;
@property (nonatomic, retain) NSMutableArray *animalArray;
@property (nonatomic, retain) NSMutableArray *animaliPadArray;
@property (nonatomic) NSInteger clickNum;
@property (nonatomic) NSInteger box1Num;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger highScore;
@property (nonatomic) NSInteger time;
@property (nonatomic) NSInteger bestTime;
@property (nonatomic) NSInteger bestMinutes;
@property (nonatomic) NSInteger minutes;
@property (nonatomic) NSInteger totalSecs;
@property (nonatomic) NSInteger matchNumber;

@property (nonatomic, retain) CCTexture2D *pic1String;
@property (nonatomic) NSInteger box2Num;
@property (nonatomic) NSInteger iphoneDivider;
@property (nonatomic, retain) CCTexture2D *pic2String;


// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)setupCards;
-(void)matchCheck;
-(void)showCards;

@end
