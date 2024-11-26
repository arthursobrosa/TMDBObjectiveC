//
//  ShowingDetails.h
//  TMDBObjectiveC
//
//  Created by Arthur Sobrosa on 25/11/24.
//

#include <Foundation/Foundation.h>
#include "Movie.h"

@protocol ShowingDetails <NSObject>

-(void)showDetailsForMovie:(Movie *)movie;

@end
