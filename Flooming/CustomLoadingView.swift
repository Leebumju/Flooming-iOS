//
//  CustomLoadingView.swift
//  Flooming
//
//  Created by 이범준 on 8/9/22.
//

import Foundation
import UIKit
import Gifu

class CustomLoadingView {
    private static let sharedInstance = CustomLoadingView()
    
    private var backgroundView: UIView?
    
    let popupView = GIFImageView()
    popupView.contentMode = .center
    popupView.prepareForAnimation(withGIFNamed: "spinner")
    class func show() {
          //view를 show해주는 코드
    }
        
    class func hide() {
          //view를 hide해주는 코드
    }
}
