//
//  AWVersionViewController.swift
//  LiftWork
//
//  Created by CuongNV on 5/9/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import WebKit

class AWVersionViewController: LWBaseViewController, LWViewOneLabelDelegate,WKUIDelegate {
    
    
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var titleRow: LWViewOneLabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var versionLabel: LWBlackNormalRegularLabel!
    var wkWebView: WKWebView!
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        wkWebView = WKWebView(frame: .zero, configuration: webConfiguration)
//        wkWebView.uiDelegate = self
//        self.containerView.addSubViewWithConstraints(subView: wkWebView)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        wkWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        wkWebView.uiDelegate = self
        self.containerView.addSubViewWithConstraints(subView: wkWebView)

        //version
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
           self.versionLabel.text = String.init(format: NSLocalizedString("VERSION", comment: ""), version)
        }
        
        self.navigationItem.title = NSLocalizedString("lw_about_app", comment: "")
        self.titleRow.labTitle.text = NSLocalizedString("lw_button_back", comment: "")
        self.titleRow.delegate = self
        // init and load request in webview.
        wkWebView.navigationDelegate = self
        
        
        if let path = Bundle.main.path(forResource: "lisence_info", ofType: "html") {
            wkWebView.activityIndicatorView.startAnimating()
            do {
                var htmlString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                htmlString = """
                <head><style>@font-face { font-family: 'SFProDisplay-Bold'; src: url('SFProDisplay-Bold.otf')} body { font-family: 'SFProDisplay-Regular'; font-size:25pt;  color: black; padding: 0pt;text-align:'left'; } h1 { font-family: 'SFProDisplay-Bold'; font-size: 35pt; color: black; } p { font-family: 'SFProDisplay-Regular'; font-size: 25pt } a{ color: blue }</style> </head><body>
                        \(htmlString)
                        </body>
                """
                wkWebView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
            } catch {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tapViewOneLabelInTime(view: LWViewOneLabel) {
        
    }
    
    func tapViewOneLabelInTitle(view: LWViewOneLabel) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension AWVersionViewController:WKNavigationDelegate{
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
