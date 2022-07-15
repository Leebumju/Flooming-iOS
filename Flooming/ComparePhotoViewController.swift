//
//  ComparePhotoViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/13/22.
//

import UIKit

class ComparePhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var list = ["장미(Rose)", "카네이션(hihi)", "노루오줌(pee)"]
    var images = ["01", "02", "03"]
    
    @IBOutlet weak var comparePhotoView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectFlowerCell", for: indexPath) as! SelectFlowerCell
                
        cell.backgroundColor = .clear
        cell.flowerLabel.text = list[indexPath.row]
        cell.flowerImage.image = UIImage(named: images[indexPath.row])
        return cell

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    
        collectionView.backgroundColor = .clear
        comparePhotoView.clipsToBounds = true
        comparePhotoView.layer.cornerRadius = 30
        comparePhotoView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        comparePhotoView.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)

        // Do any additional setup after loading the view.
        
        self.comparePhotoView.isUserInteractionEnabled = true
            //제쳐스 추가
        self.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
     
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        alertPhotoChoice()
    }
    
    
    func alertPhotoChoice() {
        print("클릭 되었음.")
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "PopupViewController")
        popupVC.modalPresentationStyle = .overFullScreen
        present(popupVC, animated: false, completion: nil)
    }
//        //1. 경고창 내용 만들기
//        let alert = UIAlertController(title:"로그아웃 하시겠습니까?",message: "",preferredStyle: UIAlertController.Style.alert)
//        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
//        //확인 버튼 만들기
//        let ok = UIAlertAction(title: "확인", style: .destructive, handler: {
//            action in
//            //특정기능 수행
//        })
//        alert.addAction(cancle)
//        //확인 버튼 경고창에 추가하기
//        alert.addAction(ok)
//        present(alert,animated: true,completion: nil)
//    }
}

extension ComparePhotoViewController: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 3 - 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: width, height: width)
        return size
    }
}

class SelectFlowerCell: UICollectionViewCell {
    @IBOutlet var flowerImage: UIImageView!
    @IBOutlet weak var flowerLabel: UILabel!

}


