//
//  WebViewViewController.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 09/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit


class WebViewViewController: UIViewController, UIWebViewDelegate {
    let webView : UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.google.com")!))
        ImageViewLayout.layout(self.view, innerView: webView)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        println("webview fail load \(error)")
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        println("web view started loading")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        println("web view finished loading")
    }
}