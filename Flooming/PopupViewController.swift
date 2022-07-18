//
//  PopupViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/14/22.
//

import UIKit

class PopupViewController: UIViewController {

    var popupImage: UIImage!
    
    @IBOutlet weak var popupImageView: UIImageView!
    @IBOutlet weak var infoView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // shadow 적용하기 위한 containerView
        
        infoView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        infoView.layer.shadowOffset = CGSize(width: 1, height: 4)
        infoView.layer.shadowRadius = 10
        infoView.layer.shadowOpacity = 1
        popupImageView.image = popupImage
//            
//        // infoView 모서리 둥글게 만들기
//        infoView.layer.cornerRadius = 25
//        infoView.clipsToBounds = true
//        view.addSubview(containerView)
//            
//            // containerView 에 대해 Auto Layout 설정
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
//        containerView.widthAnchor.constraint(equalToConstant: 315).isActive = true
//        containerView.heightAnchor.constraint(equalToConstant: 367).isActive = true
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func openButtonTapped(_ sender: Any) {
        
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

