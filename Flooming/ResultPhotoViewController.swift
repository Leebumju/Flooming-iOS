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
    var urlFlowerName: String?
    
    var photoId: Int?
    
    
    let floomingUrl: String = "http://flooming.link"
    
    @IBOutlet weak var resultPhotoView: UIView!
    @IBOutlet weak var resultPhotoImage: UIImageView!
    @IBOutlet weak var kindOfFlowerImage: UIImageView!
    
    @IBOutlet weak var flowerEnglishName: UILabel!
    @IBOutlet weak var flowerMeaning: UILabel!
    @IBOutlet weak var percent: UILabel!
    
 
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        switchOn = selectedImage
        
 
        resultPhotoView.clipsToBounds = true
        resultPhotoView.layer.cornerRadius = 30
        resultPhotoView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        resultPhotoView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
        // Do any additional setup after loading the view.
        
        resultPhotoImage.image = selectedImage
        
        
        let header : HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        
        AF.upload(multipartFormData: { multipartFormData in
            // png이미지로 한번 변화해서 해보기
    
            if let image = self.switchOn!.pngData() {
                multipartFormData.append(image, withName: "file", fileName: "02.png", mimeType: "image/png")
            }
        }, to: floomingUrl + "/photo", usingThreshold: UInt64.init(), method: .post, headers: header).responseJSON { response in
        
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                let kor_name = json["kor_name"]
                let eng_name = json["eng_name"]
                let probability = json["probability"]
                let tempPhotoId = json["photo_id"]
                let flower_language = json["flower_language"]
                    print(kor_name)
                self.urlFlowerName = kor_name.stringValue
                let urlString = self.floomingUrl + "/flower/\(kor_name)"
                let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                
                print(self.floomingUrl + "/photo")
                
                let photo_id = tempPhotoId.rawValue as! Int
                self.photoId = photo_id
                let flowerKorName = kor_name.rawValue as! String
                let flowerEngName = eng_name.rawValue as! String
                let flowerProbability = probability.rawValue as! Int
                let flowerLanguage = flower_language.rawValue as! String
                
                self.flowerEnglishName.text = flowerKorName + "\"" + flowerEngName + "\""
                self.percent.text = String(flowerProbability)
                self.flowerMeaning.text = flowerLanguage
                
                self.updateUI(encodedStr)
                
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
        
        nextVC.photo_id = self.photoId
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

