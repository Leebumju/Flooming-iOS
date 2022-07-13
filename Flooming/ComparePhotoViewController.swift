//
//  ComparePhotoViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/13/22.
//

import UIKit

class ComparePhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var list = ["장미", "카네이션", "노루오줌"]
    var imageList = ["01.png","02.svg","03.svg"]
    
    @IBOutlet weak var comparePhotoView: UIView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectFlowerCell", for: indexPath) as! SelectFlowerCell
                
        cell.backgroundColor = .clear
        cell.flowerLabel.text = list[indexPath.row]
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    @IBOutlet weak var flowerImage: UIImageView!
    @IBOutlet weak var flowerLabel: UILabel!

}


