//
//  ImageErrorViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/16/22.
//

import UIKit

class ImageErrorViewController: UIViewController {

    @IBOutlet weak var imageErrorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageErrorView.clipsToBounds = true
        imageErrorView.layer.cornerRadius = 30
        imageErrorView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        imageErrorView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
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
