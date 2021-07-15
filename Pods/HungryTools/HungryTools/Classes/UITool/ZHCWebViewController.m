//
//  ZHCWebViewController.m
//  HungryTools
//
//  Created by 张海川 on 2019/10/30.
//

#import "ZHCWebViewController.h"
#import <WebKit/WKWebView.h>

@interface ZHCWebViewController ()

/// 是否使用网页标题
@property (nonatomic, assign) BOOL              autoConfigTitle;

@property (nonatomic, strong) WKWebView *       webView;
@property (nonatomic, strong) UIProgressView *  progressView;

@end

@implementation ZHCWebViewController

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    if (_autoConfigTitle) {
        [self.webView removeObserver:self forKeyPath:@"title"];
    }
}

- (instancetype)initWithURLString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _urlString = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setValue:@1 forKey:@"fd_interactivePopDisabled"];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    _autoConfigTitle = self.title == nil;
    
    
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.webView stopLoading];
}

#pragma mark - KVO的监听代理

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    // 加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if (object == self.webView)
        {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.5f
                                      delay:0.3f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.progressView setAlpha:0.0f];
                                 }
                                 completion:^(BOOL finished) {
                                     [self.progressView setProgress:0.0f animated:NO];
                                 }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    // 网页title
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.webView)
        {
            self.title = self.webView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Getter

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = UIColor.whiteColor;
        if (_autoConfigTitle) {
            [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        }
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 0.5)];
        _progressView.tintColor = [UIColor colorWithRed:255/255.f green:80/255.f blue:74/255.f alpha:1];
        _progressView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

@end
