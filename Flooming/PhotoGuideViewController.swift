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
        
        settingBackground(view: photoGuideView)
        updateImageBorder(image: correctPhotoImage)
        updateImageBorder(image: wrongPhotoImage)
    }
}
