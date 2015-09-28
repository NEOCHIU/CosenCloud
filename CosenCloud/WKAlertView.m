//
//  MyWindow.m
//  WKAlertViewDemo
//
//

#import "WKAlertView.h"
//按鈕顏色
#define OKBUTTON_BGCOLOR [UIColor colorWithRed:158/255.0 green:214/255.0 blue:243/255.0 alpha:1]
#define CANCELBUTTON_BGCOLOR [UIColor colorWithRed:255/255.0 green:20/255.0 blue:20/255.0 alpha:1]
//按鈕起始tag
#define TAG 100

#define SCREEN_Width   [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height   [UIScreen mainScreen].bounds.size.height

NSUInteger const Button_Size_Width = 80;
NSUInteger const Button_Size_Height = 30;

NSInteger const Title_Font = 18;
NSInteger const Detial_Font = 16;

//Logo半徑（畫面）
NSInteger const Logo_Size = 40;

NSInteger const Button_Font = 16;

@interface WKAlertView ()
{
    UIView * _logoView;//畫面
    UILabel * _titleLabel;//標題
    UILabel * _detailLabel;//詳情
    
    UIButton * _OkButton;//確定按鈕
    UIButton * _canleButton;//取消按鈕
    
    CAShapeLayer * _pathLayer;//保護記憶體
}
@end


@implementation WKAlertView



+ (instancetype)showAlertViewWithStyle:(WKAlertViewStyle)style title:(NSString *)title detail:(NSString *)detail canleButtonTitle:(NSString *)canle okButtonTitle:(NSString *)ok callBlock:(callBack)callBack
{
    switch (style) {
        case WKAlertViewStyleDefalut:
            [[self shared] drawRight];
            break;
        case WKAlertViewStyleSuccess:
            [[self shared] drawRight];

            break;
        case WKAlertViewStyleFail:
            [[self shared] drawWrong];

            break;
        case WKAlertViewStyleWaring:
            [[self shared] drawWaring];

            break;
        default:
            break;
    }
    [[self shared] addButtonTitleWithCancle:canle OK:ok];
    [[self shared] addTitle:title detail:detail];
    [[self shared] setClickBlock:nil];//釋放之前的block
    [[self shared] setClickBlock:callBack];
    [[self shared] setHidden:NO];//設置不隱藏
    return  [self shared];
    
}

+ (instancetype)showAlertViewWithTitle:(NSString *)title detail:(NSString *)detail canleButtonTitle:(NSString *)canle okButtonTitle:(NSString *)ok callBlock:(callBack)callBack
{
  return [self showAlertViewWithStyle:WKAlertViewStyleSuccess title:title detail:detail canleButtonTitle:canle okButtonTitle:ok callBlock:callBack];
}
//單例
+ (instancetype)shared
{
    static dispatch_once_t once = 0;
    static WKAlertView *alert;
    dispatch_once(&once, ^{
        alert = [[WKAlertView alloc] init];
    });
    return alert;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = (CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size};
        self.alpha = 1;
        [self setBackgroundColor:[UIColor clearColor]];
        self.hidden = NO;//不隱藏
        self.windowLevel = 100;
        
        [self setInterFace];
    }
    
    return self;
}
/**
 *
 *  介面初始化
 */
- (void)setInterFace
{
    [self logoInit];
    [self controlsInit];
}
/**
 *  @Author wang kun
 *
 *  初始化控制
 */
- (void)controlsInit
{
    
    CGFloat x = _logoView.frame.origin.x;
    CGFloat y = _logoView.frame.origin.y;
    CGFloat height = _logoView.frame.size.height;
    CGFloat width = _logoView.frame.size.width;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x ,y + height / 2, width, Title_Font + 5)];
    [_titleLabel setFont:[UIFont systemFontOfSize:Title_Font]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];

    _detailLabel  = [[UILabel alloc] initWithFrame:CGRectMake(x ,y + height / 2 + (Title_Font + 10), width, Detial_Font + 5)];
    _detailLabel.textColor = [UIColor grayColor];
    [_detailLabel setFont:[UIFont systemFontOfSize:Detial_Font]];
    [_detailLabel setTextAlignment:NSTextAlignmentCenter];

    CGFloat centerY = _detailLabel.center.y + 40;
    
    _OkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _OkButton.layer.cornerRadius = 5;
    _OkButton.titleLabel.font = [UIFont systemFontOfSize:Button_Font];
    _OkButton.center = CGPointMake(_detailLabel.center.x + 50, centerY);
    _OkButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    _OkButton.backgroundColor = OKBUTTON_BGCOLOR;

    
    _canleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _canleButton.center = CGPointMake(_detailLabel.center.x - 50, centerY);
    _canleButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    _canleButton.backgroundColor = CANCELBUTTON_BGCOLOR;
    _canleButton.layer.cornerRadius = 5;
    _canleButton.titleLabel.font = [UIFont systemFontOfSize:Button_Font];
    

    [self addSubview:_titleLabel];
    [self addSubview:_detailLabel];
    [self addSubview:_OkButton];
    [self addSubview:_canleButton];

    _canleButton.hidden = YES;
    _OkButton.hidden = YES;
    
    _OkButton.tag = TAG;
    _canleButton.tag = TAG + 1;
    
    [_OkButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_canleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

}

/**
 *  @Author wang kun
 *
 *  初始化logo视图——画布
 */
#warning 需完善畫布的清除，不適用移除，新建的辦法
- (void)logoInit
{
    //移除画布
    [_logoView removeFromSuperview];
    _logoView = nil;
    //新建画布
    _logoView                     = [UIView new];
    _logoView.center              = CGPointMake(self.center.x, self.center.y - 40);
    _logoView.bounds              = CGRectMake(0, 0, 320 / 1.5, 320 / 1.5);
    _logoView.backgroundColor     = [UIColor whiteColor];
    _logoView.layer.cornerRadius  = 10;
    _logoView.layer.shadowColor   = [UIColor blackColor].CGColor;
    _logoView.layer.shadowOffset  = CGSizeMake(0, 5);
    _logoView.layer.shadowOpacity = 0.3f;
    _logoView.layer.shadowRadius  = 10.0f;
    
    //畫面位於所有view層級的最下方
    if (_titleLabel != nil) {
        [self insertSubview:_logoView belowSubview:_titleLabel];
    }
    else
    [self addSubview:_logoView];
}
/**
 *
 *  新增按鈕
 *
 *  @param cancle 按鈕title
 *  @param ok     按鈕title
 */
- (void) addButtonTitleWithCancle:(NSString *)cancle OK:(NSString *)ok
{
    BOOL flag = NO;
    if (cancle == nil && ok != nil ) {
        flag = YES;
    }
    
    CGFloat centerY = _detailLabel.center.y + 40;
    

    if (flag) {
        _OkButton.center = CGPointMake(_detailLabel.center.x, centerY);
        _OkButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
        _canleButton.hidden = YES;
        
    }
    else
    {
        _canleButton.hidden = NO;
        [_canleButton setTitle:cancle forState:UIControlStateNormal];
        _OkButton.center = CGPointMake(_detailLabel.center.x + 50, centerY);
        _OkButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    }
    _OkButton.hidden = NO;
    [_OkButton setTitle:ok forState:UIControlStateNormal];



}
/**
  *
  * 新增標題信息和詳細信息
  *
  * @param title 標題內容
  * @param detail 詳細內容
  */
- (void)addTitle:(NSString *)title detail:(NSString *)detail
{
    
    _titleLabel.text  = title;
    _detailLabel.text = detail;

}




/**
 *
 *  畫圓合勾
 */
-(void) drawRight
{
    
    [self logoInit];
    //自繪製圖標中心點
    CGPoint pathCenter = CGPointMake(_logoView.frame.size.width/2, _logoView.frame.size.height/2 - 50);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:Logo_Size startAngle:0 endAngle:M_PI*2 clockwise:YES];

    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    
    CGFloat x = _logoView.frame.size.width/2.5 + 5;
    CGFloat y = _logoView.frame.size.height/2 - 45;
    //打勾的起點
    [path moveToPoint:CGPointMake(x, y)];
    //打勾的最底端
    CGPoint p1 = CGPointMake(x+10, y+ 10);
    [path addLineToPoint:p1];
    //打勾的最上端
    CGPoint p2 = CGPointMake(x+35,y-20);
    [path addLineToPoint:p2];
    //新建圖層——繪製上面的圓圈和勾
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.lineWidth = 5;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [_logoView.layer addSublayer:layer];

}

/**
 *  @Author wang kun
 *
 *  畫三角形以及驚嘆號
 */
-(void) drawWaring
{
    
//    [_logoView removeFromSuperview];
    [self logoInit];
    //製圖標中心點
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;

    //三角形
    CGFloat x = _logoView.frame.size.width/2;
    CGFloat y = 15;
    //三角形起點（上方）
    [path moveToPoint:CGPointMake(x, y)];
    //左邊
    CGPoint p1 = CGPointMake(x - 45, y + 80);
    [path addLineToPoint:p1];
    //右邊
    CGPoint p2 = CGPointMake(x + 45,y + 80);
    [path addLineToPoint:p2];
    //關閉路徑
    [path closePath];

    //繪製驚嘆號
    //繪製直線
    [path moveToPoint:CGPointMake(x, y + 20)];
    CGPoint p4 = CGPointMake(x, y + 60);
    [path addLineToPoint:p4];
    //繪製實心圖
    [path moveToPoint:CGPointMake(x, y + 70)];
    [path addArcWithCenter:CGPointMake(x, y + 70) radius:2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    
    //新建圖層——繪製上述路徑
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor orangeColor].CGColor;
    layer.lineWidth = 5;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [_logoView.layer addSublayer:layer];
}

/**
 *  @Author wang kun
 *
 *  畫圓角矩形和叉
 */
- (void)drawWrong
{
  
    [self logoInit];
    
    
    CGFloat x = _logoView.frame.size.width / 2 - Logo_Size;
    CGFloat y = 15;
    
    //圓角矩形
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, Logo_Size * 2, Logo_Size * 2) cornerRadius:5];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    CGFloat space = 20;
    //斜線1
    [path moveToPoint:CGPointMake(x + space, y + space)];
    CGPoint p1 = CGPointMake(x + Logo_Size * 2 - space, y + Logo_Size * 2 - space);
    [path addLineToPoint:p1];
    //斜線2
    [path moveToPoint:CGPointMake(x + Logo_Size * 2 - space , y + space)];
    CGPoint p2 = CGPointMake(x + space, y + Logo_Size * 2 - space);
    [path addLineToPoint:p2];
    
    //新建圖層——繪製上述路徑
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 5;
    layer.path = path.CGPath;
#warning 使用NSStringFromSelector(@selector(strokeEnd))作為KeyPath的作用，繪製動畫每一次Show均重複運行
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    //和上面對應
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [_logoView.layer addSublayer:layer];
}

/**
 *
 *  點擊按鈕事件
 *
 *  @param sender 按鈕
 */
- (void)buttonClick:(UIButton *)sender
{
    self.clickBlock(sender.tag - TAG);
}


@end
