//
//  DetailPhotoViewController.swift
//  Flooming
//
//  Created by 이범준 on 2022/06/23.
//

import UIKit

class DetailPhotoViewController: UIViewController {

    var photoImage: UIImage?
    var label: String = ""
    
    @IBOutlet weak var detailPhotoImage: UIImageView!
    
    @IBOutlet weak var detailPhotoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPhotoImage.image = photoImage
        detailPhotoLabel.text = label
        dismiss(animated: true, completion: nil)
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
