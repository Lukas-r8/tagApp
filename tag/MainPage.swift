//
//  MainPage.swift
//  tag
//
//  Created by Lucas Alves da Silva on 10/12/18.
//  Copyright © 2018 Lucas Alves da Silva. All rights reserved.
//

import Foundation
import UIKit
import ARKit

class MainPage: UIViewController {
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    let rocket: customNode = {
       let roc = customNode()
        roc.loadNode("arkit-rocket.dae")
        return roc
    }()
    var planeNode: SCNNode!
    var anchors = [ARAnchor]()

    var previousTranslation:CGFloat = 0
    var topAnchorChooseView: NSLayoutConstraint!
    var widthTextFieldAnchor: NSLayoutConstraint!

    let arConfiguration: ARWorldTrackingConfiguration = {
        let config = ARWorldTrackingConfiguration()
        config.isAutoFocusEnabled = true
        config.planeDetection = ARWorldTrackingConfiguration.PlaneDetection.horizontal
        return config
    }()
    

    
    lazy var arView: ARSCNView = {
        let arSceneView = ARSCNView()
        arSceneView.delegate = self
        arSceneView.autoenablesDefaultLighting = true
        arSceneView.translatesAutoresizingMaskIntoConstraints = false
        return arSceneView
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profileButton"), for: .normal)
        button.contentMode = UIView.ContentMode.scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(handleProfileButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var  addTagButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addTagButton"), for: .normal)
        button.contentMode = UIView.ContentMode.scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(handleAddTagButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var importButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "importButton"), for: .normal)
        button.contentMode = UIView.ContentMode.scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(handleImportButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var exportButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "exportButton"), for: .normal)
        button.contentMode = UIView.ContentMode.scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(handleExportButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let chooseTagView: UIView = {
        let chooseView = UIView()
        chooseView.translatesAutoresizingMaskIntoConstraints = false
        chooseView.backgroundColor = UIColor.white
        chooseView.layer.cornerRadius = 20
        
        return chooseView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        setARConstraintsAndViews()
        setCartView()
        
    }


    
    @objc func handleProfileButton(){
        setProfileCardView()
        callDismissCartView(isCalling: true)

    }
    
    @objc func handleAddTagButton(){
        setChooseCardViewTag()
        callDismissCartView(isCalling: true)

    }
    
   

    func setProfileCardView(){
        let overviewLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Overview"
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 30)
            return label
        }()
        
        let profilePhoto: UIImageView = {
            let image = UIImageView()
            image.backgroundColor = .red
            image.layer.cornerRadius = 150/2
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        let followingLabel: countLabel = {
            let label = countLabel(str: "Following",count: 234)
            return label
        }()
        
        let followersLabel: countLabel = {
            let label = countLabel(str: "Followers", count: 123)
            return label
        }()
        
        let tagsLabel: countLabel = {
            let label = countLabel(str: "Tags", count: 45)
            return label
        }()
        
        let citiesLabel: countLabel = {
            let label = countLabel(str: "Cities", count: 67)
            return label
        }()
        
        chooseTagView.addSubview(overviewLabel)
        chooseTagView.addSubview(profilePhoto)
        chooseTagView.addSubview(followingLabel)
        chooseTagView.addSubview(followersLabel)
        chooseTagView.addSubview(tagsLabel)
        chooseTagView.addSubview(citiesLabel)
        
        overviewLabel.leftAnchor.constraint(equalTo: chooseTagView.leftAnchor, constant: 18).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: chooseTagView.topAnchor, constant: 30).isActive = true
        overviewLabel.widthAnchor.constraint(equalTo: chooseTagView.widthAnchor, multiplier: 1).isActive = true
        overviewLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        profilePhoto.leftAnchor.constraint(equalTo: chooseTagView.leftAnchor, constant: 18).isActive = true
        profilePhoto.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20).isActive = true
        profilePhoto.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profilePhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        followingLabel.centerXAnchor.constraint(equalTo: profilePhoto.centerXAnchor).isActive = true
        followingLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 70).isActive = true
        followingLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        followingLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        followersLabel.centerXAnchor.constraint(equalTo: profilePhoto.centerXAnchor).isActive = true
        followersLabel.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 20).isActive = true
        followersLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        followersLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        tagsLabel.centerXAnchor.constraint(equalTo: profilePhoto.centerXAnchor).isActive = true
        tagsLabel.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 20).isActive = true
        tagsLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        tagsLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        citiesLabel.centerXAnchor.constraint(equalTo: profilePhoto.centerXAnchor).isActive = true
        citiesLabel.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 20).isActive = true
        citiesLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        citiesLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
    }
   
 
}







// AR delegateMethods

extension MainPage: ARSCNViewDelegate{
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        var node: SCNNode? = nil
        
        
        if let planeDetected = anchor as? ARPlaneAnchor {
            node = SCNNode()
            let plane = SCNPlane(width: CGFloat(planeDetected.extent.x), height: CGFloat(planeDetected.extent.z))
            plane.firstMaterial?.diffuse.contents = UIColor.blue.withAlphaComponent(0.5)
            planeNode = SCNNode(geometry: plane)
            planeNode.position = SCNVector3(planeDetected.center.x, 0, planeDetected.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            node!.addChildNode(planeNode)
            anchors.append(planeDetected)
        }
        
     
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            if anchors.contains(planeAnchor) {
                if node.childNodes.count > 0 {
                    let planeN = node.childNodes.first!
                    planeN.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
                    if let planeGeometry = planeN.geometry as? SCNPlane {
                        planeGeometry.width = CGFloat(planeAnchor.extent.x)
                        planeGeometry.height = CGFloat(planeAnchor.extent.z)
                    }
                }
            }
        }
        
        
  
    }
    
    
    func addNodeAtTouchedLocation(location: CGPoint){
        if anchors.count < 1 {print("No anchors added yet");return}
        let hitObjects = arView.hitTest(location, types: ARHitTestResult.ResultType.existingPlaneUsingExtent)
        if hitObjects.count > 0 {
            let objects = hitObjects.first!
            let position = SCNVector3(objects.worldTransform.columns.3.x, objects.worldTransform.columns.3.y + 0.1, objects.worldTransform.columns.3.z)
            rocket.position = position
            if !arView.scene.rootNode.childNodes.contains(rocket){
                arView.scene.rootNode.addChildNode(rocket)
            } else {
                rocket.removeFromParentNode()
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchedPoint = touches.first else {return}
        let location = touchedPoint.location(in: arView)
        
        addNodeAtTouchedLocation(location: location)
        
    }
    
    
}










extension MainPage: UICollectionViewDelegate, UICollectionViewDataSource{
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return 10

        } else {
            return self.alphabet.count
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCustomCell", for: indexPath) as! customCellFirst
            cell.layer.cornerRadius = 10
            
            cell.testLabel.text = "\(indexPath.row)"
            
          
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCustomCell", for: indexPath) as! customCellSecond
            cell.layer.cornerRadius = 10
            let index = String.Index.init(encodedOffset: indexPath.row)
            cell.testLabel.text = String(self.alphabet[index])
        
            return cell
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}





































































































// delete this variable later on...
var handleSearchButtonIsCalled = true


extension MainPage {
    
    @objc func handleSearchButton(sender: UIButton){
        if handleSearchButtonIsCalled {
            (sender.superview as! UITextField).becomeFirstResponder()
            animateExpandTextField(isExpanding: true)
            handleSearchButtonIsCalled = false
        } else {
            (sender.superview as! UITextField).resignFirstResponder()
            animateExpandTextField(isExpanding: false)
            handleSearchButtonIsCalled = true
        }
    }
    
    
    
    func setChooseCardViewTag(){
        
        let chooseTagLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Choose Tag"
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 30)
            return label
        }()
        
        let firstCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let height = view.frame.height * 0.173
            let width = height * 1.18
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = 15
            layout.scrollDirection = .horizontal
            let frame = chooseTagView.bounds
            let collection = UICollectionView(frame: CGRect(x: 0, y: frame.origin.y + 80, width: frame.size.width, height: view.frame.height * 0.246), collectionViewLayout: layout)
            collection.backgroundColor = .clear
            collection.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            collection.translatesAutoresizingMaskIntoConstraints = true
            collection.tag = 1
            collection.delegate = self
            collection.dataSource = self
            collection.register(customCellFirst.self, forCellWithReuseIdentifier: "firstCustomCell")
            
            return collection
        }()
        
        let separator: UIView = {
            let sep = UIView()
            sep.translatesAutoresizingMaskIntoConstraints = false
            sep.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
            sep.layer.cornerRadius = 0.5
            return sep
        }()
        
        let searchButton: UIButton = {
            let imv = UIButton()
            imv.setImage(UIImage(named: "searchButton"), for: .normal)
            imv.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
            imv.contentMode = .scaleAspectFill
            imv.translatesAutoresizingMaskIntoConstraints = false
            imv.layer.cornerRadius = 20
            imv.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            imv.layer.borderWidth = 0.5
            return imv
        }()
        
        let textField: UITextField = {
            let paddingView = UIView()
            paddingView.frame = CGRect(origin: .zero, size: CGSize(width: 45, height: 10))
            paddingView.alpha = 0
            
            let field = UITextField()
            field.layer.cornerRadius = 20
            field.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            field.layer.borderWidth = 0.5
            field.placeholder = " type here"
            field.clipsToBounds = true
            field.leftView = paddingView
            field.leftViewMode = .always
            field.translatesAutoresizingMaskIntoConstraints = false
            field.backgroundColor = .white
            return field
        }()
        
        let secondCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            let frame = chooseTagView.bounds
            let collection = UICollectionView(frame: CGRect(x: 0, y: frame.origin.y + 80 + view.frame.height * 0.246 + 60, width: frame.size.width, height: view.frame.height * 0.246), collectionViewLayout: layout)
            collection.backgroundColor = .clear
            collection.contentInset = UIEdgeInsets(top: 40, left: 15, bottom: 40, right: 15)
            collection.translatesAutoresizingMaskIntoConstraints = true
            collection.tag = 2
            collection.delegate = self
            collection.dataSource = self
            collection.register(customCellSecond.self, forCellWithReuseIdentifier: "secondCustomCell")
            
            return collection
        }()
        
        
        let separator2: UIView = {
            let sep = UIView()
            sep.translatesAutoresizingMaskIntoConstraints = false
            sep.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
            sep.layer.cornerRadius = 0.5
            return sep
        }()
        
        let checkMark: UIButton = {
            let check = UIButton()
            check.setImage(UIImage(named: "checkMarkButton"), for: .normal)
            check.contentMode = .scaleAspectFit
            check.contentHorizontalAlignment = .fill
            check.contentVerticalAlignment = .fill
            check.translatesAutoresizingMaskIntoConstraints = false
            return check
        }()
        
        textField.addSubview(searchButton)
        
        chooseTagView.addSubview(chooseTagLabel)
        chooseTagView.addSubview(firstCollectionView)
        chooseTagView.addSubview(separator)
        chooseTagView.addSubview(textField)
        chooseTagView.addSubview(secondCollectionView)
        chooseTagView.addSubview(separator2)
        chooseTagView.addSubview(checkMark)
        
        let buttonsSizeHeight:CGFloat = 60
        let buttonSizeWidth:CGFloat = buttonsSizeHeight * 0.836
        
        chooseTagLabel.leftAnchor.constraint(equalTo: chooseTagView.leftAnchor, constant: 18).isActive = true
        chooseTagLabel.topAnchor.constraint(equalTo: chooseTagView.topAnchor, constant: 30).isActive = true
        chooseTagLabel.widthAnchor.constraint(equalTo: chooseTagView.widthAnchor, multiplier: 1).isActive = true
        chooseTagLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //        firstCollectionView.widthAnchor.constraint(equalTo: chooseTagView.widthAnchor).isActive = true
        //        firstCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        //        firstCollectionView.centerXAnchor.constraint(equalTo: chooseTagView.centerXAnchor).isActive = true
        //        firstCollectionView.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 15).isActive = true
        
        separator.widthAnchor.constraint(equalTo: chooseTagView.widthAnchor, multiplier: 0.9).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.centerXAnchor.constraint(equalTo: chooseTagView.centerXAnchor).isActive = true
        separator.centerYAnchor.constraint(equalTo: firstCollectionView.bottomAnchor, constant: 10).isActive = true
        
        textField.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 15).isActive = true
        textField.centerXAnchor.constraint(equalTo: chooseTagView.centerXAnchor).isActive = true
        widthTextFieldAnchor = textField.widthAnchor.constraint(equalToConstant: 40)
        widthTextFieldAnchor.isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        searchButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalTo: textField.heightAnchor).isActive = true
        searchButton.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        //        secondCollectionView.widthAnchor.constraint(equalTo: chooseTagView.widthAnchor).isActive = true
        //        secondCollectionView.heightAnchor.constraint(equalToConstant: 150)
        //        secondCollectionView.centerXAnchor.constraint(equalTo: chooseTagView.centerXAnchor).isActive = true
        //        secondCollectionView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10).isActive = true
        
        separator2.widthAnchor.constraint(equalTo: chooseTagView.widthAnchor, multiplier: 0.9).isActive = true
        separator2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator2.centerXAnchor.constraint(equalTo: chooseTagView.centerXAnchor).isActive = true
        separator2.centerYAnchor.constraint(equalTo: secondCollectionView.bottomAnchor, constant: 10).isActive = true
        
        checkMark.widthAnchor.constraint(equalToConstant: buttonSizeWidth ).isActive = true
        checkMark.heightAnchor.constraint(equalToConstant: buttonsSizeHeight).isActive = true
        checkMark.centerXAnchor.constraint(equalTo: chooseTagView.centerXAnchor).isActive = true
        checkMark.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 25).isActive = true
        
        
    }
    
    
    
    
    
    func animateExpandTextField(isExpanding: Bool){
        if isExpanding {
            widthTextFieldAnchor.constant = 250
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
        } else {
            widthTextFieldAnchor.constant = 40
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    
    func callDismissCartView(isCalling: Bool){
       
        if isCalling{
            let dashView: UIView = {
                let dash = UIView()
                dash.backgroundColor = UIColor.gray
                dash.translatesAutoresizingMaskIntoConstraints = false
                dash.layer.cornerRadius = 1.5
                return dash
            }()

            chooseTagView.addSubview(dashView)
            
            dashView.centerXAnchor.constraint(equalTo: chooseTagView.centerXAnchor).isActive = true
            dashView.topAnchor.constraint(equalTo: chooseTagView.topAnchor, constant: 15).isActive = true
            dashView.widthAnchor.constraint(equalToConstant: 65).isActive = true
            dashView.heightAnchor.constraint(equalToConstant: 3).isActive = true
            self.view.layoutIfNeeded()

            topAnchorChooseView.constant = -(view.frame.height * 0.86)
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
                self.view.layoutIfNeeded()
            }, completion: { (_) in
                self.addTagButton.isEnabled = false
                self.profileButton.isEnabled = false
            })
            
        } else {
            
            topAnchorChooseView.constant = 5
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
                self.view.layoutIfNeeded()
                
            }, completion: {(_) in
                
                    self.chooseTagView.subviews.forEach({ (view) in
                        view.removeFromSuperview()
                    })
                self.addTagButton.isEnabled = true
                self.profileButton.isEnabled = true
                
            })
            
        }
        
    }
    
    
    

    @objc func moveChooseView(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: view)
        let yLimitForTagView = view.frame.height * 0.86
        let limit = self.view.frame.height - yLimitForTagView
        
        if pan.state == .began {
            print("swipe chart view began")
        } else if pan.state == .changed {
            if topAnchorChooseView.constant <= -(yLimitForTagView) {
                // Rubber Animation for choose tag view
                let locationOverLimit = max(limit - chooseTagView.frame.origin.y,1)
                let moveBy = translation.y < 0 ? CGFloat(2.5/sqrt(Double(locationOverLimit))) * -1 : max(0,translation.y)
                topAnchorChooseView.constant += moveBy
                pan.setTranslation(CGPoint.zero, in: view)
            } else if topAnchorChooseView.constant > -(yLimitForTagView) {
                topAnchorChooseView.constant += translation.y
                self.previousTranslation = translation.y
                pan.setTranslation(CGPoint.zero, in: view)
            }
            
        } else if pan.state == .ended{
            if chooseTagView.frame.origin.y <= 300 {
                topAnchorChooseView.constant = -(yLimitForTagView)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            } else {
                print("translation:", previousTranslation)
                if self.previousTranslation >= 0 {
                    self.callDismissCartView(isCalling: false)

                } else {
                    topAnchorChooseView.constant = -(view.frame.height * 0.86)
                    
                    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                    
                }
                
            }
        }
    }
    
    
    
    
    
    @objc func handleImportButton(){
        
    }
    
    @objc func handleExportButton(){
 
        let activityIndicatorView = UIActivityViewController(activityItems: [arView.snapshot()], applicationActivities: nil)
        activityIndicatorView.accessibilityFrame = CGRect.zero//CGRect(x: 0, y: self.view.frame.height - 510, width: self.view.frame.width, height: 500)
        
        present(activityIndicatorView, animated: true) {
            //completion
        }
        
        
        
    }
    
    
    
    func setARConstraintsAndViews(){
        
        arView.debugOptions = [SCNDebugOptions.showWorldOrigin, .showFeaturePoints]
        arView.session.run(arConfiguration, options: ARSession.RunOptions.resetTracking)
        
        view.addSubview(arView)
        view.addSubview(profileButton)
        view.addSubview(addTagButton)
        view.addSubview(importButton)
        view.addSubview(exportButton)
        
        let buttonsSizeHeight:CGFloat = 60
        let buttonSizeWidth:CGFloat = buttonsSizeHeight * 0.836
        
        arView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        arView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        arView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        arView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        profileButton.widthAnchor.constraint(equalToConstant: buttonSizeWidth).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: buttonsSizeHeight).isActive = true
        profileButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        profileButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        addTagButton.widthAnchor.constraint(equalToConstant: buttonsSizeHeight).isActive = true
        addTagButton.heightAnchor.constraint(equalToConstant: buttonsSizeHeight).isActive = true
        addTagButton.bottomAnchor.constraint(equalTo: profileButton.bottomAnchor).isActive = true
        addTagButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        importButton.widthAnchor.constraint(equalToConstant: buttonSizeWidth).isActive = true
        importButton.heightAnchor.constraint(equalToConstant: buttonsSizeHeight).isActive = true
        importButton.bottomAnchor.constraint(equalTo: profileButton.bottomAnchor).isActive = true
        importButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        exportButton.widthAnchor.constraint(equalToConstant: buttonSizeWidth).isActive = true
        exportButton.heightAnchor.constraint(equalToConstant: buttonsSizeHeight).isActive = true
        exportButton.bottomAnchor.constraint(equalTo: importButton.topAnchor, constant: -20).isActive = true
        exportButton.centerXAnchor.constraint(equalTo: importButton.centerXAnchor).isActive = true
        
        
        
    }
    
    func setCartView(){
        chooseTagView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveChooseView)))
        view.addSubview(chooseTagView)
        
        chooseTagView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        chooseTagView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        topAnchorChooseView = chooseTagView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 5)
        topAnchorChooseView.isActive = true
        chooseTagView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    
    
}
