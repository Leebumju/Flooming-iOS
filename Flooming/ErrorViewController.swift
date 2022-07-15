//
//  ErrorViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/15/22.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var errorView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorView.clipsToBounds = true
        errorView.layer.cornerRadius = 30
        errorView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        errorView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
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
