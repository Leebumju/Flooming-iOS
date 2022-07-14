//
//  GalleryTableViewController.swift
//  Flooming
//
//  Created by 이범준 on 7/14/22.
//

import UIKit

class GalleryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var galleryTableView: UITableView!
    
    var galleryList = ["1","2","3","4","5","6","7","8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "galleryCell", for: indexPath) as! GalleryCell
        cell.comment.text = galleryList[indexPath.row]
        
        return cell
    }
}

class GalleryCell: UITableViewCell {
//    @IBOutlet weak var gallaryImage: UIImageView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var downloadImage: UIImageView!
}
