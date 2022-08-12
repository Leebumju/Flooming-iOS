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
    
    private let loadingView: CustomLoadingView = {
        let view = CustomLoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        switchOn = selectedImage
        self.resultPhotoView.addSubview(self.loadingView)
        
        NSLayoutConstraint.activate([
              self.loadingView.leftAnchor.constraint(equalTo: self.resultPhotoView.leftAnchor),
              self.loadingView.rightAnchor.constraint(equalTo: self.resultPhotoView.rightAnchor),
              self.loadingView.bottomAnchor.constraint(equalTo: self.resultPhotoView.bottomAnchor),
              self.loadingView.topAnchor.constraint(equalTo: self.resultPhotoView.topAnchor),
        ])
        
        settingBackground(view: resultPhotoView)
        // Do any additional setup after loading the view.
        
        resultPhotoImage.image = selectedImage
        
        //ImageView 경계선 설정 및 굵기 조정
        updateImageBorder(image: resultPhotoImage)
        updateImageBorder(image: kindOfFlowerImage)
        
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
                
            case .failure(let error):
                self.percent.text = "오류 발생!!!"
                let alert = UIAlertController(title:"사진을 다시 찍어주세요.",
                    message: "올바른 사진이 아닙니다.",
                    preferredStyle: UIAlertController.Style.alert)
                //2. 확인 버튼 만들기
                let cancle = UIAlertAction(title: "취소", style: .default) { (action) in
                    //취소 버튼 클릭시 이전 화면으로 돌아가기
                    self.navigationController?.popViewController(animated: true)
                }
                //3. 확인 버튼을 경고창에 추가하기
                alert.addAction(cancle)
                //4. 경고창 보이기
                self.present(alert,animated: true,completion: nil)
                
                break
                
            default:
                return
            }
            
        }
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadingView.isLoading = false
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

