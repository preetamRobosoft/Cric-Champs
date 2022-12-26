//
//  Toast.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 22/12/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message : String, controller: UIViewController) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 120, y: self.view.frame.size.height + 90, width: 250, height: 66))
        toastLabel.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 17.0)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 2
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        controller.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
                        toastLabel.alpha = 0.0 }, completion: {(isCompleted) in
                            toastLabel.removeFromSuperview()
                        })
    } }
