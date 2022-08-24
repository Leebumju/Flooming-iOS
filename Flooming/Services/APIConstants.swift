//
//  APIConstants.swift
//  Flooming
//
//  Created by 이범준 on 8/24/22.
//

import Foundation

struct APIConstants {
    
    static let shared = APIConstants()
    
    let baseURL: String = "http://flooming.link"
    let flowerURL: String = "http://flooming.link/flower"
    let photoURL: String = "http://flooming.link/photo"
    let pictureURL: String = "http://flooming.link/picture"
    let galleryURL: String = "http://flooming.link/gallery"
    let reportURL: String = "http://flooming.link/report"
    let galleryPageURL: String = "http://flooming.link/gallery?page="
}
