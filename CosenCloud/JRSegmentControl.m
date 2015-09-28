//
//  JRSegmentControl.m
//  JRSegmentControl
//
//

#import "JRSegmentControl.h"

#define DefaultCurrentBtnColor [UIColor grayColor]

@interface JRSegmentControl ()
{
    NSUInteger btnCount; // 按鈕總數
    
    CGFloat btnWidth; // 按鈕寬度
    
    UIButton *currentBtn;   // 指定圖當前所在的按鈕
    
    UIView *indicatorView; // 指定的圖(滑動的圖)
    
    BOOL isSelectedBegan; // 是否設定selectedBegan
}

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *buttons; /// 存放button


@end



@implementation JRSegmentControl

@synthesize indicatorViewColor = _indicatorViewColor;


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius  = frame.size.height / 10;
        self.layer.masksToBounds = YES;
        
        self.titles = titles;
        btnCount = titles.count;
        [self createUI];
    }
    
    return self;
}

#pragma mark setter/getter方法
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setIndicatorViewColor:(UIColor *)indicatorViewColor
{
    if (indicatorViewColor == nil) {
        return;
    }
    _indicatorViewColor = indicatorViewColor;
    indicatorView.backgroundColor = _indicatorViewColor;
    for (UIButton *btn in self.buttons) {
        if (currentBtn != btn) {
            [btn setTitleColor:self.indicatorViewColor forState:UIControlStateNormal];
            [btn setTitleColor:self.indicatorViewColor forState:UIControlStateHighlighted];
        }
    }
}

- (UIColor *)indicatorViewColor
{
    if (_indicatorViewColor == nil) {
        _indicatorViewColor = [UIColor whiteColor];
    }
    return _indicatorViewColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    [currentBtn setTitleColor:backgroundColor forState:UIControlStateNormal];
}


#pragma mark 建立圖層
- (void)createUI
{
    btnWidth = self.frame.size.width / btnCount;
    CGFloat btnHeight = self.frame.size.height;
    
     // 圖層
    indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
    indicatorView.backgroundColor = self.indicatorViewColor;
    indicatorView.layer.cornerRadius = self.layer.cornerRadius;
    indicatorView.layer.masksToBounds = YES;
    [self addSubview:indicatorView];
    
    // 建立按鈕
    for (int i = 0; i < btnCount; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, btnHeight);
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [self.buttons addObject:btn]; // 加入數量
    }
    
    
    // 第一個設定字體的顏色
    currentBtn = (UIButton *)self.buttons[0];
    // 如果不設置backgroundColor，第一個按鈕的文字顏色就會被設定為預設顏色
    [currentBtn setTitleColor:DefaultCurrentBtnColor forState:UIControlStateNormal];
}

#pragma mark 事件攔截，當點擊區域在指定的圖的範圍內時就直接把事件交給self處理，按鈕就接收不到事件了
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint p = [self convertPoint:point toView:indicatorView];
    if ([indicatorView pointInside:p withEvent:event]) {
        return self;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

#pragma mark self 觸控事件處理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectedBegan]; //////////////////////////////////////
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint prevP = [touch previousLocationInView:self];
    
    CGFloat delta = point.x - prevP.x; // 手勢更改x範圍
    
    CGRect frame = indicatorView.frame;
    
    // 限制indicatorView的滑動範圍
    if (frame.origin.x + delta >= 0 && frame.origin.x + delta <= (btnCount - 1) * btnWidth) {
        frame.origin = CGPointMake(frame.origin.x + delta, 0);
    }
    
    CGFloat persent = indicatorView.frame.origin.x / (btnCount * btnWidth);
    if ([self.delegate respondsToSelector:@selector(segmentControl:didScrolledPersent:)]) {
        [self.delegate segmentControl:self didScrolledPersent:persent];
    }
    
    indicatorView.frame = frame;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 計算indicatorView最後是在哪個button上
    CGPoint center = indicatorView.center;
    
    NSInteger index = (NSInteger)center.x / btnWidth;
    
    [self setSelectedIndex:index]; //////////////////////////////////////
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark 按鈕點擊事件處理
- (void)btnClicked:(UIButton *)btn
{
    NSInteger index = (NSInteger)btn.frame.origin.x / btnWidth; // 求按鈕的Index
    
    [self setSelectedIndex:index]; //////////////////////////////////////
}

#pragma mark 設定選中的按鈕
- (void)setSelectedIndex:(NSInteger)index
{
    // 告知delegate選中哪个按鈕
    if ([self.delegate respondsToSelector:@selector(segmentControl:didSelectedIndex:)]) {
        [self.delegate segmentControl:self didSelectedIndex:index];
    }
    
    [self selectedBegan]; // 選中一開始的設訂
    
    currentBtn = self.buttons[index];
    
    [UIView animateWithDuration:0.25f animations:^{
        
        indicatorView.frame = CGRectMake(btnWidth * index, 0, indicatorView.frame.size.width, indicatorView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [self selectedEnd]; // 選中結束的設定//////////////////////////////////////
    }];
}

/** 選一開始的設定，指定的view變暗，文字顏色改變 */
- (void)selectedBegan
{
    if (isSelectedBegan) return;
    
    isSelectedBegan = YES;
    
    indicatorView.alpha = 0.5f;
    [currentBtn setTitleColor:self.indicatorViewColor forState:UIControlStateNormal];
}

/** 選開始的設定 */
- (void)selectedEnd
{
    if (!isSelectedBegan) return;
    
    isSelectedBegan = NO;
    
    indicatorView.alpha = 1.0f;
    
    // 如果沒有background，就是預設的顏色
    UIColor *color = self.backgroundColor ? self.backgroundColor : DefaultCurrentBtnColor;
    [currentBtn setTitleColor:color forState:UIControlStateNormal];
}

@end
