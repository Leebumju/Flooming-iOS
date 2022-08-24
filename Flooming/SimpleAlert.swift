//
//  SimpleAlert.swift
//  Flooming
//
//  Created by 이범준 on 6/30/22.
//

import UIKit

func simpleAlert(_ controller: UIViewController, message: String) {
    let alertController = UIAlertController(title: "Caution", message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(alertAction)
    controller.present(alertController, animated: true, completion: nil)
}

func simpleAlert(_ controller: UIViewController, message: String, title: String, handler: ((UIAlertAction) -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: handler)
    alertController.addAction(alertAction)
    controller.present(alertController, animated: true, completion: nil)
}

func simpleDestructiveYesAndNo(_ controller: UIViewController, message: String, title: String, yesHandler: ((UIAlertAction) -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertActionNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
    let alertActionYes = UIAlertAction(title: "Yes", style: .destructive, handler: yesHandler)
    alertController.addAction(alertActionNo)
    alertController.addAction(alertActionYes)
    controller.present(alertController, animated: true, completion: nil)
}

func simpleYesAndNo(_ controller: UIViewController, message: String, title: String, yesHandler: ((UIAlertAction) -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertActionNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
    let alertActionYes = UIAlertAction(title: "Yes", style: .default, handler: yesHandler)
    alertController.addAction(alertActionNo)
    alertController.addAction(alertActionYes)
    controller.present(alertController, animated: true, completion: nil)
}

func showAlert(viewController: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: UIAlertController.Style.alert)
    //2. 확인 버튼 만들기
    let cancle = UIAlertAction(title: "취소", style: .default) { (action) in
        //취소 버튼 클릭시 이전 화면으로 돌아가기
        viewController.navigationController?.popViewController(animated: true)
    }
    //3. 확인 버튼을 경고창에 추가하기
    alert.addAction(cancle)
    //4. 경고창 보이기
    viewController.present(alert,animated: true,completion: nil)
}
