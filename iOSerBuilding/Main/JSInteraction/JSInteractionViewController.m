//
//  JSInteractionViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2020/9/17.
//

#import "JSInteractionViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>
#import <WebKit/WKUserContentController.h>
#import <WebKit/WKScriptMessage.h>

@interface JSInteractionViewController () <WKScriptMessageHandler, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation JSInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    
//    NSString *name = @"index";
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:name ofType:@"html"];
//    NSString *htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    [_webView loadHTMLString:htmlCont baseURL:baseURL];
    NSString *URLStr = @"http://112.13.96.207:13919/unicomm-h5/#/visitorInvite/?communityUuid=1349683571803136&phone=18796945365";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLStr]]];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [[WKUserContentController alloc] init];
    [configuration.userContentController addScriptMessageHandler:self name:@"setRightButton"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = UIColor.whiteColor;
    }
    return _webView;
}

@end
