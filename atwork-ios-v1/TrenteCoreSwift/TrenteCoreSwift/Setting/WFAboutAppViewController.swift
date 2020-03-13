//
//  WFAboutAppViewController.swift
//  TrenteCoreSwift
//
//  Created by HtHoan on 1/23/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

open class WFAboutAppViewController: WFBaseViewController {
    
    @IBOutlet weak var imageAppView: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lisenceWebView: UIWebView!
    @IBOutlet weak var contentView: UIView!
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("ol_about_app_title", comment: "")
        setBackButton()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = super.baseColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.view.backgroundColor = baseColor
        self.contentView.backgroundColor = backgroundColor
        imageAppView.image = imageApp
        let version  = String(format: versionLabel.text! + "%@", Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)
        versionLabel.text = version
        
        if let path = Bundle.main.path(forResource: "lisence_info", ofType: "html") {
            do {
                let htmlString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                self.lisenceWebView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
            } catch {
                
            }
        }
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
