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
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.bottom.centerX.equalToSuperview()
        }
    }
    


}
