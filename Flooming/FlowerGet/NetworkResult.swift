//
//  NetworkResult.swift
//  Flooming
//
//  Created by 이범준 on 7/21/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
