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
    var cellDatas: [CellData] = [] // 셀에 표시될 데이터 리스트
    var baseUrl = "http://flooming.link/gallery?page="
    let floomingUrl: String = "http://flooming.link/picture"

    
    @IBAction func homeButton(_ sender: Any) {
        print("클릭되었음.")
        self.navigationController?.popToRootViewController(animated: true)
    }
  
    var pictureImageUrl: String?
      
    
    
    
    
    var isPaging: Bool = false // 현재 페이징 중인지 체크하는 flag
    var hasNextPage: Bool = false // 마지막 페이지 인지 체크 하는 flag
    
    let header : HTTPHeaders = ["Content-Type" : "application/json"]
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
       
        self.tableView.rowHeight = 350;
        
        
        settingBackground(view: galleryView)
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
    var cellImage: UIImage?
    var photo: UIImage?
    
    
    var cellDatas: [CellData] = [] // 셀에 표시될 데이터 리스트
    
    //---------------------------------------------------
    @IBAction func downloadButton(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(galleryImage.image!, self, #selector(saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error { //사진 저장 에러
            print(error)
        } else {
            print("Save")
        }
    }
}

extension MyCell {
    //----------------------------------------
    //cell에 url 줘서 그걸 변환하게 해보자
    func transferImageByUrl(pictureEncodedUrl: UIImage, photoImage: UIImage) {
//        self.galleryImage.image = pictureEncodedUrl
        self.galleryImage.image = pictureEncodedUrl
        cellImage = pictureEncodedUrl
        photo = photoImage
    }
    
    
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        // 만일 제스쳐가 있다면
            if let swipeGesture = gesture as? UISwipeGestureRecognizer{
                // 발생한 이벤트가 각 방향의 스와이프 이벤트라면
                // pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imageView에 할당
                switch swipeGesture.direction {
                    case UISwipeGestureRecognizer.Direction.left :
                    print("왼쪽")
                    pageControl.currentPage -= 1
                    self.galleryImage.image = photo
//                    print(galleryImage.image!)
                    print("바뀜")
                    case UISwipeGestureRecognizer.Direction.right :
                    print("오른쪽")
                    pageControl.currentPage += 1
                    self.galleryImage.image = UIImage(named: "download.jpeg")!
//                    print(galleryImage.image!)
                    default:
                      break
                }

            }

        }
        
        // 두 손가락 스와이프 제스쳐를 행했을 때 실행할 액션 메서드
        @objc func respondToSwipeGestureMulti(_ gesture: UIGestureRecognizer) {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                print("siballl")
                switch swipeGesture.direction {
                   case UISwipeGestureRecognizer.Direction.left:
                        pageControl.currentPage -= 1
                        galleryImage.image = UIImage(named: "logoImage")
                   case UISwipeGestureRecognizer.Direction.right:
                        pageControl.currentPage += 1
                        galleryImage.image = UIImage(named: "HomeButton")
                   default:
                       break
                }
            }
        }
    //----------------------------------------
    
}

class LoadingCell: UITableViewCell {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func start() {
        activityIndicatorView.startAnimating()
    }
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
            cell.pageControl.numberOfPages = 2
            cell.pageControl.currentPage = 0
            let data = cellDatas[indexPath.row]
              
            let pictureUrlString = "\(self.floomingUrl)/\(data.pictureId)"
            let photoUrlString = "\(self.floomingUrl)/\(data.photoId)"
            
            let pictureEncodeStr = pictureUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let photoEncodeStr = photoUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            var pictureImage : UIImage?
            var photoImage: UIImage?

            //background 큐에서 비동기 방식으로 실행할 코드
            DispatchQueue.global().async {
                if let ImageData = try? Data(contentsOf: URL(string: pictureEncodeStr)!) {
                    pictureImage = UIImage(data: ImageData)!
                } else {
                    pictureImage = UIImage(named: "FirstOnBoarding.jpeg")!
                }
                
                if let ImageData = try? Data(contentsOf: URL(string: photoEncodeStr)!) {
                    photoImage = UIImage(data: ImageData)!
                } else {
                    photoImage = UIImage(named: "FirstOnBoarding.jpeg")!
                }
                
//                cell.transferImageByUrl(pictureEncodedUrl: pictureImage!)
            
            
                //main 큐에서 비동기 방식으로 실행할 코드
                DispatchQueue.main.async {
//                    cell.galleryImage.image = pictureImage
                    cell.transferImageByUrl(pictureEncodedUrl: pictureImage!, photoImage: photoImage!)
                    //------------------------------------------
                    let swipeLeft = UISwipeGestureRecognizer(target: cell, action: #selector(cell.respondToSwipeGesture(_:)))
                            swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
                            self.view.addGestureRecognizer(swipeLeft)

                            let swipeRight = UISwipeGestureRecognizer(target: cell, action: #selector(cell.respondToSwipeGesture(_:)))
                            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
                            self.view.addGestureRecognizer(swipeRight)

                            // 두 손가락 스와이프 제스쳐 등록(좌, 우)
                            let swipeLeftMulti = UISwipeGestureRecognizer(target: cell, action: #selector(cell.respondToSwipeGestureMulti(_:)))
                            swipeLeftMulti.direction = UISwipeGestureRecognizer.Direction.left
                    swipeLeftMulti.numberOfTouchesRequired = self.numOfTouchs
                            self.view.addGestureRecognizer(swipeLeftMulti)

                            let swipeRightMulti = UISwipeGestureRecognizer(target: cell, action: #selector(cell.respondToSwipeGestureMulti(_:)))
                            swipeRightMulti.direction = UISwipeGestureRecognizer.Direction.right
                    swipeRightMulti.numberOfTouchesRequired = self.numOfTouchs
                            self.view.addGestureRecognizer(swipeRightMulti)
                    
                    //------------------------------------------
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



struct CellData {
    var photoId: Int
    var comment: String
    var pictureId: Int
}
