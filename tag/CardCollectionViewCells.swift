//
//  CardCollectionViewCells.swift
//  tag
//
//  Created by Lucas Alves da Silva on 10/14/18.
//  Copyright © 2018 Lucas Alves da Silva. All rights reserved.
//

import Foundation
import UIKit


class customCellFirst: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center 
        return label
    }()
    
    
    func setUpCells(){
//        layer.borderWidth = 0.5
//        layer.borderColor = UIColor.gray.cgColor
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 3)
        backgroundColor = UIColor.white
        addSubview(testLabel)
        
        testLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        testLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        testLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
  
    
    }
    
    
    
    
    
    
    
    
}


class customCellSecond: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
        lazy var testLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            return label
        }()
    
    
    
    
        func setUpCells(){
//            layer.borderWidth = 0.5
//            layer.borderColor = UIColor.gray.cgColor
            layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            layer.shadowOpacity = 1
            layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundColor = UIColor.white
            addSubview(testLabel)
            
            testLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            testLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            testLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            testLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
            
            
        }
        
        
    
    
    
    
    
}
