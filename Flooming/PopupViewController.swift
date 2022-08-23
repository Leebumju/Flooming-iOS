//
//  PopupViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/14/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class PopupViewController: UIViewController {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var detailsTextField: UITextField!
    
    let header : HTTPHeaders = ["Content-Type" : "application/json"]
    let floomingUrl: String = "http://flooming.link/report"
    var gallery_id: Int?
    var detail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        infoView.layer.shadowOffset = CGSize(width: 1, height: 4)
        infoView.layer.shadowRadius = 10
        infoView.layer.shadowOpacity = 1

        popupView.clipsToBounds = true
        popupView.layer.cornerRadius = 30
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func openButtonTapped(_ sender: Any) {
        
        detail = self.detailsTextField.text
        
        AF.request(
                    floomingUrl, // [주소]
                    method: .post, // [전송 타입]
                    parameters: ["gallery_id": gallery_id, "detail": detail ], // [전송 데이터]
                    encoding: JSONEncoding.default, // [인코딩 스타일]
                    headers: header // [헤더 지정]
                )
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(_):
//                        let json = JSON(value)
                        let alert = UIAlertController(title:"신고가 완료되었습니다",
                            message: "감사합니다.",
                            preferredStyle: UIAlertController.Style.alert)
                        //2. 확인 버튼 만들기
                        let cancle = UIAlertAction(title: "확인", style: .default) { (action) in
                            //취소 버튼 클릭시 이전 화면으로 돌아가기
                            self.dismiss(animated: false, completion: nil)
                        }
                        //3. 확인 버튼을 경고창에 추가하기
                        alert.addAction(cancle)
                        //4. 경고창 보이기
                        self.present(alert,animated: true,completion: nil)
                        default:
                        return
                    }
                }
    }
}
    
