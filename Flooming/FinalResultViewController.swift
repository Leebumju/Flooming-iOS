//
//  FinalResultViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/18/22.
//

import UIKit

class FinalResultViewController: UIViewController {

    var selectedImage: UIImage!
    
    @IBOutlet weak var finalResultView: UIView!
    @IBOutlet weak var finalResultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        finalResultView.clipsToBounds = true
        finalResultView.layer.cornerRadius = 30
        finalResultView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        finalResultView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
        // Do any additional setup after loading the view.
        
        finalResultImageView.image = selectedImage
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
