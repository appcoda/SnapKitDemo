//
//  LoginView.swift
//  SnapKitDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2018 Appcoda. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    // MARK: Properties
    
    let containerViewBGColor = UIColor(red: 167.0/255.0, green: 177.0/255.0, blue: 180.0/255.0, alpha: 1.0)
    
    let innerViewBGColor = UIColor(red: 190.0/255.0, green: 195.0/255, blue: 198.0/255.0, alpha: 1.0)
    
    let containerViewHeight: CGFloat = 192.0
    
    let textfieldHeight: CGFloat = 44.0
    
    let topInnerViewHeight: CGFloat = 24.0
    
    let bottomInnerViewHeight: CGFloat = 36.0
    
    let connectButtonWidth: CGFloat = 120.0
    
    var viewContainer: UIView!
    
    var viewTop: UIView!
    
    var viewBottom: UIView!
    
    var txtEmail: UITextField!
    
    var txtPassword: UITextField!
    
    var btnConnect: UIButton!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var centerYConstraint: Constraint!
    
    var timer: Timer!
    
    var isAnimating = false
    
    
    
    // MARK: Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardDidHide(notification:)), name: .UIKeyboardDidHide, object: nil)
        
        setupContainerView()
        setupTitle()
        setupTextfields()
        setupBottomView()
        setupActivityIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
    // MARK: Custom Methods
    
    func setupContainerView() {
        viewContainer = UIView()
        self.addSubview(viewContainer)
        
        viewContainer.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(40).priority(750)
            make.right.equalTo(self).offset(-40).priority(750)
            
            make.width.lessThanOrEqualTo(500)
            
            make.centerX.equalTo(self)
            // make.centerY.equalTo(self)
            self.centerYConstraint = make.centerY.equalTo(self).constraint
            
            make.height.equalTo(containerViewHeight)
        }
        
        // Set the background color of the container view.
        viewContainer.backgroundColor = containerViewBGColor
        
        // Make the corners of the container view rounded.
        viewContainer.layer.cornerRadius = 8.0
        
        // Set the following flag to true to allow clipping of the subviews if they exceed the container view's bounds.
        viewContainer.clipsToBounds = true
    }
    
    
    func setupTitle() {
        viewTop = UIView()
        viewContainer.addSubview(viewTop)
        
        viewTop.backgroundColor = innerViewBGColor
        
        viewTop.snp.makeConstraints { (make) in
            make.left.equalTo(viewContainer)
            make.top.equalTo(viewContainer)
            make.right.equalTo(viewContainer)
            make.height.equalTo(topInnerViewHeight)
        }
        
        
        let lblTitle = UILabel()
        viewTop.addSubview(lblTitle)
        
        // Set the label's text.
        lblTitle.text = "LOGIN"
        
        // Make the text color white.
        lblTitle.textColor = UIColor.white
        
        // No background color for the label.
        lblTitle.backgroundColor = UIColor.clear
        
        // Set the font.
        lblTitle.font = UIFont(name: "Futura-Bold", size: 17.0)
        
        
        lblTitle.snp.makeConstraints { (make) in
            make.edges.equalTo(viewTop).inset(UIEdgeInsetsMake(0.0, 16.0, 0.0, 0.0))
        }
    }
    
    
    
    func setupTextfields() {
        // Initialise the email textfield and add it to viewContainer.
        txtEmail = UITextField()
        viewContainer.addSubview(txtEmail)
        
        // Set self as the delegate of the textfield so we can handle the Return button.
        txtEmail.delegate = self
        
        // Set a placeholder that will be visible when there's no text typed in the textfield.
        txtEmail.placeholder = "Email"
        
        // No border around the textfield.
        txtEmail.borderStyle = .none
        
        // Set white background color.
        txtEmail.backgroundColor = UIColor.white
        
        // Set the proper keyboard type so it's easy to write email addresses.
        txtEmail.keyboardType = .emailAddress
        
        // Show the Next button instead of the default Return key on the keyboard.
        txtEmail.returnKeyType = .next
        
        // Prevent the first letter of the email from being capitalized.
        txtEmail.autocapitalizationType = .none
        
        txtEmail.snp.makeConstraints { (make) in
            make.top.equalTo(viewTop.snp.bottom).offset(16)
            make.left.equalTo(viewContainer).offset(8)
            make.right.equalTo(viewContainer).offset(-8)
            make.height.equalTo(textfieldHeight)
        }
        
        
        
        txtPassword = UITextField()
        viewContainer.addSubview(txtPassword)
        
        // The following properties are almost identical to the email textfield's properties.
        txtPassword.delegate = self
        txtPassword.placeholder = "Password"
        txtPassword.borderStyle = .none
        txtPassword.backgroundColor = UIColor.white
        txtPassword.autocapitalizationType = .none
        
        // Show the Done title instead of the default Return key on the keyboard.
        txtPassword.returnKeyType = .done
        
        // Indicate that this is a password field by making the following flag true.
        txtPassword.isSecureTextEntry = true
        
        txtPassword.snp.makeConstraints { (make) in
            make.top.equalTo(txtEmail.snp.bottom).offset(8.0)
            make.left.equalTo(txtEmail)
            make.right.equalTo(txtEmail)
            make.height.equalTo(textfieldHeight)
        }
    }
    
    
    
    func setupBottomView() {
        // Initialize the viewBottom view and add it to viewContainer.
        viewBottom = UIView()
        viewContainer.addSubview(viewBottom)
        
        // Set its background color.
        viewBottom.backgroundColor = innerViewBGColor
        
        viewBottom.snp.makeConstraints { (make) in
            make.left.equalTo(viewContainer)
            make.right.equalTo(viewContainer)
            make.bottom.equalTo(viewContainer)
            make.height.equalTo(bottomInnerViewHeight)
        }
        
        // Initialize the Connect button and add it to viewBottom view.
        btnConnect = UIButton(type: .custom)
        viewBottom.addSubview(btnConnect)
        
        // Set its title.
        btnConnect.setTitle("Connect", for: .normal)
        
        // Set the white color as the button's text color.
        btnConnect.setTitleColor(UIColor.white, for: .normal)
        
        // Set the light gray color as the button's text color when highlighted.
        btnConnect.setTitleColor(UIColor.lightGray, for: .highlighted)
        
        // Make the background color orange.
        btnConnect.backgroundColor = UIColor.orange
        
        // Set the title font.
        btnConnect.titleLabel?.font = UIFont(name: "Futura", size: 15.0)
        
        // Specify the method that should be called when it's tapped.
        btnConnect.addTarget(self, action: #selector(self.connect), for: .touchUpInside)
        
        btnConnect.snp.makeConstraints { (make) in
            make.top.equalTo(viewBottom)
            make.right.equalTo(viewBottom)
            make.bottom.equalTo(viewBottom)
            make.width.equalTo(connectButtonWidth)
        }
    }
    
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        viewContainer.addSubview(activityIndicator)
        
        activityIndicator.color = UIColor.orange
        activityIndicator.startAnimating()
        
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(viewContainer)
            make.centerY.equalTo(viewContainer).offset(-containerViewHeight/2 - 20)
            make.width.equalTo(40)
            make.height.equalTo(self.activityIndicator.snp.width)
        }
    }
    
    
    
    @objc func connect() {
        if isAnimating {
            return
        }
        
        txtEmail.snp.remakeConstraints { (make) in
            make.top.equalTo(viewTop.snp.bottom).offset(16)
            make.left.equalTo(viewContainer.snp.right)
            make.width.equalTo(txtEmail.snp.width)
            make.height.equalTo(textfieldHeight)
        }
        
        txtPassword.snp.remakeConstraints { (make) in
            make.right.equalTo(viewContainer.snp.left)
            make.top.equalTo(txtEmail.snp.bottom).offset(8.0)
            make.width.equalTo(txtPassword.snp.width)
            make.height.equalTo(textfieldHeight)
        }
        
        activityIndicator.snp.updateConstraints { (make) in
            make.centerY.equalTo(viewContainer)
        }
        
        
        self.setNeedsLayout()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        }) { (finished) in
            if finished {
                self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.revertLoginView), userInfo: nil, repeats: false)
            }
        }
        
        isAnimating = true
    }
    
    
    @objc func revertLoginView() {
        txtEmail.snp.remakeConstraints { (make) in
            make.top.equalTo(viewTop.snp.bottom).offset(16)
            make.left.equalTo(viewContainer).offset(8)
            make.right.equalTo(viewContainer).offset(-8)
            make.height.equalTo(textfieldHeight)
        }
        
        txtPassword.snp.remakeConstraints { (make) in
            make.top.equalTo(txtEmail.snp.bottom).offset(8.0)
            make.left.equalTo(txtEmail)
            make.right.equalTo(txtEmail)
            make.height.equalTo(textfieldHeight)
        }
        
        activityIndicator.snp.updateConstraints { (make) in
            make.centerY.equalTo(viewContainer).offset(-containerViewHeight/2 - 20)
        }
        
        self.setNeedsLayout()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        }) { (finished) in
            if finished {
                self.timer.invalidate()
                self.timer = nil
                
                self.isAnimating = false
            }
        }
    }
    
    
    @objc func handleKeyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo as? Dictionary<String, Any> {
            if let keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardFrame = keyboardFrameValue.cgRectValue
                
                let containerViewOriginPlusHeight = viewContainer.frame.origin.y + viewContainer.frame.size.height
                
                if containerViewOriginPlusHeight > keyboardFrameValue.cgRectValue.origin.y {
                    let overlappedSpace = containerViewOriginPlusHeight - keyboardFrame.origin.y
                    
                    centerYConstraint.update(offset: -overlappedSpace)
                    self.setNeedsLayout()
                    
                    UIView.animate(withDuration: 0.4, animations: {
                        self.layoutIfNeeded()
                    })
                }
            }
        }
    }
    
    
    @objc func handleKeyboardDidHide(notification: Notification) {
        centerYConstraint.update(offset: 0.0)
        self.setNeedsLayout()
        
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
        })
    }
}



extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        }
        else {
            txtPassword.resignFirstResponder()
        }
        
        return true
    }
}
