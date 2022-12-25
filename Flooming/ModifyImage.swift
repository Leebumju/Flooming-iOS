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

func updateImageClearBorder(image: UIImageView) {
    image.layer.borderWidth = 2
    image.layer.cornerRadius = 20
    image.layer.borderColor = UIColor.clear.cgColor

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
            imageView.image = resizeImage(image: tempImg!, width: 250, height: 250)
        }
    }
}

func resizeImage(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
     UIGraphicsBeginImageContext(CGSize(width: width, height: height))
     image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
     let newImage = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     return newImage!
 }

extension UIColor {
    class func rgbaColorFromHex(rgb: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                     green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                      blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                     alpha: alpha)
    }
}
