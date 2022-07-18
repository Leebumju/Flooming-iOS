//
//  ResultPhotoViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/15/22.
//

import UIKit
import Alamofire
import simd


class ResultPhotoViewController: UIViewController {

    var selectedImage: UIImage!
    var switchOn: UIImage = UIImage(named: "01.svg")!
    
    @IBOutlet weak var resultPhotoView: UIView!
    @IBOutlet weak var resultPhotoImage: UIImageView!
    @IBOutlet weak var kindOfFlowerImage: UIImageView!
    
    @IBOutlet weak var flowerName: UILabel!
    @IBOutlet weak var flowerMeaning: UILabel!
    @IBOutlet weak var percent: UILabel!
    
    
    
    override func viewDidLoad() {
//        AF.request("https://38e3-183-99-247-44.jp.ngrok.io/photo", method: .post, parameters: [:], encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
//                    .responseJSON { (response) in}
//
//        var file: String
        
        let header : HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        AF.upload(multipartFormData: { multipartFormData in
            print("오로로로로롤ㄹ")
            // png이미지로 한번 변화해서 해보기
            if let image = self.switchOn.pngData() {
                multipartFormData.append(image, withName: "file", fileName: "01.png", mimeType: "image/png")
            }
        }, to: "https://38e3-183-99-247-44.jp.ngrok.io/photo", usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
            guard let statusCode = response.response?.statusCode,
                    statusCode == 200
            else { return }
            //completion(.success(statusCode))
        }
        
        super.viewDidLoad()
        resultPhotoView.clipsToBounds = true
        resultPhotoView.layer.cornerRadius = 30
        resultPhotoView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        resultPhotoView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
        // Do any additional setup after loading the view.
        
        resultPhotoImage.image = selectedImage
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
            //가고자 하는 VC가 맞는지 확인해줍니다.
        guard let nextVC = destination as? FinalResultViewController else {
            return
        }
        
        nextVC.selectedImage = kindOfFlowerImage.image
    }
}
