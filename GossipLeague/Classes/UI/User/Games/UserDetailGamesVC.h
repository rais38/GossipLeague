//
//  UserDetailGamesVC.h
//  GossipLeague
//
//  Created by Giuseppe Basile on 28/04/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//

#import "GamesVC.h"

@class PlayerEntity;

@interface UserDetailGamesVC : GamesVC
- (id)initWithPlayer:(PlayerEntity *)player;
@end
