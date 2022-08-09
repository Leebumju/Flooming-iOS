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
        photoGuideView.clipsToBounds = true
        photoGuideView.layer.cornerRadius = 30
        photoGuideView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        photoGuideView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
       
        
        correctPhotoImage?.layer.borderWidth = 2
        correctPhotoImage?.layer.cornerRadius = 20
        correctPhotoImage?.layer.borderColor = UIColor.white.cgColor
        
        wrongPhotoImage?.layer.borderWidth = 2
        wrongPhotoImage?.layer.cornerRadius = 20
        wrongPhotoImage?.layer.borderColor = UIColor.white.cgColor
        
    }
}
