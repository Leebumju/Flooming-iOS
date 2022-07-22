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
    // 여기서 
    var switchOn: UIImage?
    
    @IBOutlet weak var resultPhotoView: UIView!
    @IBOutlet weak var resultPhotoImage: UIImageView!
    @IBOutlet weak var kindOfFlowerImage: UIImageView!
    
    @IBOutlet weak var flowerName: UILabel!
    @IBOutlet weak var flowerMeaning: UILabel!
    @IBOutlet weak var percent: UILabel!
    
//    "photo_id": db_photo.photo_id,
//            "probability": result["probability"],
//            "kor_name": flower.kor_name,
//            "eng_name": flower.eng_name,
//            "flower_language": flower.flower_language

    var photo_id: String = ""
    var probability: String = ""
    var kor_name: String = ""
    var eng_name: String = ""
    var flower_language: String = ""
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        switchOn = selectedImage
        
        let header : HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        let url = URL(string: "http://flooming.link/flower/test")
            do
            {
                let data = try Data(contentsOf: url!)
                kindOfFlowerImage.image = UIImage(data: data)
            }
            catch
            {

            }

        resultPhotoView.clipsToBounds = true
        resultPhotoView.layer.cornerRadius = 30
        resultPhotoView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        resultPhotoView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
        // Do any additional setup after loading the view.
        
        resultPhotoImage.image = selectedImage
        
        AF.upload(multipartFormData: { multipartFormData in
            print("오로로로로롤ㄹ")
            // png이미지로 한번 변화해서 해보기
    
            if let image = self.switchOn!.pngData() {
                multipartFormData.append(image, withName: "file", fileName: "02.png", mimeType: "image/png")
            }
        }, to: "https://b645-121-136-173-243.jp.ngrok.io/photo", usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
           
            guard let statusCode = response.response?.statusCode,
                  statusCode == 200
                  
            else { return }
            
            //completion(.success(statusCode))
        }
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


