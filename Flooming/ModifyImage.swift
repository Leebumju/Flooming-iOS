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
