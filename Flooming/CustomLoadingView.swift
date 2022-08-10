//
//  CustomLoadingView.swift
//  Flooming
//
//  Created by 이범준 on 8/9/22.
//

import UIKit

final class CustomLoadingView: UIView {
    
    
    private let labelView: UIView = {
        let excersice1label = UILabel()
        excersice1label.textAlignment = .center
        excersice1label.text = "Excercise 1"
        excersice1label.font = UIFont.boldSystemFont(ofSize: 20)
        excersice1label.translatesAutoresizingMaskIntoConstraints = false
        
        return excersice1label
    }()
  private let backgroundView: UIView = {
    let view = UIView()
      
    view.backgroundColor =  UIColor(patternImage: UIImage(named: "background.jpeg")!)
    view.translatesAutoresizingMaskIntoConstraints = false
     
    
      
    return view
  }()
  private let activityIndicatorView: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .large)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  
  var isLoading = false {
    didSet {
      self.isHidden = !self.isLoading
      self.isLoading ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.backgroundView)
    self.addSubview(self.activityIndicatorView)
      self.addSubview(self.labelView)
    NSLayoutConstraint.activate([
      self.backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
      self.backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor),
      self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
    ])
      NSLayoutConstraint.activate([
        self.labelView.leftAnchor.constraint(equalTo: self.leftAnchor),
        self.labelView.rightAnchor.constraint(equalTo: self.rightAnchor),
        self.labelView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        self.labelView.topAnchor.constraint(equalTo: self.topAnchor),
      ])
    NSLayoutConstraint.activate([
      self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    ])
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
}
