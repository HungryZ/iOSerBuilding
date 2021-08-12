//
//  Student+CoreDataProperties.m
//  
//
//  Created by 张海川 on 2018/12/17.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic id;
@dynamic name;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    // code to be executed when the receiver is first inserted into a managed object context
}

@end
