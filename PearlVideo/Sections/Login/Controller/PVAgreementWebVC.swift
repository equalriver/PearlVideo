//
//  PVAgreementWebVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit
import WebKit

class PVAgreementWebVC: PVBaseNavigationVC {
    
    lazy var webView: WKWebView = {
        let v = WKWebView()
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var progressView: UIProgressView = {
        let v = UIProgressView()
        v.progressTintColor = UIColor.init(red: 0, green: 210 / 255.0, blue: 0, alpha: 1.0)
        v.trackTintColor = UIColor.clear
        return v
    }()
    required convenience init(url: String, title: String) {
        self.init()
        self.title = title
        if let url = URL.init(string: url) {
            let req = URLRequest.init(url: url)
            webView.load(req)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(progressView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.bottom.centerX.equalToSuperview()
        }
        progressView.snp.makeConstraints { (make) in
            make.top.width.centerX.equalTo(webView)
            make.height.equalTo(2)
        }
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath != nil else { return }
        if keyPath! == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.progress = Float(webView.estimatedProgress)
        }
        //加载完成
        if progressView.progress == 1.0 {
            progressView.alpha = 0
        }
    }
    
}

extension PVAgreementWebVC: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
    }
    
    //加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
//        YPJOtherTool.ypj.showAlert(title: nil, message: "加载失败，点击重试", style: .alert, isNeedCancel: true) { (ac) in
//            
//        }
        
    }
    
    //提交失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        
    }
}
