//
//  DetailPhotoViewController.swift
//  Flooming
//
//  Created by 이범준 on 2022/06/23.
//

import UIKit

class PhotoGuideViewController: UIViewController {
    
    @IBOutlet weak var photoGuideView: UIView!
    @IBOutlet weak var correctPhotoImage: UIImageView!
    @IBOutlet weak var wrongPhotoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.rgbaColorFromHex(rgb: 0x250B77, alpha: 1.0)

        
        settingBackground(view: photoGuideView)
        updateImageBorder(image: correctPhotoImage)
        updateImageBorder(image: wrongPhotoImage)
    }
}
