//
//  PostsViewController.swift
//  CeibaiOS
//
//  Created by Felipe18 on 29/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tablePosts: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var user: User?
    
    var postManager = PostManager()
    var listPosts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postManager.delegate = self
        setUpInfoUser()
        setUpTableView()
        postManager.getPostByUserIdFromApi(userId: user!.id)
    }
    
    func setUpInfoUser() {
        self.lblName.text = self.user?.name
        self.lblPhone.text = self.user?.phone
        self.lblEmail.text = self.user?.email
    }
    
    func setUpTableView() {
        tablePosts.dataSource = self
        tablePosts.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }

}

//MARK: - PostManagerDelegate
extension PostsViewController: PostManagerDelegate {
    func didUpdateTablePost(posts: [Post]) {
        self.listPosts = posts
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tablePosts.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

//MARK: - UITableView DataSource
extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.configureCell(post: self.listPosts[indexPath.row])
        return cell
    }
    
    
}
