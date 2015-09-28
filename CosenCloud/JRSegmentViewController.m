//
//  JRSegmentViewController.m
//  JRSegmentControl
//
//

#import "JRSegmentViewController.h"

@interface JRSegmentViewController () <UIScrollViewDelegate, JRSegmentControlDelegate>
{
    CGFloat vcWidth;  // 每張VC的宽
    CGFloat vcHeight; // 每張VC的高
    
    JRSegmentControl *segment;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation JRSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupScrollView];
    [self setupViewControllers];
    [self setupSegmentControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)itemWidth
{
    if (_itemWidth == 0) {
        _itemWidth = 80.0f;
    }
    return _itemWidth;
}

- (CGFloat)itemHeight
{
    if (_itemHeight == 0) {
        _itemHeight = 30.0f;
    }
    return _itemHeight;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

/** 設定scrollView Ｙ軸 */
- (void)setupScrollView
{
    CGFloat Y = 0.0f;
    if (self.navigationController != nil && ![self.navigationController isNavigationBarHidden]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        Y = 0.0f;
    }
    
    vcWidth = self.view.frame.size.width;
    vcHeight = self.view.frame.size.height - Y;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, Y, vcWidth, vcHeight)];
    scrollView.contentSize = CGSizeMake(vcWidth * self.viewControllers.count, vcHeight);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate      = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

/** 設定子VC，必須在viewDidLoad方法裡執行，不然子VC各項view會是空值 */
- (void)setupViewControllers
{
    int cnt = (int)self.viewControllers.count;
    for (int i = 0; i < cnt; i++) {
        UIViewController *vc = self.viewControllers[i];
        [self addChildViewController:vc];
        
        vc.view.frame = CGRectMake(vcWidth * i, 0, vcWidth, vcHeight);
        [self.scrollView addSubview:vc.view];
    }
}

/** 设置segment */
- (void)setupSegmentControl
{
    segment = [[JRSegmentControl alloc] initWithFrame:CGRectMake(0, 0, self.itemWidth * self.viewControllers.count, self.itemHeight) titles:self.titles];
    segment.backgroundColor = self.segmentBgColor;
    segment.indicatorViewColor = self.indicatorViewColor;
    
    segment.delegate = self;
    self.navigationItem.titleView = segment;
}


#pragma mark UIScrollViewDelegate

// 這個方法是手動滾動視圖停止後才會調用，在外部通過setContentOffset改變的不會調用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / vcWidth;
    
    [segment setSelectedIndex:index];
}

#pragma mark JRSegmentControlDelegate
- (void)segmentControl:(JRSegmentControl *)segment didSelectedIndex:(NSInteger)index
{
    CGPoint offset = CGPointMake(vcWidth * index, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)segmentControl:(JRSegmentControl *)segment didScrolledPersent:(CGFloat)persent
{
    CGPoint offset = CGPointMake(persent * self.scrollView.contentSize.width, 0);
    [self.scrollView setContentOffset:offset animated:NO];
}

@end
