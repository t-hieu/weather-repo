//
//  UIImageView+Extension.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/30/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit
import AlamofireImage

public protocol TRLoadedImageDelegate: class {
    func loadedImage()
}

public extension UIImageView {

    func setImageFromURl(stringImageUrl url: String, delegate: TRLoadedImageDelegate?){
        image = nil
        let url = URL(string: url)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, respones, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    //                    let imageToCache = UIImage.init(data: data!)
                    //                    imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                    self.image = UIImage.init(data: data!)
                    if(delegate != nil){
                        delegate?.loadedImage()
                    }
                }
            }
        }).resume()
    }
    
    func getHeightImageWithRatio() -> CGFloat{
        if(image != nil){
            let imageRatio = (image?.size.width)! / (image?.size.height)!
            let screenWidth = UIScreen.main.bounds.width
            let imageHeight = screenWidth / imageRatio
            return imageHeight
        }else{
            return 0
        }
    }
    
//    func setImageURLWithIndicatorView(with url: URL?) {
//        if let url = url{
//            self.activityIndicatorView.startAnimating()
//            self.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.curlUp(0), runImageTransitionIfCached: true) { (response) in
//                self.activityIndicatorView.stopAnimating()
//                if let data = response.data{
//                    self.image = UIImage.init(data: data)
//                }else{
//                    self.image = nil
//                }
//            }
//        }
//    }
}
