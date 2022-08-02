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
    
    @IBOutlet var galleryView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var pageNum = 0
    
    
    var photoIdArray: Array<Int> = []
    var pictureIdArray: Array<Int> = []
    var commentArray: Array<String> = []
    
// page control 관련 변수
    let numOfTouchs = 2
    
    var baseUrl = "https://61de-218-155-163-123.jp.ngrok.io/gallery?page="
    var pictureImageUrl: String?
   // let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
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
        
        
        
    }
    
//    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer, cell: MyCell) {
//            // 만일 제스쳐가 있다면
//
//            if let swipeGesture = gesture as? UISwipeGestureRecognizer{
//
//                // 발생한 이벤트가 각 방향의 스와이프 이벤트라면
//                // pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imageView에 할당
//                switch swipeGesture.direction {
//                    case UISwipeGestureRecognizer.Direction.left :
//                    cell.pageControl.currentPage -= 1
//                    cell.galleryImage.image = UIImage(named: images[(cell.pageControl.currentPage)])
//                    case UISwipeGestureRecognizer.Direction.right :
//                    cell.pageControl.currentPage += 1
//                    cell.galleryImage.image = UIImage(named: images[(cell.pageControl.currentPage)])
//                    default:
//                      break
//                }
//
//            }
//
//        }
        
        // 두 손가락 스와이프 제스쳐를 행했을 때 실행할 액션 메서드
//    @objc func respondToSwipeGestureMulti(_ gesture: UIGestureRecognizer, galleryimage: UIImageView, pageControl: UIPageControl) {
//
//            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//                switch swipeGesture.direction {
//                   case UISwipeGestureRecognizer.Direction.left:
//                    pageControl.currentPage -= 1
//                    galleryImage.image = UIImage(named: "01.svg")
////                                                        images[(cell.pageControl.currentPage)])
//                   case UISwipeGestureRecognizer.Direction.right:
//                    pageControl.currentPage += 1
//                   // cell.galleryImage.image = UIImage(named: "01.svg")
////                                                        images[(cell.pageControl.currentPage)])
//                   default:
//                       break
//                }
//            }
//        }

    @IBAction func pageChanged(_ sender: UIPageControl) {
             print("page Changed")
            //cell.galleryImage.image = UIImage(named: "01.svg")
//                                                images[(cell.pageControl.currentPage)])
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
                                self.photoIdArray.append( result[pageNumber]["photo_id"].rawValue as! Int)

                                print("result[picture_id]: \(result[pageNumber]["picture_id"])")
                                self.pictureIdArray.append( result[pageNumber]["picture_id"].rawValue as! Int)
                                
//                                print("result[comment]: \(result[pageNumber]["comment"])")
//                                self.commentArray.append( result[pageNumber]["comment"].rawValue as! String)
                                
                                
                                
                                self.pictureImageUrl = "\(self.baseUrl)/\(result[pageNumber]["picture_id"].rawValue as! Int)"

                                
                                
//                                let urlString = self.pictureImageUrl
//                                let encodedStr = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//                                self.updateUI(encodedStr)
                                
                                let data = CellData(photoId: result[pageNumber]["photo_id"].rawValue as! Int, comment: "\(result[pageNumber]["comment"].rawValue as! String)", pictureId: self.pictureIdArray[pageNumber] )

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
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var pictureLabel: UILabel!
    //@IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var pageControl: UIPageControl!
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
            
            cell.pageControl.numberOfPages = images.count
            cell.pageControl.currentPage = 0
            // 페이지 표시 색상
            cell.pageControl.pageIndicatorTintColor = UIColor.lightGray
            // 현재 페이지 표시 색상
            cell.pageControl.currentPageIndicatorTintColor = UIColor.black
            // 한 손가락 스와이프 제스쳐 등록(좌, 우)
//            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GalleryTableViewController.respondToSwipeGesture(_:cell:)))
////            
//            swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//            self.view.addGestureRecognizer(swipeLeft)
//
//            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GalleryTableViewController.respondToSwipeGesture(_:cell:)))
//            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//            self.view.addGestureRecognizer(swipeRight)
//            
//            
//            
//            // 두 손가락 스와이프 제스쳐 등록(좌, 우)
//            let swipeLeftMulti = UISwipeGestureRecognizer(target: self, action: #selector(GalleryTableViewController.respondToSwipeGestureMulti(_:cell:)))
//            swipeLeftMulti.direction = UISwipeGestureRecognizer.Direction.left
//            swipeLeftMulti.numberOfTouchesRequired = numOfTouchs
//            self.view.addGestureRecognizer(swipeLeftMulti)
//
//            let swipeRightMulti = UISwipeGestureRecognizer(target: self, action: #selector(GalleryTableViewController.respondToSwipeGestureMulti(_:cell:)))
//            swipeRightMulti.direction = UISwipeGestureRecognizer.Direction.right
//            swipeRightMulti.numberOfTouchesRequired = numOfTouchs
//            self.view.addGestureRecognizer(swipeRightMulti)
            
            cell.titleLabel.text = data.comment
            cell.pictureLabel.text = String(data.pictureId)
            cell.photoLabel.text = String(data.photoId)
            
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



