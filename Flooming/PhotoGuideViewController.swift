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
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoGuideView.clipsToBounds = true
        photoGuideView.layer.cornerRadius = 30
        photoGuideView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        photoGuideView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
        
        correctLabel.numberOfLines = 0;
        wrongLabel.numberOfLines = 0;
        
        correctPhotoImage?.layer.borderWidth = 2
        correctPhotoImage?.layer.borderColor = UIColor.white.cgColor
        
        wrongPhotoImage?.layer.borderWidth = 2
        wrongPhotoImage?.layer.borderColor = UIColor.white.cgColor
        
        correctLabel.text = "이렇게 \n찍어주세요"
        wrongLabel.text = "이렇게 \n찍지 말아주세요"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
