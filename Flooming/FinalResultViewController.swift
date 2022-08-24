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
import Toast_Swift

class FinalResultViewController: UIViewController {
    
    var selectedImage: UIImage!
    var photo_id: Int?
    var nextpictureId: Int?
    
    let pictureURL: String = APIConstants.shared.baseURL + "/picture"
    var pictureImageUrl: String?
    let header : HTTPHeaders = ["Content-Type" : "application/json"]
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var finalResultView: UIView!
    @IBOutlet weak var finalResultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBAction func clickDownloadButton(_ sender: Any) {
        let alert = UIAlertController(title:"사진 다운로드",
                                      message: "사진을 다운로드 할까요?",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let check = UIAlertAction(title: "확인", style: .default) { (action) in
            UIImageWriteToSavedPhotosAlbum(self.finalResultImageView.image!, self, #selector(self.saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
            self.view.makeToast("사진이 다운로드 되었습니다.", duration: 1.0, position: .bottom)
        }
        
        alert.addAction(cancel)
        alert.addAction(check)
        self.present(alert,animated: true,completion: nil)
    }
    
    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error { //사진 저장 에러
            print(error)
        } else {
            print("Save")
        }
    }
    //    /picutre로 post 요청
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextField.backgroundColor = UIColor.clear
        commentTextField.attributedPlaceholder = NSAttributedString(string: "남기시고 싶은 말이 있나요?", attributes: [.foregroundColor: UIColor.white])
        
        
        print("포토 아이디는 \(photo_id)")
        settingBackground(view: finalResultView)
        updateImageBorder(image: finalResultImageView)
        
        AF.request(
            pictureURL, // [주소]
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
                    print("pictureid: \(pictureId)")
                    self.pictureImageUrl = "\(self.pictureURL)/\(pictureId)"
                    print("pictureImageURL은 \(String(describing: self.pictureImageUrl))")
                    let urlString = self.pictureImageUrl
                    let encodedStr = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    updateImageFromUrl(encodedStr: encodedStr, imageView: self.finalResultImageView)
                default:
                    return
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

