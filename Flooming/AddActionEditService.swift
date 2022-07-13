//
//  AddActionEditService.swift
//  Flooming
//
//  Created by 이범준 on 7/7/22.
//

//import Foundation
//import Alamofire
//
//struct AddActionEditService {
//
//    static let shared = AddActionEditService()
//
//    func editActivity (imageData: UIImage?,
//                            content: String,
//                            year: String,
//                            month: String,
//                            day: String,
//                            index: Int,
//                            activityIndex: Int,
//                            completion: @escaping (NetworkResult<Any>) -> Void) {
//
//        let URL = "https://32f4-183-99-247-44.jp.ngrok.io/test"
//        let header : HTTPHeaders = [
//            "Content-Type" : "multipart/form-data",
//            "token" : GeneralAPI.token ]
//
//        let parameters: [String : Any] = [
//            "activityContent": content,
//            "activityYear": year,
//            "activityMonth": month,
//            "activityDay": day,
//            "characterIndex": index,
//            "activityIndex": activityIndex
//        ]
//        AF.upload(multipartFormData: { multipartFormData in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//            }
//            if let image = imageData?.pngData() {
//                multipartFormData.append(image, withName: "activityImage", fileName: "\(image).png", mimeType: "image/png")
//            }
//        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
//            guard let statusCode = response.response?.statusCode,
//                  statusCode == 200
//            else { return }
//            completion(.success(statusCode))
//        }
//    }
//}
