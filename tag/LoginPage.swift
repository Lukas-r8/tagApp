//
//  ViewController.swift
//  tag
//
//  Created by Lucas Alves da Silva on 10/10/18.
//  Copyright © 2018 Lucas Alves da Silva. All rights reserved.
//

import UIKit
import AVFoundation

class LoginPage: UIViewController {
    
    override var prefersStatusBarHidden: Bool {return true}

    lazy var playerLayer: AVPlayerLayer = {
        
        let urlPath = Bundle.main.path(forResource: "Natur", ofType: ".mov")
        let url = URL.init(fileURLWithPath: urlPath!)
        
        let play = AVPlayer(url: url)
        play.playImmediately(atRate: 1)
        // custom notification obs: post is in appDelegate applicationWillEnterForeground method..
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init("willEnterForeground"), object: nil, queue: nil, using: { (_) in
            play.seek(to: CMTime.zero)
            play.playImmediately(atRate: 1)
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil, using: { (_) in
            play.seek(to: CMTime.zero)
            play.playImmediately(atRate: 1)
        })
        
        let layer = AVPlayerLayer(player: play)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.frame = self.view.bounds
        layer.backgroundColor = UIColor.red.cgColor

        return layer
    }()
    
    

    let appLabel: UILabel = {
        let label = UILabel()
        label.text = "Tag-App"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.init(name: "Baskerville-BoldItalic", size: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
        button.setTitle("LOGIN", for: .normal)
        button.addTarget(self, action: #selector(handleLoginPageButtons), for: .touchUpInside)
        button.tag = 10
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
        button.setTitle("REGISTER", for: .normal)
        button.addTarget(self, action: #selector(handleLoginPageButtons), for: .touchUpInside)
        button.tag = 11
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    
    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blur = UIVisualEffectView(effect: blurEffect)
        blur.alpha = 0
        blur.translatesAutoresizingMaskIntoConstraints = false
        return blur
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = self.view.bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViewsAndSetConstraints()
       
    }

    
   @objc func  handleLoginPageButtons(button: UIButton){
    
            if button.tag == 10{
                print("handle login")
                handleLoginButton()
            } else if button.tag == 11 {
                print("handle register")
                hadleRegisterButton()
            } else if button.tag == 12{
                print("handle facebook login")
            }
    
    }
    
    
    func handleLoginButton(){
        callBlurView(isCalling: true)
        
       
        
        
    }
    
    func hadleRegisterButton(){
        callBlurView(isCalling: true)
        
        let facebookButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
            button.setTitle("FACEBOOK", for: .normal)
            button.addTarget(self, action: #selector(handleLoginPageButtons), for: .touchUpInside)
            button.tag = 12
            button.layer.cornerRadius = 25
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        blurView.contentView.addSubview(facebookButton)
        
        facebookButton.widthAnchor.constraint(equalTo: blurView.widthAnchor, multiplier: 0.8).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        facebookButton.centerXAnchor.constraint(equalTo: blurView.centerXAnchor).isActive = true
        facebookButton.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -60).isActive = true
        
        
        
    }
    
  
}









































extension LoginPage {
    
    func addViewsAndSetConstraints(){
        
        self.view.layer.addSublayer(playerLayer)
        self.view.addSubview(appLabel)
        self.view.addSubview(registerButton)
        self.view.addSubview(loginButton)
        
        
        appLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        appLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        
        
        
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -15).isActive = true
        
        
    }
    
    func callBlurView(isCalling: Bool){
        
        if isCalling{
            
            let closeButton: UIButton = {
                let button = UIButton()
                button.frame.size = CGSize(width: 10, height: 10)
                button.layer.cornerRadius = 15
                button.layer.borderWidth = 2
                button.setTitle("X", for: .normal)
                button.tintColor = UIColor.white
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                button.addTarget(self, action: #selector(dismissBlur), for: .touchUpInside)
                button.layer.borderColor = UIColor.white.cgColor
                button.backgroundColor = UIColor.clear
                button.translatesAutoresizingMaskIntoConstraints = false
                return button
            }()
            
            view.addSubview(blurView)
            blurView.contentView.addSubview(closeButton)
            
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            closeButton.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 40).isActive = true
            closeButton.leftAnchor.constraint(equalTo: blurView.leftAnchor, constant: 30).isActive = true
            closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
            UIView.animate(withDuration: 0.4) {
                self.blurView.alpha = 1
            }
            
            print("this method is in an main page extension")
            
        } else {
            
            UIView.animate(withDuration: 0.4, animations: {
                self.blurView.alpha = 0
            }) { (_) in
                self.blurView.contentView.subviews.forEach({ (view) in
                    view.removeFromSuperview()
                })
                self.blurView.removeFromSuperview()
            }
            
        }
        
    }
    
    @objc func dismissBlur(){
        callBlurView(isCalling: false)
    }
    
}
