//
//  OnBoardingSecondViewController.swift
//  Flooming
//
//  Created by 이범준 on 9/29/22.
//

import UIKit

class OnBoardingSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func goToMainButton(_ sender: Any) {
        presentMainVC()
    }
    private func presentMainVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }

}
