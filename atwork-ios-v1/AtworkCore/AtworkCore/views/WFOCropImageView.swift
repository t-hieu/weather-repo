//
//  WFOCropImageView.swift
//  OfficeLetter
//
//  Created by TrungND on 8/30/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

class WFOCropImageView: UIView, UIScrollViewDelegate {

    @IBOutlet var view: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var topView: UIView?
    var rightView: UIView?
    var bottomView: UIView?
    var leftView: UIView?
    var cropView: UIView?
    
    var centerFrame: CGRect?
    var cropImageType: WFOCropImageType?
    var imageView: UIImageView?
    var sourceImageView: UIImageView?
    
    var rectangleRadius: CGFloat = 0
    var rectangleCenter: CGPoint! = CGPoint()
    let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.size.height - 44
    
    var isLanscap: Bool?
    var croppedImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WFOCropImageView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil).first as? UIView
//        addSubview(contentView)//        Bundle.ma÷in.loadNibNamed("WFOCropImageView", owner: self, options: nil)
        self.scrollView.delegate = self
        self.scrollView.scrollsToTop = false
        self.initViews()
        self.addSubview(view)
    }
    
    public func initImageView(){
        self.scrollView.bouncesZoom = true
        self.scrollView.delegate = self
        self.scrollView.clipsToBounds = true
        //Setting up the imageView

        let imageViewWidth = SCREEN_WIDTH
        let imageViewHeight = (self.sourceImageView?.image?.size.height)! * SCREEN_WIDTH / (self.sourceImageView?.image?.size.width)!
        self.imageView = UIImageView.init(frame: CGRect.init(x: 0, y: (SCREEN_HEIGHT - imageViewHeight) / 2, width: imageViewWidth, height: imageViewHeight))

        self.imageView?.image = self.sourceImageView?.image
        self.imageView?.tag = (self.sourceImageView?.tag)!
        self.imageView?.backgroundColor = UIColor.black
        
        self.scrollView.addSubview(self.imageView!)
        
        //        rotate
        self.imageView?.isUserInteractionEnabled = true
        self.imageView?.isMultipleTouchEnabled = true
        let rotationGestureRecognizer = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotationWithGestureRecognizer))
        self.imageView?.addGestureRecognizer(rotationGestureRecognizer)
        
        //        pinch
        let pinchGesture = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchZoom))
        self.imageView?.addGestureRecognizer(pinchGesture)
        
        self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        let width = UIApplication.shared.keyWindow?.frame.size.width
        //        calculate minimum scale to perfectly fit image width, and begin at that scale
        let minimumScale = 270.0 / width! // This is the minimum scale, set it to whatever you want. 1.0 = default
        self.scrollView.maximumZoomScale = 4.0
        self.scrollView.minimumZoomScale = 0.2
        self.scrollView.zoomScale = minimumScale
        
        if(isLanscap)!{
            self.scrollView.zoom(to: (self.cropView?.frame)!, animated: false)
        }
        self.scrollView.contentSize = CGSize.init(width: (self.imageView?.frame.size.width)!, height: (self.imageView?.frame.size.height)!)
        self.scrollView.minimumZoomScale = self.scrollView.maximumZoomScale
        self.scrollView.pinchGestureRecognizer?.isEnabled = false
        self.setContentInsetForScrollView()
        self.scrollView.showsHorizontalScrollIndicator = false
    }
    
    @objc func handleRotationWithGestureRecognizer(rotationGestureRecognizer: UIRotationGestureRecognizer){
        self.imageView?.transform = (self.imageView?.transform)!.rotated(by: rotationGestureRecognizer.rotation)
        rotationGestureRecognizer.rotation = 0.0
    }
    
    @objc func pinchZoom(gestureRecognizer: UIPinchGestureRecognizer){
        gestureRecognizer.view?.transform = (gestureRecognizer.view?.transform)!.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
        gestureRecognizer.scale = 1.0
    }
    
    func setContentInsetForScrollView() {
        let vSpace = self.topView?.frame.height
        self.scrollView.contentInset = UIEdgeInsetsMake(2 * vSpace!, 2 * vSpace!, 2 * vSpace!, 3 * vSpace!)
        self.scrollView.contentOffset = CGPoint.zero
    }
    
    func initViews() {
        self.topView = UIView.init()
        self.topView?.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        self.topView?.isUserInteractionEnabled = false
        self.rightView = UIView.init()
        self.rightView?.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        self.rightView?.isUserInteractionEnabled = false
        self.bottomView = UIView.init()
        self.bottomView?.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        self.bottomView?.isUserInteractionEnabled = false
        self.leftView = UIView.init()
        self.leftView?.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        self.leftView?.isUserInteractionEnabled = false
        
        self.view.addSubview(self.topView!)
        self.view.addSubview(self.leftView!)
        self.view.addSubview(self.bottomView!)
        self.view.addSubview(self.rightView!)
        
        self.updateRectanglePathAtLocation()
    }
    
    func updateRectanglePathAtLocation(){
        let centerWidth = SCREEN_WIDTH * 2 / 3
        self.centerFrame = CGRect(x: (SCREEN_WIDTH - centerWidth) / 2, y: (SCREEN_HEIGHT - centerWidth) / 2, width: centerWidth, height: centerWidth)
        
        self.cropView = UIView.init(frame: self.centerFrame!)
        self.cropView?.clipsToBounds = true
        self.cropView?.backgroundColor = UIColor.clear
        self.cropView?.layer.borderWidth = 2.0
        self.cropView?.layer.borderColor = UIColor.lightGray.cgColor
        self.cropView?.isUserInteractionEnabled = false
        self.addSubview(self.cropView!)
        
        self.topView?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: (self.centerFrame?.minY)!)
        self.bottomView?.frame = CGRect.init(x: 0, y: (self.centerFrame?.maxY)!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - (self.centerFrame?.maxY)!)
        self.leftView?.frame = CGRect.init(x: 0, y: (self.centerFrame?.minY)!, width: (self.centerFrame?.minX)!, height: (self.centerFrame?.height)!)
        self.rightView?.frame = CGRect.init(x: (self.centerFrame?.maxX)!, y: (self.centerFrame?.minY)!, width: SCREEN_WIDTH - (self.centerFrame?.maxX)!, height: (self.centerFrame?.height)!)
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 10, width: SCREEN_WIDTH, height: 20))
        label.text = NSLocalizedString("ol_crop_photo_description", comment: "")
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.textColor = UIColor.white
        label.alpha = 0.8
        label.textAlignment = NSTextAlignment.center
        label.center = CGPoint.init(x: SCREEN_WIDTH / 2.0, y: label.frame.midY)
        self.bottomView?.addSubview(label)
    }
}
