#import "GossipLeagueVC.h"
#import <Parse/Parse.h>
#import <Parse/PFQueryTableViewController.h>
#import "TableCell.h"
#import "PlayerEntity.h"
#import "UserDetailVC.h"

@interface GossipLeagueVC () <UITableViewDataSource, UIAccelerometerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *players;

- (void)setUp;

@end

@implementation GossipLeagueVC

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Liga Gossip HUB";
    [self setUp];
}

- (void)setUp
{
    self.players = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Player"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        self.players = [objects sortedArrayUsingComparator:^NSComparisonResult(PlayerEntity *player1, PlayerEntity *player2) {
            return player1.percentWins < player2.percentWins;
        }];
        
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableLeagueCell";
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        UINib *cellNib = [UINib nibWithNibName:@"TableCell" bundle:nil];
        cell = [[cellNib instantiateWithOwner:self options:nil] objectAtIndex:0];
    }
    
    [cell setPlayer:[self.players objectAtIndex:indexPath.row] position:indexPath.row total:self.players.count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerEntity *player = [self.players objectAtIndex:indexPath.row];
    UserDetailVC *userDetailVC = [[UserDetailVC alloc] initWithPlayer:player];
    [self.navigationController pushViewController:userDetailVC animated:YES];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end