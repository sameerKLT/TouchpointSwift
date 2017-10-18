//
//  ViewController.swift
//  Touchpoint
//
//  Created by Sameer Siddiqui on 10/18/17.
//  Copyright © 2017 KeyLimeTie, LLC. All rights reserved.
//

import UIKit
import WebKit


enum CookieName: String {
    case alias = "userID"
    case tags = "tags"
    case badgeCount = "badgeCount"
}

class ViewController: UIViewController {

    let touchPointAliasCookieName = "userID"

    var isUserAuthenticated: Bool = false
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true

        webView.uiDelegate = self
        webView.navigationDelegate = self

        webView.load(URLRequest(url: URL(string: "https://dev.ustouchpoint.com")!))
    }

}

extension ViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("started navigating")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("failed")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("failed provisoing")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finished")
        processCookies()
        
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("recieved challenge")
    }
    
}


extension ViewController {
    
    func processCookies() {

        let cookieJar = WKWebsiteDataStore.default().httpCookieStore
        cookieJar.getAllCookies { (cookies) in
            for cookie in cookies {
                print("number of cookies in jar = \(cookies.count)")
                if cookie.name == CookieName.alias.rawValue {
                    self.isUserAuthenticated = true
                    print("user was authenticated")
                    self.navigationController?.isNavigationBarHidden = false
                }

            }
        }
        
//        for cookie in cookieJar.cookies! {
//            if cookie.name == CookieName.alias.rawValue {
//                isUserAuthenticated = true
//                print("user was authenticated")
//            }
//        }
//        NSHTTPCookie *cookie;
//        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        NSString *alias =nil;
//        NSArray *tags = nil;
//        NSInteger badgeNumber = 0;
//        for (cookie in [cookieJar cookies]) {
//            if ([cookie.name isEqualToString:TouchPointAliasCookieName]) {
//                alias = [cookie.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                self.userAuthenticated = ([alias length] > 0) ? YES : NO;
//            } else if ([cookie.name isEqualToString:TouchPointTagsCookieName]) {
//                NSString *tagString = [cookie.value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                tags = [tagString componentsSeparatedByString:@","];
//
//            } else if ([cookie.name isEqualToString:TouchPointBadgeCountCookieName]) {
//                badgeNumber = [cookie.value integerValue];
//            }
//        }
//        if (self.isUserAuthenticated) {
//
//            [self updateUrbanAirhipRegistrationAlias:alias tags:tags badgeNumber:badgeNumber];
//        }
    }
}
