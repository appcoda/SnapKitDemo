//
//  ViewController.swift
//  SnapKitDemo
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2018 Appcoda. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loginView = LoginView()
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view)
//            make.top.equalTo(self.view)
//            make.right.equalTo(self.view)
//            make.bottom.equalTo(self.view)
            
            make.edges.equalTo(self.view)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

