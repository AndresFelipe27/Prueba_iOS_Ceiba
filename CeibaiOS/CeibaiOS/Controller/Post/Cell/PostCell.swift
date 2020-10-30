//
//  PostCell.swift
//  CeibaiOS
//
//  Created by Felipe18 on 29/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        self.lblTitle.text = post.title
        self.lblBody.text = post.body
    }
    
}
