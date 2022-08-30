//
//  ViewController.swift
//  Flooming
//
//  Created by 이범준 on 2022/06/21.
//
import UIKit
import MobileCoreServices

var images = ["01.svg", "02.svg", "03.svg", "04.svg"]

class ViewController: UIViewController {
    
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.rgbaColorFromHex(rgb: 0x250B77, alpha: 1.0)
    
        self.view.backgroundColor = UIColor.rgbaColorFromHex(rgb: 0x250B77, alpha: 1.0)
        
        updateImageBorder(image: pictureImage)
        updateImageBorder(image: photoImage)
        settingBackground(view: mainView)
    }
}


