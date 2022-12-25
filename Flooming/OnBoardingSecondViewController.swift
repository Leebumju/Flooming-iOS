//
//  OnBoardingSecondViewController.swift
//  Flooming
//
//  Created by 이범준 on 9/29/22.
//

import UIKit

class OnBoardingSecondViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: "1. 다른 사용자에게 불쾌감, 피해를 주는 콘텐츠를 게시하지 않는다는 것에 동의합니다. \n\n2. 위 사항을 준수하지 않을 시 별다른 통보 없이 해당 게시물이 삭제될 수 있습니다.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10 // Whatever line spacing you want in points
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        textLabel.attributedText = attributedString
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
