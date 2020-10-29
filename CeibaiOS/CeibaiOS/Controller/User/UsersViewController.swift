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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var lbl: UILabel? = nil
    
    var userManager = UserManager()
    var listUsers = [User]()
    var isSearching: Bool = false
    var filteredData = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userManager.delegate = self
        hideKeyboardWhenTappedAround()
        setUpTableView()
        setUpSearchBar()
        userManager.getUsersFromApi()
        //postManager.getPostByUserIdFromApi(userId: 1)
    }
    
    func setUpTableView() {
        tableUsers.dataSource = self
        tableUsers.delegate = self
        tableUsers.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    func setUpSearchBar() {
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.search
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        setUpBackItemNavigation()
        
        //send data to the PostsViewController
        if segue.identifier == "segueDetailUser" {
            if let destination = segue.destination as? PostsViewController {
                destination.user = sender as? User
            }
        }
        
    }
    
    func setUpBackItemNavigation() {
        let backItem = UIBarButtonItem()
        backItem.title = navigationItem.title
        navigationItem.backBarButtonItem = backItem
    }
    
    func addLabelListEmpty() {
        if self.lbl == nil {
            print("Create Label")
            self.lbl = UILabel()
            lbl?.textAlignment = .center
            lbl?.text = "List is empty"
            lbl?.textColor = .black
            lbl?.backgroundColor = .white
            lbl?.font = UIFont.systemFont(ofSize: 17)
            lbl?.sizeToFit()
            lbl?.center.x = self.view.center.x
            lbl?.center.y = self.view.center.y
            view.addSubview(lbl!)
        }
    }
    
    func removeLabelListEmpty() {
        if self.lbl != nil {
            print("Remove Label")
            self.lbl?.removeFromSuperview()
            self.lbl = nil
        }
    }
    
}

//MARK: - UserManagerDelegate
extension UsersViewController: UserManagerDelegate {
    func didUpdateTableUsers(users: [User]) {
        self.listUsers = users
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
        if isSearching {
            return self.filteredData.count
        }else {
            return self.listUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        if isSearching {
            cell.configureCell(user: self.filteredData[indexPath.row])
        } else {
            cell.configureCell(user: self.listUsers[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var userSelected : User?
        if isSearching {
            userSelected = self.filteredData[indexPath.row]
        }else {
            userSelected = self.listUsers[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "segueDetailUser", sender: userSelected)
    }
}

//MARK: - UISearchBarDelegate
extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            self.removeLabelListEmpty()
            tableUsers.reloadData()
        }else {
            isSearching = true
            filteredData = listUsers.filter({
                ($0.name).range(of: searchBar.text!, options: .caseInsensitive) != nil
            })
            //Put label List is empty if
            if filteredData.count == 0 {
                self.addLabelListEmpty()
            }else{
                self.removeLabelListEmpty()
            }
            tableUsers.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismissKeyboard()
    }
}

//MARK: - UISearchBarDelegate
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

