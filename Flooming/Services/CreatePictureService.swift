//
//  CreatePictureService.swift
//  Flooming
//
//  Created by 이범준 on 8/24/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CreatePictureService {
    
    static let shared = CreatePictureService()
    
    func createPicture(photo_id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        let dataRequest = AF.request(
            APIConstants.shared.pictureURL, // [주소]
            method: .post, // [전송 타입]
            parameters: ["photo_id":photo_id], // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: header // [헤더 지정]
        )
            .responseData { response in
                dump(response)
                // dataResponse.result: 통신 성공했는지 실패했는지에 대한 여부
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
