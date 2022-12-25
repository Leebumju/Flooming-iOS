//
//  GalleryService.swift
//  Flooming
//
//  Created by 이범준 on 10/17/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GalleryService {
    static let shared = GalleryService()
    func gallery(photo_id: Int, picture_id: Int, comment: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        let dataRequest = AF.request(
            APIConstants.shared.galleryURL, // [주소]
            method: .post, // [전송 타입]
            parameters: ["photo_id":photo_id,
                         "picture_id":picture_id,
                         "comment":comment], // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: header // [헤더 지정]
        )
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    guard let statusCode = response.response?.statusCode else {return}
                    guard let value = response.value else {return}
                    let networkResult = judgeStatus(by: statusCode, json)
                    completion(networkResult)
                case .failure: completion(.pathErr)
                }
            }
    }
}
