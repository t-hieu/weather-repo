//
//  PBURLRequest.swift
//  ProductListing
//
//  Created by Nguyen Duc Viet on 4/4/17.
//  Copyright © 2017 PortalBeanz. All rights reserved.
//

import Foundation
import Alamofire
import TrenteCoreSwift

//define API namespace
enum API{
    case LW_URL_SIGN_IN
    case LW_URL_SIGN_OUT
    case LW_URL_ACCOUNT_DETAIL
    case LW_URL_CONSTRUCTION_LIST
    case LW_URL_LIFT_MATERIAL_LIST
    case LW_URL_CUSTOMER_LIST
    case LW_URL_LIFT_USAGE_LIST
    case LW_URL_LIFT_USAGE_DETAIL
    case LW_URL_LIFT_USAGE_UPDATE
    case LW_URL_LIFT_USAGE_CHECK
    case LW_URL_LIFT_USAGE_DELETE
    case LW_URL_CONTACT_US
    case LW_URL_VERIFYCOMPANYCODE
    case LW_URL_REGISTER_CUSTOMER
    case AT_URL_ACCOUNT_UPDATE
    case LW_URL_SCHEDULE_DETAIL
    case LW_URL_SCHEDULE_UPDATE
    case LW_URL_SCHEDULE_VALIDATE
    case LW_URL_LIFTING_LIST_SCHEDULE
    case LW_URL_LIFTING_MONTHLY_LIST_SCHEDULE
    case LW_URL_VERIFY_ACCOUNT
    case LW_URL_GET_CUSTOMER_GOODS
    case LW_URL_UPDATE_CUSTOMER_GOODS
    case AT_URL_UPDATE_PASSWORD
    case AT_URL_DELETE_SCHEDULE
    case AT_URL_SCHEDULE_WARNING
    case AT_URL_CONSTRUCTION_DETAIL
    case AT_URL_VERIFY_CONSTRUCTION
    case AT_URL_UPDATESITEBREAKTIMES
    case AT_URL_LISTCONTRUCTIONBREAKTIMES
    case AT_URL_UPDATESITERESERVATIONSETTING
    case AT_URL_ACCOUNT_USERINFO
    case AT_URL_RESERVATIONLIST
}

//api path
struct Router {
    func login() -> String { return "/api/account/signin" }
    func logout() -> String { return "/api/account/signout" }
    func getAccountInfo() -> String { return "/api/account/detail" }
    func getConstructions() -> String { return "/api/construction/list" }
    func getLiftMaterials() -> String { return "/api/good/list" }
    func getCustomers() -> String { return "/api/customer/list" }
    func getLiftUsages() -> String { return "/api/lift/usage/list" }
    func getLiftUsageDetail() -> String { return "/api/lift/usage/detail" }
    func postLiftUsageUpdate() -> String { return "/api/lift/usage/update" }
    func postLiftUsageCheck() -> String { return "/api/lift/usage/verify" }
    func postLiftUsageDelete() -> String { return "/api/lift/usage/delete" }
    func postContactUs() -> String { return "/api/account/contactus" }
    func verifyCompanyCode() -> String { return "/api/account/verifyCompanyCode"}
    func registerCustomer() -> String { return "/api/account/registerUserForCustomer"}
    func scheduleDetail() -> String { return "/api/schedule/detail"}
    func scheduleUpdate() -> String { return "/api/schedule/update"}
    func scheduleVerifyConfirm() -> String { return "/api/schedule/verifyConfirm"}
    func liftingListSchedule() -> String { return "/api/schedule/dailies"}
    func liftingListMonthlySchedule() -> String { return "/api/schedule/monthly_schedules"}
    func accountUpdate() -> String { return"/api/account/update" }
    func getCustomerGoods() -> String { return "/api/customer_good/list"}
    func updateCustomerGoods() -> String { return"/api/customer_good/update" }
    func updatePassWord() -> String {return "/api/account/updatePassword" }
    func deleteSchedule() -> String {return "/api/schedule/delete"}
    func scheduleWarning() -> String {return "/api/schedule/warning"}
    func contructionDetail() -> String {return "/api/construction_site/detail" }
    func updateBreakTime() -> String { return "/api/construction_site/updateSiteBreakTimes" }
    func listBeakTime() -> String { return "/api/construction/breakTime" }
    func verifyAccount() -> String { return "/api/account/verifyAccount"}
    func verifyConstruction() -> String { return "/api/construction/check/status"}
    func updateReservationSetting() ->String { return "/api/construction_site/updateSiteReservationSetting"}
    func userInfo() ->String {return "/api/account/userInfo"}
    func reservationList() ->String { return "/api/schedule/schedules" }
}

enum APIRouter:URLRequestConvertible {
    //use this method to get data
    case get(url:API, params:Parameters?,identifier:Int?)
    
    //add new object
    case post(url:API, params:Parameters?,identifier:Int?)
    
    //edit an object
    case update(url:API, params:Parameters?,identifier:Int?)
    
    //delete object
    case delete(url:API, params:Parameters?,identifier:Int?)
    
    //delete object
    case upload(url:API)
    
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .update:
            return .post
        case .delete:
            return .post
        case .upload:
            return .post
        }
    }
    
    var path: String {
        var api:API
        var identifier:Int?
        switch self {
        case .get(let url,_,let id):
            api = url
            identifier = id
        case .post(let url,_,let id):
            api = url
            identifier = id
            
        case .update(let url,_,let id):
            api = url
            identifier = id
        case .delete(let url,_,let id):
            api = url
            identifier = id
        case .upload(let url):
            api = url
        }
        
        let router:Router = Router()
        switch api {
        case .LW_URL_SIGN_IN:
            return router.login()
        case .LW_URL_SIGN_OUT:
            return router.logout()
        case .LW_URL_ACCOUNT_DETAIL:
            return router.getAccountInfo()
        case .LW_URL_CONSTRUCTION_LIST:
            return router.getConstructions()
        case .LW_URL_LIFT_MATERIAL_LIST:
            return router.getLiftMaterials()
        case .LW_URL_CUSTOMER_LIST:
            return router.getCustomers()
        case .LW_URL_LIFT_USAGE_LIST:
            return router.getLiftUsages()
        case .LW_URL_LIFT_USAGE_DETAIL:
            return router.getLiftUsageDetail()
        case .LW_URL_LIFT_USAGE_UPDATE:
            return router.postLiftUsageUpdate()
        case .LW_URL_LIFT_USAGE_CHECK:
            return router.postLiftUsageCheck()
        case .LW_URL_LIFT_USAGE_DELETE:
            return router.postLiftUsageDelete()
        case .LW_URL_CONTACT_US:
            return router.postContactUs()
        case .LW_URL_VERIFYCOMPANYCODE:
            return router.verifyCompanyCode()
        case .LW_URL_REGISTER_CUSTOMER:
            return router.registerCustomer()
            
        case .LW_URL_SCHEDULE_DETAIL:
            return router.scheduleDetail()
        case .LW_URL_SCHEDULE_UPDATE:
            return router.scheduleUpdate()
        case .LW_URL_SCHEDULE_VALIDATE:
            return router.scheduleVerifyConfirm()
        case .LW_URL_LIFTING_LIST_SCHEDULE:
            return router.liftingListSchedule()
        case .LW_URL_LIFTING_MONTHLY_LIST_SCHEDULE:
            return router.liftingListMonthlySchedule()
        case .AT_URL_ACCOUNT_UPDATE :
            return router.accountUpdate()
        case .LW_URL_VERIFY_ACCOUNT:
            return router.verifyAccount()
        case .LW_URL_GET_CUSTOMER_GOODS :
            return router.getCustomerGoods()
        case .LW_URL_UPDATE_CUSTOMER_GOODS:
            return router.updateCustomerGoods()
        case .AT_URL_UPDATE_PASSWORD:
            return router.updatePassWord()
        case .AT_URL_DELETE_SCHEDULE:
            return router.deleteSchedule()
        case .AT_URL_CONSTRUCTION_DETAIL:
            return router.contructionDetail()
        case .AT_URL_VERIFY_CONSTRUCTION:
            return router.verifyConstruction()
        
        case .AT_URL_UPDATESITEBREAKTIMES:
            return router.updateBreakTime()
        case .AT_URL_LISTCONTRUCTIONBREAKTIMES:
            return router.listBeakTime()
        case .AT_URL_UPDATESITERESERVATIONSETTING:
            return router.updateReservationSetting()
        case .AT_URL_ACCOUNT_USERINFO:
            return router.userInfo()
        case .AT_URL_SCHEDULE_WARNING:
            return router.scheduleWarning()
        case .AT_URL_RESERVATIONLIST:
            return router.reservationList()
        }
    
    }
    
    var params:Parameters?{
        switch self {
        case .get(_,let params,_):
            return params
        case .post(_,let params,_):
            return params
        case .update(_,let params,_):
            return params
        case .delete(_,let params,_):
            return params
        default:
            return nil
        }
    }
    
    var contentType:String?{
        return "application/x-www-form-urlencoded"
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try BASE_URL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        //        let authenticationToken = "Bearer \(TRUserDefaults.getToken())"
        //        if !authenticationToken.isEmpty{
        //            request.setValue(authenticationToken, forHTTPHeaderField: "Authorization")
        //        }
        //        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if contentType != nil{
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        request.timeoutInterval = TimeInterval(200)
        
        return try URLEncoding.default.encode(request, with: params)
    }
}

