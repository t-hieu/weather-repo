//
//  HTTPRequestManager.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/15/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SystemConfiguration
import Toaster

public class HTTPRequestManager: NSObject {
    
    static var singleton: HTTPRequestManager? = nil
    
    public class func getInstance() -> HTTPRequestManager!{
        if(singleton == nil){
            singleton = HTTPRequestManager()
        }
        return singleton
    }
    
    //
    //  MARK: asyncGET
    //  call api with GET method
    //
    public func asyncGET(url: String, params: [String: AnyObject], isLoading: Bool,
                         success: @escaping ((NSDictionary) -> Void)) {
        
        if(self.connected()){
            if (isLoading) {
                SVProgressHUD.show()
            }
            
            Alamofire.request(
                URL(string: url)!,
                method: .get,
                parameters: params)
                .validate()
                .responseJSON { (response) -> Void in
                    switch response.result {
                    case .success(let JSON):
                        let response = JSON as! NSDictionary
                        let status = response["status"] as! String
                        if(status == "OK"){
                            SVProgressHUD.dismiss()
                            success(response)
                        }else{
                            SVProgressHUD.dismiss()
                            self.showError(responseObject: response, isShow: true)
                        }
                        break
                    case .failure(let error):
                        print(error)
                        SVProgressHUD.dismiss()
                        self.showNetWorkLostMS()
                        break
                    }
            }
        }else{
            self.showNetWorkLostMS()
        }
    }
    
    //
    //  MARK: asyncPOST
    //  call api with POST method
    //
    public func asyncPOST(url: String, params: [String: AnyObject], isLoading: Bool,
                          success: @escaping ((NSDictionary) -> Void)) {
        
        if(self.connected()){
            if (isLoading) {
                SVProgressHUD.show()
            }
            
            Alamofire.request(
                URL(string: url)!,
                method: .post,
                parameters: params)
                .validate()
                .responseJSON { (response) -> Void in
                    switch response.result {
                    case .success(let JSON):
                        let response = JSON as! NSDictionary
                        let status = response["status"] as! String
                        if(status == "OK"){
                            success(response)
                            SVProgressHUD.dismiss()
                        }else{
                            SVProgressHUD.dismiss()
                            self.showError(responseObject: response, isShow: true)
                        }
                        break
                    case .failure(let error):
                        print(error)
                        SVProgressHUD.dismiss()
                        self.showNetWorkLostMS()
                        
                        break
                    }
            }
        }else{
            self.showNetWorkLostMS()
        }
    }
    
    //
    //  MARK: asyncPOST
    //  call api to upload file
    //
    public func asyncPOST(url: String, params: [String: AnyObject], isLoading: Bool, datas: [DataModel],success: @escaping (NSDictionary) -> Void) {
        if(self.connected()){
            if (isLoading) {
                SVProgressHUD.show()
            }
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in params {
                    if value is String || value is Int {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
                
                for data in datas {
                    multipartFormData.append(data.data!, withName: data.name!, fileName: data.fileName!, mimeType: "image/jpg")
                }
            }, to: url)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        //Print progress
                    })
                    
                    upload.responseJSON { response in
                        switch response.result {
                        case .success(let JSON):
                            let response = JSON as! NSDictionary
                            let status = response["status"] as! String
                            if(status == "OK"){
                                success(response)
                                SVProgressHUD.dismiss()
                            }else{
                                SVProgressHUD.dismiss()
                                self.showError(responseObject: response, isShow: true)
                            }
                            break
                        case .failure(let error):
                            SVProgressHUD.dismiss()
                            self.showNetWorkLostMS()
                            print(error)
                            break
                        }
                    }
                    break
                case .failure(let encodingError):
                    print(encodingError)
                    break
                }
            }
        }else{
            self.showNetWorkLostMS()
        }
        
    }
    
    func showError(responseObject: NSDictionary, isShow: Bool) {
        
        var messages = responseObject["messages"] as? String
        if(messages != nil) {
            messages = messages?.replacingOccurrences(of: "<br>", with: "\n")
        }
        if (isShow) {
            let alertView = UIAlertController(title: "Warning", message: messages!, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.removeFromParentViewController()
            }
            alertView.addAction(okAction)
            
            let vc = UIApplication.shared.delegate?.window!!.rootViewController
            vc?.present(alertView, animated: true, completion: nil)
        }
    }
    
    func presentAlertFromController(vc: UIViewController, alert: UIAlertController){
        if (vc.isKind(of: UITabBarController.self)) {
            let viewController = (vc as! UITabBarController).selectedViewController
            self.presentAlertFromController(vc: viewController!, alert: alert)
        }else if(vc.isKind(of: UINavigationController.self)){
            let viewController = (vc as! UINavigationController).visibleViewController
            self.presentAlertFromController(vc: viewController!, alert: alert)
        }else{
            vc.presentedViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func showNetWorkLostMS() {
        ToastView.appearance().font = ToastView.appearance().font?.withSize(20)
        Toast(text: NSLocalizedString("tr_no_internet_connection", comment: ""), duration: Delay.long).show()
    }
    
    //Network
    func connected() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }

}
