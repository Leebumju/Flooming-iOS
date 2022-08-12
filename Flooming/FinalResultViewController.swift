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
    var nextpictureId: Int?
    
    let floomingUrl: String = "http://flooming.link/picture"
    var pictureImageUrl: String?
    let header : HTTPHeaders = ["Content-Type" : "application/json"]
    
    
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var finalResultView: UIView!
    @IBOutlet weak var finalResultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
//    /picutre로 post 요청
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextField.backgroundColor = UIColor.clear
        commentTextField.attributedPlaceholder = NSAttributedString(string: "남기시고 싶은 말이 있나요?", attributes: [.foregroundColor: UIColor.white])

        
        print("포토 아이디는 \(photo_id)")
        settingBackground(view: finalResultView)
        updateImageBorder(image: finalResultImageView)
        
        AF.request(
                    floomingUrl, // [주소]
                    method: .post, // [전송 타입]
                    parameters: ["photo_id":photo_id], // [전송 데이터]
                    encoding: JSONEncoding.default, // [인코딩 스타일]
                    headers: header // [헤더 지정]
                )
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let pictureId = json["picture_id"]
                        self.nextpictureId = pictureId.rawValue as! Int
                        print("pictureid는 \(pictureId)")
                        self.pictureImageUrl = "\(self.floomingUrl)/\(pictureId)"
                        print("아아아아ㅏ아아아ㅏ아아ㅏ아\(String(describing: self.pictureImageUrl))")
                        let urlString = self.pictureImageUrl
                        let encodedStr = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                        self.updateUI(encodedStr)
                        default:
                        return
                    }
                }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
            //가고자 하는 VC가 맞는지 확인해줍니다.
        guard let nextVC = destination as? GalleryTableViewController else {
            return
        }
        
        nextVC.photo_id = self.photo_id
        nextVC.picture_id = self.nextpictureId
        nextVC.comment = self.commentTextField.text
        
        print("남긴 말은:\(commentTextField.text)")
//        nextVC.comment = self.comment
    }

}
