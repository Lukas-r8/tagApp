//
//  UIExtensions.swift
//  tag
//
//  Created by Lucas Alves da Silva on 10/12/18.
//  Copyright © 2018 Lucas Alves da Silva. All rights reserved.
//

import Foundation
import UIKit


//MARK: -UIButtonExtensions

extension UIButton {
    open override var isHighlighted: Bool {
        didSet {
            if tag == 10 {
                backgroundColor = isHighlighted ? UIColor(cgColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) : UIColor(cgColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
            } else if tag == 11 {
                backgroundColor = isHighlighted ? UIColor(cgColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) : UIColor(cgColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
            } else if tag == 12 {
                backgroundColor = isHighlighted ? UIColor(cgColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)) : UIColor(cgColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
            }
        }
    }
}
