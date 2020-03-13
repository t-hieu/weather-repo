//
//  ATImageDetailViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/21/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATImageDetailViewController: UIViewController {
    @IBOutlet weak var imageContent: UIImageView!
    @IBAction func doneTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var imageData: Data!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.imageContent.image = UIImage.init(data: self.imageData)
    }

}
