//
//  JRSegmentViewController.h
//  JRSegmentControl
//
//

#import <UIKit/UIKit.h>
#import "JRSegmentControl.h"

@interface JRSegmentViewController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, copy) NSArray *titles;

/** view的顏色 */
@property (nonatomic, strong) UIColor *indicatorViewColor;
/** segment的背景顏色 */
@property (nonatomic, strong) UIColor *segmentBgColor;
/** segment每一項的寬 */
@property (nonatomic, assign) CGFloat itemWidth;
/** segment每一項的高 */
@property (nonatomic, assign) CGFloat itemHeight;

@end

