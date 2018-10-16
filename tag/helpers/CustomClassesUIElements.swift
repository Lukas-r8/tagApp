//
//  CustomClassesUIElements.swift
//  tag
//
//  Created by Lucas Alves da Silva on 10/16/18.
//  Copyright © 2018 Lucas Alves da Silva. All rights reserved.
//

import Foundation
import UIKit


class countLabel: UILabel {
    
    let str: String
    var count: Int {
        didSet{
            text = "\(count) \n \(str)"
        }
    }
    
    init(str:String,count:Int = 0){
        self.str = str
        self.count = count
        super.init(frame: .zero)
        setLabel(str,counter: count)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel(_ textLabel: String,counter:Int){
        translatesAutoresizingMaskIntoConstraints = false
        self.text = "\(counter)\n\(textLabel)"
        numberOfLines = 0
        textAlignment = .center
        textColor = .black
    }
    
}







