//
//  Progress.swift
//  KanjiMaster
//
//  Created by Md Zahidul Islam Mazumder on 12/4/20.
//  Copyright © 2020 Md Zahidul Islam Mazumder. All rights reserved.
//

import Foundation
import UIKit

class ProgressHUD: UIVisualEffectView {

  var text: String? {
    didSet {
      label.text = text
    }
  }

    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
  let label: UILabel = UILabel()
  let blurEffect = UIBlurEffect(style: .light)
  let vibrancyView: UIVisualEffectView

  init(text: String) {
    self.text = text
    self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
    super.init(effect: blurEffect)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    self.text = ""
    self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
    super.init(coder: aDecoder)
    self.setup()
  }

  func setup() {
    contentView.addSubview(vibrancyView)
    contentView.addSubview(activityIndictor)
    contentView.addSubview(label)
    activityIndictor.startAnimating()
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    if let superview = self.superview {

      let width = superview.frame.size.width / 2.3
      let height: CGFloat = 50.0
      self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                      y: superview.frame.height / 2 - height / 2,
                      width: width,
                      height: height)
      vibrancyView.frame = self.bounds

      let activityIndicatorSize: CGFloat = 40
      activityIndictor.frame = CGRect(x: 5,
                                      y: height / 2 - activityIndicatorSize / 2,
                                      width: activityIndicatorSize,
                                      height: activityIndicatorSize)

      layer.cornerRadius = 8.0
      layer.masksToBounds = true
      label.text = text
      label.textAlignment = NSTextAlignment.center
      label.frame = CGRect(x: activityIndicatorSize + 5,
                           y: 0,
                           width: width - activityIndicatorSize - 15,
                           height: height)
      label.textColor = UIColor.gray
      label.font = UIFont.boldSystemFont(ofSize: 16)
    }
  }

  func show() {
    self.isHidden = false
  }

  func hide() {
    self.isHidden = true
  }
}

var vSpinner : UIView?
 
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
