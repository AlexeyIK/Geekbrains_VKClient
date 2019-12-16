//
//  ViewController.swift
//  iOS_UI_practice1
//
//  Created by Alex on 24.11.2019.
//  Copyright © 2019 Alexey Kuznetsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var shakeMeLabel: UILabel!
    @IBAction func buttonPressed(_ sender: Any) {
        let login = loginInput.text!
        let password = passInput.text!
        
//        if login == "admin" && password == "12345678" {
        if login == "" && password == "" {
            performSegue(withIdentifier: "MainTabbar", sender: sender)
        }
        else {
            let alert = UIAlertController(title: "Ошибка", message: "Неверная пара логин/пароль", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var snowEmitterLayer = CAEmitterLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shakeMeLabel.alpha = 0.0
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 1.0, delay: 3.5, options: [], animations: {
            self.shakeMeLabel.alpha = 1.0
        })
        
        UIView.animate(withDuration: 0.75, delay: 4.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.5, options: [.repeat, .autoreverse], animations: {
            self.shakeMeLabel.transform = CGAffineTransform(translationX: 6.0, y: 3.0)
        })
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            snowAnimation()
        }
    }
    
    func snowAnimation() {
        let emitterSnow = CAEmitterCell()
        emitterSnow.contents = UIImage(named: "snowflake")?.cgImage
        emitterSnow.scale = 0.06
        emitterSnow.scaleRange = 0.3
        emitterSnow.birthRate = 25
        emitterSnow.lifetime = 10.0
        emitterSnow.velocity = -30
        emitterSnow.velocityRange = -20
        emitterSnow.yAcceleration = 30
        emitterSnow.xAcceleration = 5
        emitterSnow.spin = -0.5
        emitterSnow.spinRange = 1.0
        
        snowEmitterLayer.emitterPosition = CGPoint(x: view.bounds.width/2, y: -50)
        snowEmitterLayer.emitterSize = CGSize(width: view.bounds.width * 1.5, height: 0)
        snowEmitterLayer.emitterShape = .line
        snowEmitterLayer.beginTime = CACurrentMediaTime()
        snowEmitterLayer.timeOffset = 10
        snowEmitterLayer.emitterCells = [emitterSnow]
        view.layer.addSublayer(snowEmitterLayer)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo! as Dictionary
        let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
        self.scrollView?.contentInset = contentInsets
        self.scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на события клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Отписываемся от событий клавиатуры
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

