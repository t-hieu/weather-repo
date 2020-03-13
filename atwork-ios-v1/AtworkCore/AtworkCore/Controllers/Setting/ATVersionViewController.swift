//
//  ATVersionViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/1/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import WebKit

public class ATVersionViewController: UIViewController{
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var versionLabel: LWBlackNormalRegularLabel!
    @IBOutlet weak var webView: UIWebView!
    
//    var wkWebView: WKWebView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.appImage.image = UIImage(named: "ic_logo")
        self.navigationItem.title = "アプリについて"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        
//        let webConfiguration = WKWebViewConfiguration()
//        wkWebView = WKWebView(frame: .zero, configuration: webConfiguration)
//        wkWebView.uiDelegate = self
//        self.containerView.addSubViewWithConstraints(subView: wkWebView)
        
        //version
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
//            self.versionLabel.text = String.init(format: NSLocalizedString("VERSION", comment: ""), version)
            self.versionLabel.text = "バージョン " + version
            
        }
        
        // init and load request in webview.
//        wkWebView.navigationDelegate = self
//
//
//        if let path = Bundle.main.path(forResource: "lisence_info", ofType: "html") {
//            wkWebView.activityIndicatorView.startAnimating()
//            do {
//                var htmlString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
//                htmlString = """
//                <head><style>@font-face { font-family: 'SFProDisplay-Bold'; src: url('SFProDisplay-Bold.otf')} body { font-family: 'SFProDisplay-Regular'; font-size:30pt;  color: black; padding: 0pt;text-align:'left'; } h1 { font-family: 'SFProDisplay-Bold'; font-size: 40pt; color: black; } p { font-family: 'SFProDisplay-Regular'; font-size: 30pt } a{ color: blue }</style> </head><body>
//                \(htmlString)
//                </body>
//                """
//                wkWebView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
//            } catch {
//
//            }
//        }
        if let path = Bundle.main.path(forResource: "lisence_info", ofType: "html") {
            do {
                let htmlString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                self.webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
            } catch {
                
            }
        }
    }

    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }

}

//extension ATVersionViewController:WKNavigationDelegate{
//    //MARK:- WKNavigationDelegate
//    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//
//    }
//    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        wkWebView.activityIndicatorView.stopAnimating()
//    }
//
//    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//
//        wkWebView.activityIndicatorView.stopAnimating()
//    }
//}
