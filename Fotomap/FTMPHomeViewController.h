//
//  FTMPHomeViewController.h
//  Fotomap
//
//  Created by Matt Quiros on 5/24/14.
//  Copyright (c) 2014 ActionStack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

@class ALAssetsLibrary;

@interface FTMPHomeViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *assets;
@property (strong, nonatomic) ALAssetsLibrary *library;
@property (strong, nonatomic) NSMutableArray *points;

@end
