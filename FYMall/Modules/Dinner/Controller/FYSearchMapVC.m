//
//  FYSearchMapVC.m
//  FYMall
//
//  Created by dai.fengyi on 15/5/7.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYSearchMapVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchAPI.h>
#import "FYAnnotation.h"
#import "FYRoundRectTextField.h"

#define kCellFont           [UIFont systemFontOfSize:14]
#define kCellTextColor      [UIColor colorFromHexString:@"0x404040"]
#define kCellHeight         44

static NSString *Identity = @"SearchMapVCCell";

@interface FYSearchMapCell : UITableViewCell
@property (strong, nonatomic) UIButton *rightButton;
@end
@implementation FYSearchMapCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.backgroundColor = [UIColor redColor];
        self.detailTextLabel.font = kCellFont;
        self.textLabel.textColor = kCellTextColor;
        self.detailTextLabel.textColor = kCellTextColor;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 26)];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor colorFromHexString:@"0x9e9e9e"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setTitle:@"排队" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"排队按钮"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"排队按钮2"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(lineUp:) forControlEvents:UIControlEventTouchUpInside];
        self.accessoryView = button;
    }
    return self;
}
- (void)lineUp:(id)sender
{
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame1 = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(15, frame1.origin.y, 150, frame1.size.height);
    CGRect frame2 = self.detailTextLabel.frame;
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(frame1) + 20, frame2.origin.y, frame2.size.width, frame2.size.height);
}

@end


@interface FYSearchMapVC () <MAMapViewDelegate, UITextFieldDelegate, AMapSearchDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (weak, nonatomic) IBOutlet FYRoundRectTextField *textField;

@end

@implementation FYSearchMapVC

{
    UIImageView *_centerImageView;
    AMapSearchAPI *_searchAPI;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"搜索附近餐厅";
    
    _mapView.delegate = self;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.zoomLevel = 16;

    
    _searchAPI = [[AMapSearchAPI alloc] initWithSearchKey:@"22a633e6fa601b7758e4ee681632d482" Delegate:self];
    _searchAPI.language = AMapSearchLanguage_zh_CN;
    
    _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dingwei"]];
    _centerImageView.center = _mapView.center;
    [_mapView addSubview:_centerImageView];
    
    [_textField addLeftImageView:@"iconfont-search"];
    [_textField addRightButtonWithDefaultImage:@"dingwei" highlightImage:@"iconfont-dingwei2" Action:^{
//        [self.navigationController popViewControllerAnimated:YES];
        if (_textField.text.length != 0) {
            [self searchNearby:_textField.text];
            [_textField endEditing:YES];
        }
    }];
    [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYSearchMapCell *cell = [tableView dequeueReusableCellWithIdentifier:Identity];
    if (cell == nil) {
        cell = [[FYSearchMapCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:Identity];
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.detailTextLabel.font = kCellFont;
//        cell.textLabel.textColor = kCellTextColor;
//        cell.detailTextLabel.textColor = kCellTextColor;
    }
    cell.textLabel.text = @"1. 山水时尚餐厅";
    cell.detailTextLabel.text = @"600m";
    cell.rightButton.tag = indexPath.row;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark = 高德地图代理
/*!
 @brief 地图区域即将改变时会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    [_textField endEditing:YES];
    
}

/*!
 @brief 地图区域改变完成后会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"mapView : %@", mapView);
    [self centerAnimation];
    if (_textField.text.length != 0) {
        [self searchNearby:_textField.text];
    }

}

/*!
 @brief 根据anntation生成对应的View
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
//    if ([annotation isKindOfClass:[FYAnnotation class]]) {
//        FYAnnotation *FYAnn = (FYAnnotation *)annotation;
//        NSString *subtitle = FYAnn.subTitle;
//    }

//    MAUserLocation
//    CLLocationCoordinate2D coordinate = FYAnn.coordinate;
//    NSString *title = FYAnn.title;
//    NSLog(@"\ntitle :%@\nsubtitle : %@\ncoordinate  latitude= %f, longitude = %f\n", title, subtitle, coordinate.latitude ,coordinate.longitude);
    
//    NSLog(@"%@", FYAnn);
//    MAAnnotationView *pin = [[MAAnnotationView alloc] initWithAnnotation:FYAnn reuseIdentifier:@"reuser"];
//
////    pin.image = [UIImage imageNamed:@"use_img"];
//    return pin;
    
    
    if ([annotation isKindOfClass:[FYAnnotation class]]) {
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"reuser"];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"reuser"];
        }
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

/*!
 @brief 当mapView新添加annotation views时，调用此接口
 @param mapView 地图View
 @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"%@", views);
//    MAAnnotationView *view = views[0];
    
}

/*!
 @brief 当选中一个annotation views时，调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    
}

/*!
 @brief 当取消选中一个annotation views时，调用此接口
 @param mapView 地图View
 @param views 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    
}

/*!
 @brief 标注view的accessory view(必须继承自UIControl)被点击时，触发该回调
 @param mapView 地图View
 @param annotationView callout所属的标注view
 @param control 对应的control
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
}

/*!
 @brief 在地图View将要启动定位时，会调用此函数
 @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView
{
    
}

/*!
 @brief 在地图View停止定位后，会调用此函数
 @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{
    
}

/*!
 @brief 位置或者设备方向更新后，会调用此函数
 @param mapView 地图View
 @param userLocation 用户定位信息(包括位置与设备方向等数据)
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    
}

/*!
 @brief 位置或者设备方向更新后，会调用此函数
 @param mapView 地图View
 @param userLocation 用户定位信息(包括位置与设备方向等数据)
 @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation) {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

/*!
 @brief 定位失败后，会调用此函数
 @param mapView 地图View
 @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
}

/*!
 @brief 当userTrackingMode改变时，调用此接口
 @param mapView 地图View
 @param mode 改变后的mode
 @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    
}

/*!
 @brief 拖动annotation view时view的状态变化，ios3.2以后支持
 @param mapView 地图View
 @param view annotation view
 @param newState 新状态
 @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
    
}

/*!
 @brief 根据overlay生成对应的Renderer
 @param mapView 地图View
 @param overlay 指定的overlay
 @return 生成的覆盖物Renderer
 */
//- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
//{
//    
//}

/*!
 @brief 根据overlay生成对应的View
 @param mapView 地图View
 @param overlay 指定的overlay
 @return 生成的覆盖物View
 */
//- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay __attribute__ ((deprecated("use - (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay instead")))
//{
//    
//}

/*!
 @brief 当mapView新添加overlay renderer时，调用此接口
 @param mapView 地图View
 @param renderers 新添加的overlay renderers
 */
- (void)mapView:(MAMapView *)mapView didAddOverlayRenderers:(NSArray *)renderers
{
    
}

/*!
 @brief 当mapView新添加overlay views时，调用此接口
 @param mapView 地图View
 @param overlayViews 新添加的overlay views
 */
- (void)mapView:(MAMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews __attribute__ ((deprecated("use - (void)mapView:(MAMapView *)mapView didAddOverlayRenderers:(NSArray *)renderers instead")))
{
    
}

- (void)centerAnimation
{
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    CABasicAnimation *baseBni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    baseAni.fromValue = [NSNumber numberWithFloat:_mapView.center.y - _centerImageView.bounds.size.height];
    baseAni.fromValue = [NSNumber numberWithFloat:0];
    baseAni.byValue = [NSNumber numberWithFloat:10];
    baseAni.toValue = [NSNumber numberWithFloat:-10];
//    baseAni.toValue = [NSNumber numberWithFloat:_mapView.center.y - 2 * _centerImageView.bounds.size.height];
//    baseAni.toValue = [NSNumber numberWithFloat:_mapView.center.y - _centerImageView.bounds.size.height];
    baseAni.duration = 0.5f;
//    baseAni.fillMode = kCAFillModeBackwards;
    baseAni.removedOnCompletion = NO;
    baseAni.autoreverses = YES;
    [_centerImageView.layer addAnimation:baseAni forKey:nil];

}

#pragma mark - AMapSearchDelegate
/*!
 当请求发生错误时，会调用代理的此方法.
 @param request 发生错误的请求.
 @param error   返回的错误.
 */
- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    
}

- (void)search:(id)searchRequest error:(NSString *)errInfo __attribute__ ((deprecated("use -search:didFailWithError instead.")))
{
    
}

/*!
 @brief POI查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapPlaceSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapPlaceSearchResponse类中的定义)
 */
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    if (response.pois.count == 0) {
        return;
    }
    
    NSString *strCount = [NSString stringWithFormat:@"count: %d",response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
    NSString *strPoi = @"";
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    NSLog(@"Place: %@", result);
    [_mapView removeAnnotations:_mapView.annotations];
    for (AMapPOI * poi in response.pois) {
        FYAnnotation *annotation = [FYAnnotation annotationWithLatitude:poi.location.latitude longitude:poi.location.longitude title:poi.name subTitle:poi.address];

        [_mapView addAnnotation:annotation];
    }
    
}

/*!
 @brief 路径规划查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapNavigationSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapNavigationSearchResponse类中的定义)
 */
- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response{}

/*!
 @brief 输入提示查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapInputTipsSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapInputTipsSearchResponse类中的定义)
 */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response{}

/*!
 @brief 地理编码查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapGeocodeSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapGeocodeSearchResponse类中的定义)
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{}

/*!
 @brief 逆地理编码查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapReGeocodeSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapReGeocodeSearchResponse类中的定义)
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{}

/*!
 @brief 公交线路查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapBusLineSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapBusLineSearchResponse类中的定义)
 */
- (void)onBusLineSearchDone:(AMapBusLineSearchRequest *)request response:(AMapBusLineSearchResponse *)response{}

/*!
 @brief 公交站查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapBusStopSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapBusStopSearchResponse类中的定义)
 */
- (void)onBusStopSearchDone:(AMapBusStopSearchRequest *)request response:(AMapBusStopSearchResponse *)response{}

/*!
 @brief 行政区域查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapDistrictSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapDistrictSearchResponse类中的定义)
 */
- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response{}




#pragma mark - TextField Delegate
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    AMapPlaceSearchRequest *poiReuquest = [[AMapPlaceSearchRequest alloc] init];
//    poiReuquest.searchType = AMapSearchType_PlaceAround;
//    poiReuquest.keywords = textField.text;
//    CLLocation *caL =  _mapView.userLocation.location;
//    AMapGeoPoint *location = [AMapGeoPoint locationWithLatitude:caL.coordinate.latitude longitude:caL.coordinate.longitude];
//    poiReuquest.location = location;
////    poiReuquest.requireExtension = YES;
//    [_searchAPI AMapPlaceSearch:poiReuquest];
//    return YES;
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length != 0) {
        [self searchNearby:textField.text];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldEditingChanged:(UITextField *)sender
{
    NSLog(@"%@", sender.text);
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [_mapView removeAnnotations:_mapView.annotations];
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - 搜索
- (void)searchNearby:(NSString *)keywords
{
    AMapPlaceSearchRequest *poiReuquest = [[AMapPlaceSearchRequest alloc] init];
    poiReuquest.searchType = AMapSearchType_PlaceAround;
    poiReuquest.keywords = keywords;
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:_mapView.center toCoordinateFromView:_mapView];
    CLLocation *caL = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    CLLocation *caL =  _mapView.userLocation.location;
    AMapGeoPoint *location = [AMapGeoPoint locationWithLatitude:caL.coordinate.latitude longitude:caL.coordinate.longitude];
    poiReuquest.location = location;
    //    poiReuquest.requireExtension = YES;
    [_searchAPI AMapPlaceSearch:poiReuquest];
}
@end
