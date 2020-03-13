//
//  CameraViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/8/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

protocol CameraViewCellDelegate {
    func tapCameraViewCell(isTitleTap: Bool)
    func tapCameraViewCellDeleteImage()
   
}
class CameraViewCell: UITableViewCell {

    @IBOutlet weak var titleView: UIView!
    var delegate: CameraViewCellDelegate!
    var isActive: Bool!
    @IBAction func tapContent(_ sender: Any) {
//        if isActive {
            delegate.tapCameraViewCell(isTitleTap: false)
//        }
    }
    @IBOutlet weak var imgContent: UIImageView!
    @IBAction func tapCamera(_ sender: Any) {
        if isActive {
            delegate.tapCameraViewCell(isTitleTap: true)
        }
    }
    
   
    @IBOutlet weak var btDelete: UIButton!
    @IBAction func deleteImage(_ sender: Any) {
        delegate.tapCameraViewCellDeleteImage()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleView.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setActive(isActive: Bool){
//        if self.isActive != isActive {
            self.isActive = isActive
//            self.btDelete.isHidden = !isActive
//        }
    }
    
}
