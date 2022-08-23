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
    var selectedImage: UIImage!
    
    @IBOutlet weak var comparePhoto: UIImageView!
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
        comparePhoto.image = selectedImage
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
            //가고자 하는 VC가 맞는지 확인해줍니다.
        guard let nextVC = destination as? PopupViewController else {
            return
        }
        
    }
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


