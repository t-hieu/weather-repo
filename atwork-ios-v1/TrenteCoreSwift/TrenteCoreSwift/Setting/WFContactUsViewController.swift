//
//  WFContactUsViewController.swift
//  TrenteCoreSwift
//
//  Created by HtHoan on 1/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class WFContactUsViewController: WFBaseViewController ,UITextViewDelegate, TRPickerViewDelegate{
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var sendButton: TRButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var detailBackgroundView: UIView!
    @IBOutlet weak var typeBackgroundView: UIView!
    @IBOutlet weak var heightOfContactTextView: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    let kCharacterMaximumLimit = 200
    var requestPicker: TRPickerView?
    var servicePicker: TRPickerView?
    var requestTypes = [WFApiObjectModel]()
    var serviceTypes = [WFApiObjectModel]()
    
    var activeRequest: WFApiObjectModel?
    var activeService: WFApiObjectModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("ol_contact_us_title", comment: "")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = super.baseColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.view.backgroundColor = baseColor
        self.contentView.backgroundColor = backgroundColor
        self.scrollView.backgroundColor = backgroundColor
        setBackButton()
        typeBackgroundView.backgroundColor = baseColor
        detailBackgroundView.backgroundColor = baseColor
        self.contentTextView.delegate = self
        sendButton.layer.cornerRadius = 3
        sendButton.backgroundColor = baseColor
        self.heightOfContactTextView.constant = SCREEN_HEIGHT - 370;
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getRequestType()
        
        self.checkEnableButton()
    }
    
    func getRequestType() {
        let params = TRParamsUtil.initParamsOL()
        
        HTTPRequestManager.getInstance().asyncGET(url: WF_URL_REQUEST_FORM, params: params as [String : AnyObject], isLoading: true, success: {(response) -> Void in
            
            for request in response["requestTypes"] as! NSArray{
                let model = WFApiObjectModel.init(response: request as! [String : Any])
                self.requestTypes.append(model)
            }
            
            for service in response["serviceTypes"] as! NSArray{
                let model = WFApiObjectModel.init(response: service as! [String : Any])
                self.serviceTypes.append(model)
            }
            
        })
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let substring = textView.text
        self.checkEnableButton()
        
        if (kCharacterMaximumLimit >= (substring?.count)!) {
            self.numberLabel.text = TRStringUtil.toString(data: (kCharacterMaximumLimit-(substring?.count)!))
        } else {
            self.numberLabel.text = String.init(format: "-%ld", (substring?.count)! - kCharacterMaximumLimit)
        }
        if ((substring?.count)! <= kCharacterMaximumLimit){
            self.numberLabel.textColor = UIColor.darkGray
        }
        if ((substring?.count)! > kCharacterMaximumLimit){
            self.numberLabel.textColor = UIColor.red
        }
    }
    func checkEnableButton(){
        
        if(!self.contentTextView.text.isEmpty && activeRequest != nil ){
            sendButton.isEnabled = true
        }else{
            sendButton.isEnabled = false
        }
    }
    
    @IBAction func sendButtonClicked(_ sender: TRButton) {
        self.sendRequest()
    }
    
    func sendRequest() {
        var params = TRParamsUtil.initParamsOL()
        params["serviceType"] = "OL"
        params["requestType"] = activeRequest?.key
        params["requestContent"] = contentTextView.text
        
        HTTPRequestManager.getInstance().asyncPOST(url: WF_URL_REQUEST_UPDATE, params: params as [String : AnyObject], isLoading: true, success: {(response) -> Void in
            self.showAlert(title: "", message: NSLocalizedString("contact_us_alert_messge_done", comment: ""))
            
        })
    }
    override func actionAfterShowAlert() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func typeButtonClicked(_ sender: UIButton) {
        self.addRequestTypePicker()
    }
    func addRequestTypePicker() {
        if(requestPicker == nil){
            requestPicker = TRPickerView.init()
            requestPicker?.delegate = self
            var requestArray = [String]()
            for request in requestTypes{
                requestArray.append(request.value!)
            }
            requestPicker?.pickerData = requestArray
        }
        
        requestPicker?.selectedIndex = self.requestPicker?.pickerData.index(of: self.requestLabel.text!)
        requestPicker?.show()
    }
    
    func donePickerView(pickerView: TRPickerView, selectedIndex: Int) {
        if(pickerView == requestPicker){
            activeRequest = requestTypes[selectedIndex]
            self.requestLabel.text = activeRequest?.value
            
        }
        self.checkEnableButton()
    }
}
