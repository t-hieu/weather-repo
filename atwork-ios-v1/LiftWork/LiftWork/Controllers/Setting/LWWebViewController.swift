//
//  LWWebViewController.swift
//  LiftWork
//
//  Created by CuongNV on 6/8/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import WebKit

class LWWebViewController: UIViewController, LWViewOneLabelDelegate,WKUIDelegate{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleRow: LWViewOneLabel!
    //    @IBOutlet weak var webContent: UIWebView!
    internal var wkWebView: WKWebView!
    
    var urlString: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        wkWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        wkWebView.uiDelegate = self
        self.containerView.addSubViewWithConstraints(subView: wkWebView)
        self.wkWebView.navigationDelegate = self
        
        titleRow.labTitle.text = NSLocalizedString("lw_button_back", comment: "")
        titleRow.delegate = self
        
        let url = URL (string: self.urlString!)
        let requestObj = URLRequest(url: url!)
        self.wkWebView.activityIndicatorView.startAnimating()
        self.wkWebView.load(requestObj)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tapViewOneLabelInTitle(view: LWViewOneLabel) {
        self.navigationController?.popViewController(animated: true)
    }
    func tapViewOneLabelInTime(view: LWViewOneLabel) {
        
    }
    
    
}

extension LWWebViewController:WKNavigationDelegate{
    //MARK:- WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        wkWebView.activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        wkWebView.activityIndicatorView.stopAnimating()
    }
}
