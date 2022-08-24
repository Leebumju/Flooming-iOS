//
//  UpdateImageBorder.swift
//  Flooming
//
//  Created by 이범준 on 8/12/22.
//

import UIKit

func updateImageBorder(image: UIImageView) {
    image.layer.borderWidth = 2
    image.layer.cornerRadius = 20
    image.layer.borderColor = UIColor.white.cgColor
}

func settingBackground(view: UIView) {
    view.clipsToBounds = true
    view.layer.cornerRadius = 30
    view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpeg")!)
}

func updateImageFromUrl(encodedStr: String, imageView: UIImageView){
    
    var tempImg : UIImage?
    
    DispatchQueue.global().async {
        if let ImageData = try? Data(contentsOf: URL(string: encodedStr)!) {
            tempImg = UIImage(data: ImageData)!
        } else {
            tempImg = UIImage(named: "01.svg")
        }
        
        DispatchQueue.main.async {
            imageView.image = tempImg
        }
    }
}
