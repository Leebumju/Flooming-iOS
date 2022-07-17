//
//  GalleryTableViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/14/22.
//

import UIKit
import Alamofire

class GalleryTableViewController: UIViewController {
    
    @IBOutlet var galleryView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
//    var result: Array<CellData> = []
    
    var result: Result?

    
    
    var baseURL = "https://8a7b-117-17-163-58.jp.ngrok.io"
        
    var cellDatas: [CellData] = [] // 셀에 표시될 데이터 리스트
    
    var isPaging: Bool = false // 현재 페이징 중인지 체크하는 flag
    var hasNextPage: Bool = false // 마지막 페이지 인지 체크 하는 flag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 350;
        
        galleryView.clipsToBounds = true
        galleryView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        galleryView.backgroundColor = UIColor(patternImage: UIImage(named: "galleryBackground.png")!)
        self.tableView.backgroundColor = UIColor.clear
        
        AF.request(baseURL + "/gallery", method: .get, parameters: ["page":0], encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"])
                    .validate(statusCode: 200..<300)
                    .responseJSON { (response) in}
        
//        AF.request(baseURL + "/gallery", method: .get, parameters: ["page":0]).responseJSON { response in
//            //여기서 가져온 데이터를 사용
////            print("response: \(response)")
////
////              switch response.result {
//        case .success(let value):
//            print(String(data: value, encoding: .utf8)!)
//            completion(try? SomeRequest(protobuf: value))
//        case .failure(let error):
//            print(error)
//            completion(nil)
//        }
//
//        }.resume()
//
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            paging()
        }
        
        func paging() {
            let index = cellDatas.count
            
            var datas: [CellData] = []
            
            for i in index..<(index + 5) {
                let data = CellData(comment: "Title\(i)")
            
                datas.append(data)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.cellDatas.append(contentsOf: datas) // 데이터는 계속해서 append 시켜줌 (페이징의 핵심!)
                
                self.hasNextPage = self.cellDatas.count > 300 ? false : true // 다음 페이지가 있는지 여부를 표시
                self.isPaging = false // 페이징이 종료 되었음을 표시
                
                self.tableView.reloadData()
            }
        }
}

// /gallery?page
class MyCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var dateLabel: UILabel!
}

class LoadingCell: UITableViewCell {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func start() {
        activityIndicatorView.startAnimating()
    }
}

struct CellData {
    //var photo_src: String
    var comment: String
    //var picture_src: String
}


extension GalleryTableViewController: UITableViewDelegate, UITableViewDataSource {
    // Section을 2개 설정하는 이유는 페이징 로딩 시 로딩 셀을 표시해주기 위해서입니다.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cellDatas.count
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? MyCell else {
                return UITableViewCell()
            }
            
            let data = cellDatas[indexPath.row]
            
           
            cell.titleLabel.text = "a"
            // 테이블뷰 선택 색상없애기
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell else {
                return UITableViewCell()
            }
            
            cell.start()
            
            return cell
        }
    }
}


extension GalleryTableViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
        if offsetY > (contentHeight - height) {
            if isPaging == false && hasNextPage {
                beginPaging()
            }
        }
    }
    
    func beginPaging() {
        isPaging = true // 현재 페이징이 진행 되는 것을 표시
        // Section 1을 reload하여 로딩 셀을 보여줌 (페이징 진행 중인 것을 확인할 수 있도록)
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        
        // 페이징 메소드 호출
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.paging()
        }
    }
}


struct Gallery: Codable {
    var comment: String?
    var photo_src: String?
    var picture_src: String?
}

struct Result: Codable {
    var Gallery: [Gallery]?
}
