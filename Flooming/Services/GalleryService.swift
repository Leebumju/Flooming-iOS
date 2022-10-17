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
    
    func createPicture(photo_id: Int, picture_id: Int, comment: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        let dataRequest = AF.request(
            APIConstants.shared.galleryURL, // [주소]
            method: .post, // [전송 타입]
            parameters: ["photo_id":photo_id ?? nil,
                         "picture_id":picture_id ?? nil,
                         "comment":comment ?? nil], // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: header // [헤더 지정]
            //------- 여기까지 수정 완료------
        )
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let result = json["result"]
                    print("result는 \(result)")
                    
                    for pageNumber in 0 ..< 5 {
                        print("pageNumber: \(pageNumber)")
                        print("result[photo_id]: \(result[pageNumber]["photo_id"])")
                        print("result[picture_id]: \(result[pageNumber]["picture_id"])")
                        
                        let data = CellData(photoId: result[pageNumber]["photo_id"].rawValue as! Int, comment: "\(result[pageNumber]["comment"].rawValue as! String)", pictureId: result[pageNumber]["picture_id"].rawValue as! Int,
                                            galleryId: result[pageNumber]["gallery_id"].rawValue as! Int)
                        
                        datas.append(data)
                    }
                    
                default:
                    return
                }
            }
  
}
