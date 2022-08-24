//
//  UploadPhotoService.swift
//  Flooming
//
//  Created by 이범준 on 8/24/22.
//

import Foundation
import Alamofire

struct LoginDataModel: Decodable {
    let kor_name: String
    let eng_name: String
    let probability: String
    let tempPhotoId: String
    let flower_language: String
}


struct UploadPhotoService {
    // static을 활용해서 shared라는 이름으로 LoginService 싱글턴 인스턴스 선언
    static let shared = UploadPhotoService()
    
    // login 메서드: @escape 키워드를 사용해 escape closure 형태로 completion 정의
    // 해당 네트워크 작업이 끝날 때 -> completion closure에 네트워크의 결과를 담아서 호출
    func login(selectedImage: UIImage, completion: @escaping (NetworkResult<Any>) -> Void) {
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
            case .success:
                guard let statusCode = Response.response?.statusCode else {return}
                guard let value = Response.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value as! Data)
                completion(networkResult)
                
            case .failure: completion(.pathErr)
                
            }
        }
    }
    
    // 서버에서 주는 값중에서 message만 빼서 밖으로 전달
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(LoginDataModel.self, from: data)
        else { return .pathErr}
        
        switch statusCode {
        
            //kor name말고 전체를 보내고 싶으면 decodedData하면 될라나
        case 200: return .success(decodedData)
        case 400: return .requestErr(decodedData)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}


//let header : HTTPHeaders = ["Content-Type" : "multipart/form-data"]
//
//AF.upload(multipartFormData: { multipartFormData in
//    // png이미지로 한번 변화해서 해보기
//
//    if let image = self.selectedImage!.pngData() {
//        multipartFormData.append(image, withName: "file", fileName: "02.png", mimeType: "image/png")
//    }
//}, to: floomingUrl + "/photo", usingThreshold: UInt64.init(), method: .post, headers: header).responseJSON { response in
//
//    switch response.result {
//    case .success(let value):
//        let json = JSON(value)
//        let kor_name = json["kor_name"]
//        let eng_name = json["eng_name"]
//        let probability = json["probability"]
//        let tempPhotoId = json["photo_id"]
//        let flower_language = json["flower_language"]
//
//        self.urlFlowerName = kor_name.stringValue
//        let urlString = self.floomingUrl + "/flower/\(kor_name)"
//        let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//
//
//        let photo_id = tempPhotoId.rawValue as! Int
//        self.photoId = photo_id
//        let flowerKorName = kor_name.rawValue as! String
//        let flowerEngName = eng_name.rawValue as! String
//        let flowerProbability = probability.rawValue as! Int
//        let flowerLanguage = flower_language.rawValue as! String
//
//        self.flowerEnglishName.text = flowerKorName + "\"" + flowerEngName + "\""
//        self.percent.text = String(flowerProbability)
//        self.flowerMeaning.text = flowerLanguage
//
//        self.updateUI(encodedStr)
//
//    case .failure(let error):
//        self.percent.text = "오류 발생!!!"
//        let alert = UIAlertController(title:"사진을 다시 찍어주세요.",
//                                      message: "올바른 사진이 아닙니다.",
//                                      preferredStyle: UIAlertController.Style.alert)
//        //2. 확인 버튼 만들기
//        let cancle = UIAlertAction(title: "취소", style: .default) { (action) in
//            //취소 버튼 클릭시 이전 화면으로 돌아가기
//            self.navigationController?.popViewController(animated: true)
//        }
//        //3. 확인 버튼을 경고창에 추가하기
//        alert.addAction(cancle)
//        //4. 경고창 보이기
//        self.present(alert,animated: true,completion: nil)
//
//        break
//
//    default:
//        return
//    }
//
//}


//struct UploadPhotoService {
//    // static을 활용해서 shared라는 이름으로 LoginService 싱글턴 인스턴스 선언
//    static let uploadPhotoshared = UploadPhotoService()
//
//    // login 메서드: @escape 키워드를 사용해 escape closure 형태로 completion 정의
//    // 해당 네트워크 작업이 끝날 때 -> completion closure에 네트워크의 결과를 담아서 호출
//    func login(completion: @escaping (NetworkResult<Any>) -> Void) {
//        // json 형태로 받아오기 위해 header 작성 -> 필요한 헤더를 Key-Value의 형태로 작성
//        let header: HTTPHeaders = ["Content-Type": "application/json"]
//        // dataRequest: 주소를 가지고, get 방식으로, 인코딩 방식으로, 헤더 정보와 함께 요청을 보내기 위한 정보(요청서)
//        let dataRequest = AF.request(APIConstants.APIShared.loginURL,
//                                     method: .get,
//                                     encoding: JSONEncoding.default,
//                                     headers: header)
//
//        // dataRequest 요청서를 가지고 서버에 보내서 통신 request를 함 -> 결과는 dataResponse로 도착
//        dataRequest.responseData { dataResponse in
//            // dataResponse 안에는 통신에 대한 결과물이 들어있음
//            dump(dataResponse)
//            // dataResponse.result: 통신 성공했는지 실패했는지에 대한 여부
//            switch dataResponse.result {
//            case .success:
//                guard let statusCode = dataResponse.response?.statusCode else {return}
//                guard let value = dataResponse.value else {return}
//                let networkResult = self.judgeStatus(by: statusCode, value)
//                completion(networkResult)
//
//            case .failure: completion(.pathErr)
//
//            }
//        }
//    }
//
//    // 서버에서 주는 값중에서 message만 빼서 밖으로 전달
//    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
//
//        let decoder = JSONDecoder()
//
//        guard let decodedData = try? decoder.decode(LoginDataModel.self, from: data)
//        else { return .pathErr}
//
//        switch statusCode {
//
//        case 200: return .success(decodedData.message)
//        case 400: return .requestErr(decodedData.message)
//        case 500: return .serverErr
//        default: return .networkFail
//        }
//    }
//}
