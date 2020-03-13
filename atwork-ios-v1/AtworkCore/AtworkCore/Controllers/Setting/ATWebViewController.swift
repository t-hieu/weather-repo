//
//  ATWebViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/1/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import WebKit

public class ATWebViewController: UIViewController, WKUIDelegate {

    internal var wkWebView: WKWebView!
    public var urlString: String?
    var texttitle: String?
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
//        self.navigationItem.title = "現場情報"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationItem.title = texttitle
        let webConfiguration = WKWebViewConfiguration()
        wkWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        wkWebView.uiDelegate = self
        self.view.addSubViewWithConstraints(subView: wkWebView)
        self.wkWebView.navigationDelegate = self
        
//        titleRow.labTitle.text = NSLocalizedString("lw_button_back", comment: "")
//        titleRow.delegate = self
        
        let url = URL (string: self.urlString!)
        let requestObj = URLRequest(url: url!)
        self.wkWebView.activityIndicatorView.startAnimating()
        self.wkWebView.load(requestObj)
        
    }
    
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension ATWebViewController:WKNavigationDelegate{
    //MARK:- WKNavigationDelegate
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        wkWebView.activityIndicatorView.stopAnimating()
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        wkWebView.activityIndicatorView.stopAnimating()
    }
}
