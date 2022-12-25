//
//  UploadPhotoService.swift
//  Flooming
//
//  Created by 이범준 on 8/24/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct UploadPhotoService {
    // static을 활용해서 shared라는 이름으로 LoginService 싱글턴 인스턴스 선언
    static let shared = UploadPhotoService()
    // login 메서드: @escape 키워드를 사용해 escape closure 형태로 completion 정의
    // 해당 네트워크 작업이 끝날 때 -> completion closure에 네트워크의 결과를 담아서 호출
    func updatePhoto(selectedImage: UIImage, completion: @escaping (NetworkResult<Any>) -> Void) {
        // json 형태로 받아오기 위해 header 작성 -> 필요한 헤더를 Key-Value의 형태로 작성
        let header : HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        // dataRequest: 주소를 가지고, get 방식으로, 인코딩 방식으로, 헤더 정보와 함께 요청을 보내기 위한 정보(요청서)
        let dataRequest = AF.upload(multipartFormData: { multipartFormData in
            // png이미지로 한번 변화해서 해보기
            if let image = selectedImage.pngData() {
                multipartFormData.append(image, withName: "file", fileName: "02.png", mimeType: "image/png")
            }
        }, to: APIConstants.shared.baseURL + "/photo", usingThreshold: UInt64.init(), method: .post, headers: header).responseJSON
        { Response in
            // dataResponse 안에는 통신에 대한 결과물이 들어있음
            dump(Response)
            // dataResponse.result: 통신 성공했는지 실패했는지에 대한 여부
            switch Response.result {
            case .success(let value):
                let json = JSON(value)
                guard let statusCode = Response.response?.statusCode else {return}
                let networkResult = judgeStatus(by: statusCode, json)
                completion(networkResult)
            case .failure: completion(.pathErr)
            }
        }
    }
}

// 서버에서 주는 값중에서 message만 빼서 밖으로 전달
func judgeStatus(by statusCode: Int, _ json: JSON) -> NetworkResult<Any> {
    let decodedData = json
    switch statusCode {
    // kor name말고 전체를 보내고 싶으면 decodedData하면 될라나
    case 200: return .success(decodedData)
    case 400: return .requestErr(decodedData)
    case 500: return .serverErr
    default: return .networkFail 
    }
}
