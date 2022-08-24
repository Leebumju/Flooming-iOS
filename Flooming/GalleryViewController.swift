//
//  GalleryViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/7/22.
//

//import UIKit
//import Mantis
//import Alamofire
//import simd
//
//class GalleryViewController: UIViewController {
//
//    var tapCount: Int = 0
//    var switchOn: UIImage = UIImage(named: "08.svg")!
//    var switchOff: UIImage = UIImage(named: "03.svg")!
//    
//    @IBOutlet var galleryView: UIView!
//    @IBOutlet weak var galleryImageView: UIImageView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        galleryImageView.tag = 1004
//            //클릭 가능하도록 설정
//        self.galleryImageView.image = switchOn
//        self.galleryImageView.isUserInteractionEnabled = true
//            //제쳐스 추가
//        self.galleryImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
//        // Do any additional setup after loading the view.
//        galleryView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
//    }
//    
//    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
//        print("\(sender.view!.tag) 클릭됨")
//        
//        AF.request("https://32f4-183-99-247-44.jp.ngrok.io/test", method: .get, parameters: [:], encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"])
//                    .validate(statusCode: 200..<300)
//                    .responseJSON { (response) in}
//        
//        var file: String
//        
//        let header : HTTPHeaders = [
//                    "Content-Type" : "multipart/form-data"]
//        
//        AF.upload(multipartFormData: { multipartFormData in
//                    if let image = self.switchOn.pngData() {
//                        multipartFormData.append(image, withName: "file", fileName: "01.png", mimeType: "image/png")
//                    }
//                }, to: "https://b645-121-136-173-243.jp.ngrok.io/photo", usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
//                    guard let statusCode = response.response?.statusCode,
//                          statusCode == 200
//                    else { return }
//                    //completion(.success(statusCode))
//                }
//        
//        if tapCount % 2 == 0 {
//            galleryImageView.image = switchOn
//        } else {
//            galleryImageView.image = switchOff
//        }
//        tapCount = tapCount + 1
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
