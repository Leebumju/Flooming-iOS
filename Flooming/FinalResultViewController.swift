//
//  FinalResultViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/18/22.
//

import UIKit
import Alamofire
import simd
import SwiftyJSON
import Foundation

class FinalResultViewController: UIViewController {

    var selectedImage: UIImage!
    var photo_id: Int?
    let floomingUrl: String = "https://a32a-121-136-173-243.jp.ngrok.io/picture"
    var picutureImageUrl: String?
    let header : HTTPHeaders = ["Content-Type" : "application/json"]
    
    @IBOutlet weak var finalResultView: UIView!
    @IBOutlet weak var finalResultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
//    /picutre로 post 요청
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("포토 아이디는 \(photo_id)")
        finalResultView.clipsToBounds = true
        finalResultView.layer.cornerRadius = 30
        finalResultView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        finalResultView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
        // Do any additional setup after loading the view.
        
        AF.request(
                    floomingUrl, // [주소]
                    method: .post, // [전송 타입]
                    parameters: ["photo_id":photo_id!], // [전송 데이터]
                    encoding: JSONEncoding.default, // [인코딩 스타일]
                    headers: header // [헤더 지정]
                )
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let pictureId = json["picture_id"]
                        print("pictureid는 \(pictureId)")
                        self.picutureImageUrl = "\(self.floomingUrl)/\(pictureId)"
                        print("\(String(describing: self.picutureImageUrl))이요오오옹")
                        let urlString = self.picutureImageUrl
                        let encodedStr = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                        self.updateUI(encodedStr)
                        default:
                        return
                    }
                }
        
//        AF.request(
//            floomingUrl, // [주소]
//            method: .get, // [전송 타입]
//            parameters: [:], // [전송 데이터]
//            encoding: JSONEncoding.default, // [인코딩 스타일]
//            headers: header // [헤더 지정]
//        )
//        .validate(statusCode: 200..<300)
//        .responseData { response in
//            switch response.result {
//            case .success(let value):
//                let encodedStr = self.picutureImageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//                self.updateUI(encodedStr)
//                default:
//                return
//            }
//        }
    
        
             //finalResultImageView.image = selectedImage
    }
    
    func updateUI(_ url : String){
        
        var tempImg : UIImage?
             
        DispatchQueue.global().async {
            if let ImageData = try? Data(contentsOf: URL(string: url)!) {
                tempImg = UIImage(data: ImageData)!
            } else {
                tempImg = UIImage(named: "01.svg")!
            }
     
            DispatchQueue.main.async {
                self.finalResultImageView.image = tempImg
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

}
