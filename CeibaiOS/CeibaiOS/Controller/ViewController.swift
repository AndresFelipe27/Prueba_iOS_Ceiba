//
//  ViewController.swift
//  CeibaiOS
//
//  Created by Felipe18 on 28/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userManager = UserManager()
    var postManager = PostManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userManager.getUsersFromApi()
        postManager.getPostByUserIdFromApi(userId: 1)
    }


}

