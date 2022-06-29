//
//  DetailPhotoViewController.swift
//  Flooming
//
//  Created by 이범준 on 2022/06/23.
//

import UIKit

class PhotoGuideViewController: UIViewController {

    @IBOutlet weak var photoGuideView: UIView!
    
    @IBOutlet weak var correctLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoGuideView.clipsToBounds = true
        photoGuideView.layer.cornerRadius = 30
        photoGuideView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        correctLabel.text = "이렇게 \n 찍어주세요"

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
