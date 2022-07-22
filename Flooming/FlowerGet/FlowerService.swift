//
//  FlowerService.swift
//  Flooming
//
//  Created by 이범준 on 7/21/22.
//

import Foundation
import Alamofire
//
//struct FlowerService {
//    private init() {}
//
//    //
//    static let shared = ContentService()
//    
//    //MARK: - 게시글(Article) 받아오기
//    
//    func getArticle(completion: @escaping (NetworkResult<Any>) -> Void){
//        // URL
//        let URL = (https://d9df-119-194-11-234.jp.ngrok.io)
//        // Header 값 (아마 서버마다 API마다 원하는 Header값이 달라질거에요)
//        let header: HTTPHeaders = [
//            "Content-Type" : "application/json"
//        ]
//        
//        Alamofire.request(URL, // URL 값
//        method: .get,          // GET 메소드를 지정해줘요
//        parameters: nil,       // 이 경우에는 파라미터 값이 필요가 없으니 빼서 줍니다!!
//        encoding: JSONEncoding.default, // Encoding 타입을 정해줘요
//        headers: header)       // 위에서 넣어준 헤더값을 넣어줘요
//        .responseData{ response in    // 이렇게 정해준 request값을 보내서 response값을 response에 넣어줘요
//            
//            switch response.result { // response에서의 결과값으로 switch로 나눠줄거에요
//            case .success:           // success일 경우에
//                if let status = response.response?.statusCode{ // statusCode를 가져올거에요
//                    switch status {  // 상태코드를 가지고 switch 처리를 해줘요
//                    case 200:        // 200일 경우
//                        do{          // 에러처리를 위해서 do-catch를 쓸거에요
//                            let decoder = JSONDecoder()  // JSONDecoder를 가져오고
//                            if let value = response.result.value { // value값을 가져오고
//                                let result = try decoder.decode(Article.self, from: value)
//                                // value를 Artcle 모델로 Decode 해주세요
//                            }
//                            completion(.success(result))
//                            // 여기서!!! ViewController로 보내줍니다.
//                        } catch {
//                            completion(.pathErr)
//                            // 에러가 될 경우는 일반적으로 모델이 value에 맞지 않는 경우 납니다.
//                        }   // 이제 에러 처리를 해주면 되요 ~~~
//                    case 400:
//                        print("실패 400")
//                        completion(.pathErr)
//                    case 500:
//                        print("실패 500")
//                        completion(.serverErr)
//                    default:
//                        break
//                    }
//                }
//            }
//            case .failure(let err):
//                print(err.localizedDescription)
//                completion(.networkFail)
//                
//            }
//            
//        }
//        
//    }
//
//}
