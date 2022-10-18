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
    
    var selectedImage: UIImage?
    var urlFlowerName: String?
    var photoId: Int?
    
    @IBOutlet weak var resultPhotoView: UIView!
    @IBOutlet weak var resultPhotoImage: UIImageView!
    @IBOutlet weak var kindOfFlowerImage: UIImageView!
    
    @IBOutlet weak var flowerEnglishName: UILabel!
    @IBOutlet weak var flowerMeaning: UILabel!
    @IBOutlet weak var percent: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgbaColorFromHex(rgb: 0x250B77, alpha: 1.0)
        
    
        settingBackground(view: resultPhotoView)
        
        //ImageView 경계선 설정 및 굵기 조정
        updateImageClearBorder(image: resultPhotoImage)
        updateImageClearBorder(image: kindOfFlowerImage)
        
        
        resultPhotoImage.image = selectedImage
        //공용 인스턴스에 있는 통신하는 메서드를 호출해서 받은 데이터를 실질적으로 가공하는 함수
        uploadPhoto(image: selectedImage!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        //가고자 하는 VC가 맞는지 확인해줍니다.
        guard let nextVC = destination as? FinalResultViewController else {
            return
        }
        
        nextVC.photo_id = self.photoId
    }
    
    func uploadPhoto(image: UIImage) {
        UploadPhotoService.shared.updatePhoto(selectedImage: image) { result in
            switch result {
            case .success(let value):
                print("value값은: \(value)")
                let json = JSON(value)
                print("success - ", json["kor_name"])
                let kor_name = json["kor_name"]
                let eng_name = json["eng_name"]
                let probability = json["probability"]
                let tempPhotoId = json["photo_id"]
                let flower_language = json["flower_language"]
                print(kor_name)
                self.urlFlowerName = kor_name.stringValue
                let urlString = APIConstants.shared.flowerURL+"/\(kor_name)"
                print(urlString)
                let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                
                let photo_id = tempPhotoId.rawValue as! Int
                let flowerKorName = kor_name.rawValue as! String
                let flowerEngName = eng_name.rawValue as! String
                let flowerProbability = probability.rawValue as! Int
                let flowerLanguage = flower_language.rawValue as! String
                
                self.photoId = photo_id
                self.flowerEnglishName.text = flowerKorName + "[" + flowerEngName + "]"
                self.percent.text = String(flowerProbability)
                self.flowerMeaning.text = flowerLanguage
                //이미지 업데이트 함수 호출
                updateImageFromUrl(encodedStr: encodedStr, imageView: self.kindOfFlowerImage)
            case .requestErr(let message):
                print("requestErr")
                self.percent.text = "오류 발생!!!"
                showAlert(viewController: self, title: "사진을 다시 찍어주세요", message: "올바른 사진이 아닙니다")
                break
            case .pathErr:
                print("pathErr")
                self.percent.text = "오류 발생!!!"
                showAlert(viewController: self, title: "사진을 다시 찍어주세요", message: "올바른 사진이 아닙니다")
                break
            case .serverErr:
                print("serverErr")
                showAlert(viewController: self, title: "현재 서비스를 이용할 수 없어요", message: "이용에 불편을 끼쳐 드려 죄송합니다")
            case .networkFail:
                print("networkFail")
                showAlert(viewController: self, title: "네트워크 불안정", message: "네트워크를 확인해 주세요.")
            }
        }
    }
}

