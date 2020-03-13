//
//  AlamofireManager.swift
//  @Work
//
//  Created by Nguyen Duc Viet on 06/19/18.
//  Copyright © 2017 TrenteVietNam. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftMessages
import TrenteCoreSwift

let STATUS_CODE_SUCCESS =  "OK" //OK
let RESPONSE_COMMON_INVALID_PARAM = "AW000"
let RESPONSE_COMMON_EXPIRED = "AW001"
let RESPONSE_COMMON_OLD_VERSION = "AW002"
let RESPONSE_COMMON_NEED_UPDATE_VERSION = "AW003"
class AlamofireManager:SessionManager{
    
    static let shared: AlamofireManager = {
//        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
//            certificates: ServerTrustPolicy.certificates(),
//            validateCertificateChain: true,
//            validateHost: true
//        )
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
////                    "app-atwork.com": serverTrustPolicy,
//                    "app-atwork.com": .disableEvaluation
//        ]

//        let instance = AlamofireManager.init(configuration: URLSessionConfiguration.default, delegate: SessionDelegate() , serverTrustPolicyManager: ServerTrustPolicyManager.init(policies: serverTrustPolicies))
        let instance = AlamofireManager()
        return instance
    }()
    
    
     func request(_ urlRequest: URLRequestConvertible,showError:Bool = true,completion:@escaping ([String:Any]?)->Void){
                guard isConnected else{
                    self.showNackBarWithError(message: NSLocalizedString("tr_no_internet_connection", comment: ""))
                    completion(nil)
                    return
                }
        Alamofire.request(urlRequest).validate().responseJSON { (response)-> Void in
            self.checkResponse(response: response, completion: completion,showError:showError)
        }
    }
    
    
    //    class func upload(_ multipartFormData:@escaping (MultipartFormData) -> Void,params:[String:Any],with urlRequest:URLRequestConvertible,completion:@escaping ([String:Any]?)->Void){
    //        guard isConnected else{
    //            self.showNackBarWithError(message: NSLocalizedString("tr_no_internet_connection", comment: ""))
    //            completion(nil)
    //            return
    //        }
    //        Alamofire.upload(multipartFormData: { (multipartData) in
    //            multipartFormData(multipartData)
    //            for (key, value) in params {
    //                multipartData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
    //            }
    //        }, with: urlRequest) { (encodingResult) in
    //            switch encodingResult {
    //            case .success(let upload, _, _):
    //                upload.responseJSON { response in
    //                    self.checkResponse(response: response, completion: completion)
    //
    //                }
    //            case .failure(let encodingError):
    //                print(encodingError)
    //                self.showNackBarWithError(message: nil)
    //                completion(nil)
    //            }
    //        }
    //    }
    
     func checkResponse(response:DataResponse<Any>,completion:(_ responseJSON:[String:Any]?)->Void,showError:Bool = true){
        var isSuccess = false
        if let httpStatusCode = response.response?.statusCode {
            switch httpStatusCode{
            case 200:
                isSuccess = true
                break
            case 401:
                completion(nil)
                clearSesson()
                return
            default:
                completion(nil)
                self.showNackBarWithError(message: nil)
                return
            }
        }else{
            completion(nil)
            if case let .failure(error) = response.result {
                checkHttpError(error)
            }
//            self.showNackBarWithError(message: NSLocalizedString("SERVER_STOPPED", comment: ""))
            return
        }
        
        if(isSuccess){
            // 1.check Http response
            guard response.result.isSuccess else {
                completion(nil)
                guard case let .failure(error) = response.result else { return }
                checkHttpError(error)
                return
            }
            
            //3.Check response format
            guard let responseJSON = response.result.value as? [String: Any] else {
                completion(nil)
                self.showNackBarWithError(message: nil)
                return
            }
            
            //4.check common response
            guard self.checkCommonReturnCode(response: responseJSON) else{
                completion(nil)
                return
            }
            
            //5.validate
            guard let code = responseJSON["status"] as? String, code == STATUS_CODE_SUCCESS else{
                if showError{
                    completion(nil)
                    self.showAlertError(msg: responseJSON["messages"] as! String)
                }else{
                    completion(responseJSON)
                }
                return
            }
            
            //6.return data as json
            completion(responseJSON)
        }
    }
    
     var isConnected:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
     func checkHttpError(_ error:Error) {
        
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                print("Invalid URL: \(url) - \(error.localizedDescription)")
            case .parameterEncodingFailed(let reason):
                print("Parameter encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            case .multipartEncodingFailed(let reason):
                print("Multipart encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            case .responseValidationFailed(let reason):
                print("Response validation failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    print("Downloaded file could not be read")
                case .missingContentType(let acceptableContentTypes):
                    print("Content Type Missing: \(acceptableContentTypes)")
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                case .unacceptableStatusCode(let code):
                    print("Response status code was unacceptable: \(code)")
                }
            case .responseSerializationFailed(let reason):
                print("Response serialization failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            }
            
            print("Underlying error: \(String(describing: error.underlyingError))")
        } else if let error = error as? URLError {
            print("URLError occurred: \(error)")
             self.showNackBarWithError(message: NSLocalizedString("SSL_CERTIFICATE_INVALID", comment: ""))
        } else {
            print("Unknown error: \(error)")
        }
    }
    
     func checkCommonReturnCode(response:[String:Any])->Bool{
        guard let _ = response["hasReturnCode"] as? Int, let code = response["returnCode"] as? String else{
            return false
        }
        
        guard code != RESPONSE_COMMON_INVALID_PARAM else {
            if let msg = response["messages"] as? String{
                self.showAlertError(msg: msg)
            }
            return false
        }
        
        guard code != RESPONSE_COMMON_EXPIRED else {
            if let msg = response["messages"] as? String{
                let alert = UIAlertController.init(title: NSLocalizedString("ERROR", comment: ""), message: msg, preferredStyle: .alert)
                let okAction:UIAlertAction = UIAlertAction.init(title: NSLocalizedString("ACTION_OK", comment: ""), style: .default) { (action) in
                    APP_DELEGATE?.clearAll()
                }
                alert.addAction(okAction)
                KEY_WINDOW?.topMostWindowController()?.present(alert, animated: true, completion: nil)
            }else{
                APP_DELEGATE?.clearAll()
            }
            return false
        }
        
        
        guard code != RESPONSE_COMMON_NEED_UPDATE_VERSION else {
            if let msg = response["messages"] as? String{
                APP_DELEGATE?.clearAll()
                self.gotoAppStoreToUpdateVersionAlert(isRequired:true,message:msg)
            }
            return false
        }
        
        return true
    }
    
     func gotoAppStoreToUpdateVersionAlert(isRequired:Bool = false,message:String){
        //        DispatchQueue.global().async {
        //            do {
        //                let newVersion = try self.getNewestVersion()
        //                DispatchQueue.main.async {
        //                    self.showAppStoreAlert(newVersion: newVersion,isRequired:isRequired)
        //                }
        //            } catch {
        //                print(error)
        //            }
        //        }
        
        self.showAppStoreAlert(message: message,isRequired:isRequired)
        
    }
    
     func showAppStoreAlert(message:String,isRequired:Bool = false){
        //        let msg = isRequired ? String.init(format: NSLocalizedString("UPDATE_VERSION_MESSAGE_REQUIRED", comment: ""), newVersion) : String.init(format: NSLocalizedString("UPDATE_VERSION_MESSAGE", comment: ""), newVersion)
        let alert = UIAlertController.init(title: "", message:message , preferredStyle: .alert)
        let laterAction:UIAlertAction = UIAlertAction.init(title: NSLocalizedString("ACTION_LATER", comment: ""), style: .cancel) { (action) in
            
        }
        
        let okAction:UIAlertAction = UIAlertAction.init(title: NSLocalizedString("ACTION_APP_STORE", comment: ""), style: .default) { (action) in
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(APP_STORE_ID)"),
                UIApplication.shared.canOpenURL(url)
            {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
            if isRequired{
                self.showAppStoreAlert(message: message,isRequired: isRequired)
            }
        }
        if !isRequired{
            alert.addAction(laterAction)
        }
        alert.addAction(okAction)
        KEY_WINDOW?.topMostWindowController()?.present(alert, animated: true, completion: nil)
    }
    
     func clearSesson(){
        APP_DELEGATE?.clearAll()
    }
    
     func showNackBarWithError(message:String?){
        let msg = message?.replacingOccurrences(of: "<br>", with: "\n")
        SwiftMessages.show {
            let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
            view.configureTheme(.error)
            view.button?.isHidden = true
            view.configureDropShadow()
            view.configureContent(title: "", body: msg ?? NSLocalizedString("ERROR_UNKNOWN", comment: "") )
            view.tapHandler = { _ in SwiftMessages.hide() }
            return view
        }
    }
    
     func showAlertError(msg:String){
        let message = msg.replacingOccurrences(of: "<br>", with: "\n")
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        let okAction:UIAlertAction = UIAlertAction.init(title: NSLocalizedString("ACTION_OK", comment: ""), style: .default) { (action) in
        }
        alert.addAction(okAction)
        KEY_WINDOW?.topMostWindowController()?.present(alert, animated: true, completion: nil)
    }
    
    enum VersionError:Error {
        case invalidBundleInfo
        case invalidResponse
    }
    
     func getNewestVersion() throws -> String {
        guard let info = Bundle.main.infoDictionary,
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                throw VersionError.invalidBundleInfo
        }
        let data = try Data(contentsOf: url)
        guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
            throw VersionError.invalidResponse
        }
        if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
            return version
        }
        throw VersionError.invalidResponse
    }
}

