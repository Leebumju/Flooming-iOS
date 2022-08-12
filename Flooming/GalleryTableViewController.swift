//
//  GalleryTableViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/14/22.
//

import UIKit
import Alamofire
import simd
import SwiftyJSON
import Foundation

class GalleryTableViewController: UIViewController {
    
    //finalResultViewController에서 받아오는 변수들
    var photo_id: Int?
    var comment: String?
    var picture_id: Int?
    
    
    @IBOutlet var galleryView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var pageNum = 0
    
    var photoIdArray: Array<Int> = []
    var pictureIdArray: Array<Int> = []
    var commentArray: Array<String> = []
    
// page control 관련 변수
    let numOfTouchs = 2
    
    var baseUrl = "http://flooming.link/gallery?page="
    let floomingUrl: String = "http://flooming.link/picture"

    
    var pictureImageUrl: String?
   // let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
    var cellDatas: [CellData] = [] // 셀에 표시될 데이터 리스트
    var isPaging: Bool = false // 현재 페이징 중인지 체크하는 flag
    var hasNextPage: Bool = false // 마지막 페이지 인지 체크 하는 flag
    
    let header : HTTPHeaders = ["Content-Type" : "application/json"]
    
    
    private let loadingView: CustomLoadingView = {
        let view = CustomLoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.galleryView.backgroundColor = .white
        self.galleryView.addSubview(self.loadingView)
        
        NSLayoutConstraint.activate([
              self.loadingView.leftAnchor.constraint(equalTo: self.tableView.leftAnchor),
              self.loadingView.rightAnchor.constraint(equalTo: self.tableView.rightAnchor),
              self.loadingView.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor),
              self.loadingView.topAnchor.constraint(equalTo: self.tableView.topAnchor),
            ])
        
        self.loadingView.isLoading = true
       
        self.tableView.rowHeight = 350;
        
        
        settingBackground(view: galleryView)
//        galleryView.clipsToBounds = true
//        galleryView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
//        galleryView.backgroundColor = UIColor(patternImage: UIImage(named: "galleryBackground.png")!)
        self.tableView.backgroundColor = UIColor.clear
        var datas: [CellData] = []
        
        let pageUrl = ("\(baseUrl)\(String(pageNum))")
        AF.request(
                    "http://flooming.link/gallery", // [주소]
                    method: .post, // [전송 타입]
                    parameters: ["photo_id":photo_id ?? nil,
                                 "picture_id":picture_id ?? nil,
                                 "comment":comment ?? nil], // [전송 데이터]
                    encoding: JSONEncoding.default, // [인코딩 스타일]
                    headers: header // [헤더 지정]
                )
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["result"]
                        print("result는 \(result)")
                        
                        for pageNumber in 0 ..< 5 {
                            //let data = CellData(comment: "Title\(pageNumber)")

                            print("pageNumber: \(pageNumber)")
//                                print(PhotoArray.photoIdArray.count)
                            
                            print("result[photo_id]: \(result[pageNumber]["photo_id"])")
                         
                            print("result[picture_id]: \(result[pageNumber]["picture_id"])")
                                   
        
                            let data = CellData(photoId: result[pageNumber]["photo_id"].rawValue as! Int, comment: "\(result[pageNumber]["comment"].rawValue as! String)", pictureId: result[pageNumber]["picture_id"].rawValue as! Int)

                            datas.append(data)
                            
                        }
                        
                    
                    default:
                        return
                    }
                }
        
        
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //로딩뷰 없애기
        self.loadingView.isLoading = false
        
        paging()
    }

    
        func paging() {
            
            var datas: [CellData] = []
            
            let pageUrl = ("\(baseUrl)\(String(pageNum))")
            
            print(pageUrl)
            
            AF.request(
                        pageUrl, // [주소]
                        method: .get, // [전송 타입]
                        parameters: [:] // [전송 데이터]
                    )
                    .validate(statusCode: 200..<300)
                    .responseData { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            let result = json["result"]

                            print(result)
                            
                            for pageNumber in 0 ..< 5 {
                                //let data = CellData(comment: "Title\(pageNumber)")

                                print("pageNumber: \(pageNumber)")
//                                print(PhotoArray.photoIdArray.count)
                                
                                print("result[photo_id]: \(result[pageNumber]["photo_id"])")
                             
                                print("result[picture_id]: \(result[pageNumber]["picture_id"])")
                                       
            
                                let data = CellData(photoId: result[pageNumber]["photo_id"].rawValue as! Int, comment: "\(result[pageNumber]["comment"].rawValue as! String)", pictureId: result[pageNumber]["picture_id"].rawValue as! Int)

                                datas.append(data)
                            }
                            
                        
                        default:
                            return
                        }
                    }
            
                
            pageNum = pageNum + 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.cellDatas.append(contentsOf: datas) // 데이터는 계속해서 append 시켜줌 (페이징의 핵심!)
                
                self.hasNextPage = self.cellDatas.count > 35 ? false : true // 다음 페이지가 있는지 여부를 표시
                self.isPaging = false // 페이징이 종료 되었음을 표시
                
                self.tableView.reloadData()
            }
        }
    
    
    
    
    
}

// /gallery?page
class MyCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var galleryImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //---------------------------------------------------
    let urlString = "http://flooming.link/picture/1"
//    let encodedStr = self.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    @IBAction func downloadButton(_ sender: Any) {
        imageDownload(url: URL(string: urlString)!)
    }
    //--------------------------------------------------
    
    
    
    override func awakeFromNib() {
            super.awakeFromNib()

            // pageControl
            pageControl.numberOfPages = 2
            pageControl.currentPage = 0
            pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
            pageControl.currentPageIndicatorTintColor = UIColor(named: "7A7BDA")
            pageControl.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let page = Int(targetContentOffset.pointee.x / self.frame.width)
            self.pageControl.currentPage = page
          }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            let width = scrollView.bounds.size.width
            let x = scrollView.contentOffset.x + (width/2)
            let newPage = Int(x/width)
            
            if pageControl.currentPage != newPage {
                pageControl.currentPage = newPage
            }
        }
    
    func imageDownload(url: URL) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    print("Download image fail : \(url)")
                    return
            }

            DispatchQueue.main.async() {[weak self] in
                print("Download image success \(url)")
            }
        }.resume()
    }
}

class LoadingCell: UITableViewCell {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func start() {
        activityIndicatorView.startAnimating()
    }
}

struct CellData {
    var photoId: Int
    var comment: String
    var pictureId: Int
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
              
            self.pictureImageUrl = "\(self.floomingUrl)/\(data.pictureId)"
            print("그림 이미지:\(String(describing: self.pictureImageUrl))")
            let urlString = self.pictureImageUrl
            let encodedStr = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            var tempImg : UIImage?
            
            
            DispatchQueue.global().async {
                if let ImageData = try? Data(contentsOf: URL(string: encodedStr)!) {
                    tempImg = UIImage(data: ImageData)!
                } else {
                    tempImg = UIImage(named: "03.svg")!
                }
            
                DispatchQueue.main.async {
                    cell.galleryImage.image = tempImg
                }
            }
        
            cell.titleLabel.text = data.comment
        
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell else {
                return UITableViewCell()
            }
            
            cell.start()
            
            return cell
        }
    }
    
//    func updateUI(_ url : String, cell: MyCell){
//
//        var tempImg : UIImage?
//
//        DispatchQueue.global().async {
//            if let ImageData = try? Data(contentsOf: URL(string: url)!) {
//                tempImg = UIImage(data: ImageData)!
//            } else {
//                tempImg = UIImage(named: "03.svg")!
//            }
//
//            DispatchQueue.main.async {
//                cell.galleryImage.image = tempImg
//            }
//        }
//
//    }
    
    
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



