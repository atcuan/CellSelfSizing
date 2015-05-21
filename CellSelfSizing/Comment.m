//
//  Comment.m
//  CellSelfSizing
//
//  Created by Moch Xiao on 5/9/15.
//  Copyright (c) 2015 Moch Xiao. All rights reserved.
//

#import "Comment.h"

@implementation Comment

+ (instancetype)commentInstance {
    NSArray *name = @[@"Lucy", @"Mike", @"Lily", @"Tom", @"Tony", @"Joey", @"Rose", @"Paul", @"James", @"Anna"];
    NSArray *time = @[@"2015-1-4 23:59", @"2013-3-8 08:33", @"1998-9-9 17:20", @"One minute ago", @"An hours age", @"Yesterday"];
    NSArray *comments = @[@"little comment",
                          @"the former world has passed away",
                          @" Love the neighbor. But don't get caught.",
                          @"Your future depends on your dreams. So go to sleep. ",
                          @"To be close to your friend, but closer to your enemy. ",
                          @"Only don't tell me you're innocent. It insults my intelligence, makes me very angry",
                          @"If anything in this life is certain, if history has taught us anything, it is that you can kill anyone. ",
                          @"I never wanted this for you. I work my whole life — I don’t apologize — to take care of my family, and I refused to be a fool, dancing on the string held by all those big shots. I don’t apologize — that’s my life — but I thought that, that when it was your time, that you would be the one to hold the string. Senator Corleone; Governor Corleone. Well, it wasn’t enough time, Michael. It wasn’t enough time.",
                          @"A lawyer carrying a briefcase to grab more money than by holding a submachine gun in 1000 to grab to grab even more money.",
                          @"Do you spend time with your family? Good. Because a man that doesn’t spend time with his family can never be a real man.",
                          @"A matter of seconds to see the nature of people and spend half my life is also unclear one thing to see the nature of man, nature is not the same fate.",
                          @"Life was like a box of chocolates, you never know what you're gonna get. ",
                          @"If you are ever in trouble, don't try to be brave, just run, just run away.",
                          @"Land is the only thing in the world worth working for, worth fighting for, worth dying for. Because it's the only thing that lasts. ",
                          @"Now I find myself in a world which for me is worse than death. A world in which there is no place for me. ",
                          @"God shall wipe away all the tears from their eyes, and there shall be no more death. Neither shall there be sorrow or dying, neither shall there be any more pain, for the former world has passed away."
                         ];
    
    Comment *comment = [Comment new];
    comment.name = name[arc4random() % (time.count - 1)];
    comment.time = time[arc4random() % (time.count - 1)];
    comment.comment = comments[arc4random() % (comments.count - 1)];
    
    return comment;
}

@end
