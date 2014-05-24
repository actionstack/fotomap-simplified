//
//  FTMPHomeViewController.m
//  Fotomap
//
//  Created by Matt Quiros on 5/24/14.
//  Copyright (c) 2014 ActionStack. All rights reserved.
//

#import "FTMPHomeViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation FTMPHomeViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Fotomap";
    self.library = [[ALAssetsLibrary alloc] init];
    self.assets = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group == nil) {
            [self enumerateLocations];
            return;
        }
        
        ALAssetsFilter *photosOnlyFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:photosOnlyFilter];
        
        if ([group numberOfAssets] > 0) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result != nil) {
                    [self.assets addObject:result];
                }
            }];
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

- (void)enumerateLocations
{
    self.points = [NSMutableArray array];
    
    for (int i = 0; i < self.assets.count; i++) {
        ALAsset *asset = self.assets[i];
        CLLocation *location = [asset valueForProperty:ALAssetPropertyLocation];
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = location.coordinate;
        [self.points addObject:point];
    }
    
    [self.mapView addAnnotations:self.points];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSInteger indexOfAnnotation = [self.points indexOfObject:annotation];
    ALAsset *asset = self.assets[indexOfAnnotation];
    
    MKAnnotationView *thumbnailView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Annotation"];
    CGImageRef rawImageData = [asset thumbnail];
    thumbnailView.image = [UIImage imageWithCGImage:rawImageData];
    
    thumbnailView.frame = CGRectMake(0, 0, 60, 60);
    
    return thumbnailView;
}

@end
