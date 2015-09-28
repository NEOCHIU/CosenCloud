//
//  JRSegmentControl.h
//  JRSegmentControl
//
//

#import <UIKit/UIKit.h>

@class JRSegmentControl;

@protocol JRSegmentControlDelegate <NSObject>

/** 選中某個按鈕時的代理回應*/
- (void)segmentControl:(JRSegmentControl *)segment didSelectedIndex:(NSInteger)index;

/** 指view滑動進度的代理回應 */
- (void)segmentControl:(JRSegmentControl *)segment didScrolledPersent:(CGFloat)persent;

@end

@interface JRSegmentControl : UIView

/** 指view的顏色 */
@property (nonatomic, strong) UIColor *indicatorViewColor;

@property (nonatomic, weak) id<JRSegmentControlDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/** 設定segment的索引為index的按鈕處於選中狀態 */
- (void)setSelectedIndex:(NSInteger)index;

@end
