//
//  WebViewViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class WebViewViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var url: String?
    
    var activityIndicatorView: NVActivityIndicatorView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let xAxis = self.parent?.view.frame.size.width  else {
            return
        }
        
        guard let yAxis = self.parent?.view.frame.size.height  else {
            return
        }
        
        let frame = CGRect(x: (xAxis/2.0)-30.0, y: (yAxis/2.0)-60.0, width: 60, height: 60)
        self.activityIndicatorView = NVActivityIndicatorView(frame: frame)
        self.activityIndicatorView.color = UIColor(red:0.00, green:0.29, blue:0.51, alpha:1.0)
        
        self.view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.startAnimating()
        
        guard let url = self.url else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let myURL = URL(string: "http://" + url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    
}

extension WebViewViewController:  WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.removeFromSuperview()
    }
}
