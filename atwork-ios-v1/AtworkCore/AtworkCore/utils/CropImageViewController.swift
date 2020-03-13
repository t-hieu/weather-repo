//
//  CropImageViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/10/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

enum WFOCropImageType: NSInteger {
    case WFOCropImageTypeRectangle = 0
    case WFOCropImageTypeSquare = 1
}

internal protocol CropImageViewControllerDelegate: class {
    func croppedImage(imageView: UIImageView )
}
class CropImageViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var cropImageView: WFOCropImageView!
    
    var cropImageType: WFOCropImageType?
    var sourceImageView: UIImageView?
    var isLanscap: Bool?
    var cropImageViewDelegate: CropImageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cropImageView.sourceImageView = sourceImageView
        self.cropImageView.cropImageType = cropImageType
        self.cropImageView.isLanscap = isLanscap
        self.cropImageView.initImageView()
        
        self.doneButton.backgroundColor = UIColor.clear
        self.cancelButton.backgroundColor = UIColor.clear
        self.headerView.backgroundColor = AT_APP_BASE_COLOR
        
        self.cancelButton.setTitle(NSLocalizedString("tr_common_action_cancel", comment: ""), for: UIControlState.normal)
        self.doneButton.setTitle(NSLocalizedString("tr_common_action_done", comment: ""), for: UIControlState.normal)
        self.titleLabel.text = NSLocalizedString("ol_crop_image_title", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        UIApplication.shared.isStatusBarHidden = false
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        UIGraphicsBeginImageContext(self.view.bounds.size)
        let context = UIGraphicsGetCurrentContext()
        self.view.layer.render(in: context!)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        var newFrame = self.cropImageView.centerFrame
        newFrame!.origin.x = (newFrame?.origin.x)! + 1
        newFrame!.origin.y = (newFrame?.origin.y)! + 64
        newFrame!.size.width = (newFrame?.size.width)! - 2
        
        let croppedImage = self.cropInRect(image: img!, rect: newFrame!)
        self.cropImageView.croppedImageView = UIImageView.init(image: croppedImage)
        self.cropImageView?.tag = (self.sourceImageView?.tag)!
        
        self.dismiss(animated: true, completion: {() -> Void in
            
            if (self.cropImageViewDelegate != nil) {
                self.cropImageViewDelegate?.croppedImage(imageView: self.cropImageView.croppedImageView!)
            }
        })
    }
    
    
    
    func cropInRect(image: UIImage, rect: CGRect) -> UIImage!{
        
        let imageRef = image.cgImage!.cropping(to: rect)
        let cropped = UIImage.init(cgImage: imageRef!)
        //        CGImageRelease(imageRef!)
        let size = CGSize.init(width: 300, height: 300)
        
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        cropped.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        var destImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //        resize to < 2MB
        var imgData = UIImageJPEGRepresentation(destImage!, 1.0)!
        if(imgData.count > 3000000){
            imgData = UIImageJPEGRepresentation(destImage!, CGFloat(Float(3072/imgData.count)))!
            destImage = UIImage.init(data: imgData)
        }
        return destImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
