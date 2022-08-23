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
    var photo_id: Int = 1
    var detail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // shadow 적용하기 위한 containerView
        
        infoView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        infoView.layer.shadowOffset = CGSize(width: 1, height: 4)
        infoView.layer.shadowRadius = 10
        infoView.layer.shadowOpacity = 1
//            
//        // infoView 모서리 둥글게 만들기
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
                    parameters: ["gallery_id": photo_id, "detail": detail ], // [전송 데이터]
                    encoding: JSONEncoding.default, // [인코딩 스타일]
                    headers: header // [헤더 지정]
                )
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                       // print("아아아아ㅏ아아아ㅏ아아ㅏ아\(String(describing: self.pictureImageUrl))")
                        default:
                        return
                    }
                }
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

