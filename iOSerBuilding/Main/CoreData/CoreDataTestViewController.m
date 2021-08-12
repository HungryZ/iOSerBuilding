//
//  CoreDataTestViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2018/12/17.
//

@import CoreData;

#import "CoreDataTestViewController.h"

@interface CoreDataTestViewController ()

@property (nonatomic, strong) NSManagedObjectContext *  context;
@property (nonatomic, strong) NSManagedObjectModel *    model;

@end

@implementation CoreDataTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)itemArchivePath {
    
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

@end
