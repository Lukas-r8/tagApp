//
//  CustomNodes.swift
//  tag
//
//  Created by Lucas Alves da Silva on 10/17/18.
//  Copyright © 2018 Lucas Alves da Silva. All rights reserved.
//

import Foundation
import ARKit




class customNode: SCNNode {

    func loadNode(_ fileNameWithExtension: String){

        guard let object = SCNScene(named: fileNameWithExtension, inDirectory: "art.scnassets", options: nil) else {
            print("not able to load image")
            return
        }
        let wrapperNode = SCNNode()
        for node in object.rootNode.childNodes {
            wrapperNode.addChildNode(node)
        }
        wrapperNode.position = SCNVector3(0, 0, 0)
        wrapperNode.transform = SCNMatrix4MakeScale(0.2, 0.2, 0.2)
        let action = SCNAction.rotate(by: .pi * 2, around: SCNVector3(0, 1, 0), duration: 4)
        let rep = SCNAction.repeatForever(action)
        wrapperNode.eulerAngles = SCNVector3(CGFloat.pi/8, 0, CGFloat.pi/4)
        wrapperNode.runAction(rep)
        self.addChildNode(wrapperNode)
    }

    
}
