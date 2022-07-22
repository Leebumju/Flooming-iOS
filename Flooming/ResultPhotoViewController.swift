//
//  ResultPhotoViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/15/22.
//

import UIKit
import Alamofire
import simd
import SwiftyJSON
import Foundation


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
    
 
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        switchOn = selectedImage
        
        
        
        let urlString = "https://b645-121-136-173-243.jp.ngrok.io/flower/장미"
        let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        updateUI(encodedStr)
            

        resultPhotoView.clipsToBounds = true
        resultPhotoView.layer.cornerRadius = 30
        resultPhotoView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        resultPhotoView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
        // Do any additional setup after loading the view.
        
        resultPhotoImage.image = selectedImage
        
        
        let header : HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        
        AF.upload(multipartFormData: { multipartFormData in
            print("오로로로로롤ㄹ")
            // png이미지로 한번 변화해서 해보기
    
            if let image = self.switchOn!.pngData() {
                multipartFormData.append(image, withName: "file", fileName: "02.png", mimeType: "image/png")
            }
        }, to: "https://b645-121-136-173-243.jp.ngrok.io/photo", usingThreshold: UInt64.init(), method: .post, headers: header).responseJSON { response in
        
            print("이ㅏ어ㅑ더야어디ㅑ러이ㅑ러디요요")
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                let result = json["eng_name"]
                    print(result)
                    print("안녕하세요요요요요요요요")
                default:
                    return
            }
            
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
    
    
    //url로 이미지 가져오기
    func updateUI(_ url : String){
        
        var tempImg : UIImage?
             
        DispatchQueue.global().async {
            if let ImageData = try? Data(contentsOf: URL(string: url)!) {
                tempImg = UIImage(data: ImageData)!
            } else {
                tempImg = UIImage(named: "01.svg")!
            }
     
            DispatchQueue.main.async {
                self.kindOfFlowerImage.image = tempImg
            }
        }
     
    }
}

struct Flower: Codable {
    let photo_id: String
    let probability: String
    let kor_name: String
    let eng_name: String
    let flower_language: String
}

