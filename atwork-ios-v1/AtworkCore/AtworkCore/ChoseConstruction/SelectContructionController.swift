//
//  SelectContructionController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/2/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

public class SelectContructionController: UIViewController, LWChoseConstructionViewDelegate{
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewConstruction: UIView!
    @IBAction func tapChoseConstruction(_ sender: Any) {
        let vc = ChoseConstructionController.init(nibName: ChoseConstructionController.className, bundle: Bundle.init(for: ChoseConstructionController.self))
        if self.construction != nil {
            vc.construction = self.construction
        }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBOutlet weak var labelConstruction: LWBlackNormalBoldLabel!
    
    @IBAction func tapSelectConstruction(_ sender: Any) {
        var params = LWParams.initParamsLW()
        params["key"] = String((self.construction?.key)!)
        
        AlamofireManager.shared.request(APIRouter.get(url: API.AT_URL_VERIFY_CONSTRUCTION, params: params, identifier: nil)) { (response) in
            
            if response != nil{
                if let result : String = response?["status"] as? String{
                    if result.elementsEqual("OK"){
                        ATUserDefaults.setConstructionId(val: (self.construction?.key != nil ? "\((self.construction?.key)!)" : ""))
                        ATUserDefaults.setConstructionName(val: self.construction?.constructionName ?? "")
                        self.navigationController?.popViewController(animated: true)
                    } else if let message: String = response?["message"] as? String{
                        self.showMessage(messages: message)
                    }
                }
            }
            
        }
    }
    
    @IBOutlet weak var btSelect: LWRoundedGrayBlackButton!
    public var index = 0
    public var construction: ATConstructionModel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.viewConstruction.layer.borderWidth = 1
        self.viewConstruction.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewConstruction.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.btSelect.isEnabled = false
        self.labelConstruction.text = ""
        self.logo.image = UIImage(named: "ic_logo")
        // Do any additional setup after loading the view.
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    func tapChoseConstructionView(construction: ATConstructionModel) {
        self.construction = construction
        self.labelConstruction.text = construction.constructionName
        self.btSelect.isEnabled = true
        self.viewContent.backgroundColor = AT_FILL_IN_TEXTFIELD
        self.btSelect.customBgColor = UIColor.orange
        self.btSelect.customTitleColor = AT_COLOR_GRAY
    }
    
}
