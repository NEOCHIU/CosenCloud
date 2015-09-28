//
//  MyWindow.h
//  WKAlertViewDemo
//
//

#import <UIKit/UIKit.h>

/**
 *  @Author wang kun
 *
 *  點擊樣式
 */
typedef NS_ENUM(NSInteger, MyWindowClick){
    /**
     *  @Author wang kun
     *
     *  點選確定按鈕
     */
    MyWindowClickForOK = 0,
    /**
     *  @Author wang kun
     *
     *  點擊取消按鈕
     */
    MyWindowClickForCancel
};

/**
 *  @Author wang kun
 *
 *  提示框的樣式
 */
typedef NS_ENUM(NSInteger, WKAlertViewStyle)
{

    WKAlertViewStyleDefalut = 0,//預設 -成功

    WKAlertViewStyleSuccess,//成功

    WKAlertViewStyleFail,//失敗

    WKAlertViewStyleWaring//警告
};

typedef void (^callBack)(MyWindowClick buttonIndex);


@interface WKAlertView : UIWindow

@property (nonatomic, copy) callBack clickBlock ;//按鈕點擊事件的back

+ (instancetype)shared;

/**
  * @Author wang kun
  *
  * 創建AlertView並展示
  *
  * @param style 繪製的圖片樣式
  * @param title 警示標題
  * @param detail 警示內容
  * @param canle 取消按鈕標題
  * @param ok 確定按鈕標題
  * @param callBack 按鈕點擊時間回調
  *
  * @return 返回AlertView
  */
+ (instancetype)showAlertViewWithStyle:(WKAlertViewStyle)style title:(NSString *)title detail:(NSString *)detail canleButtonTitle:(NSString *)canle okButtonTitle:(NSString *)ok callBlock:(callBack)callBack;
//預設樣式創建AlertView
+ (instancetype)showAlertViewWithTitle:(NSString *)title detail:(NSString *)detail canleButtonTitle:(NSString *)canle okButtonTitle:(NSString *)ok callBlock:(callBack)callBack;

@end
