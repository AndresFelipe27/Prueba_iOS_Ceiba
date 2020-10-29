//
//  ViewController.swift
//  CeibaiOS
//
//  Created by Felipe18 on 28/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableUsers: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userManager = UserManager()
    var listUsers = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userManager.delegate = self
        setUpTableView()
        userManager.getUsersFromApi()
        //postManager.getPostByUserIdFromApi(userId: 1)
    }
    
    func setUpTableView() {
        tableUsers.dataSource = self
        tableUsers.delegate = self
        tableUsers.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        //send data to the PostsViewController
        if segue.identifier == "segueDetailUser" {
            if let destination = segue.destination as? PostsViewController {
                //destination.breed = self.datos[self.rowSelected]
            }
        }
        
    }


}

//MARK: - UserManagerDelegate
extension UsersViewController: UserManagerDelegate {
    func didUpdateTableUsers(users: [User]) {
        self.listUsers = users
        print("Entro")
        DispatchQueue.main.async {
            
            self.activityIndicator.stopAnimating()
            self.tableUsers.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}


//MARK: - UITableView DataSource & Delegate
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.configureCell(user: self.listUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.rowSelected = indexPath.row
        self.performSegue(withIdentifier: "segueDetailUser", sender: self)
        
    }
    
    
    
}

