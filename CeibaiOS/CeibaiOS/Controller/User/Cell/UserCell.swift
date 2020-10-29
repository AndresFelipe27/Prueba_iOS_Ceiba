//
//  UserCell.swift
//  CeibaiOS
//
//  Created by Felipe18 on 29/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(user: User) {
        self.lblName.text = user.name
        self.lblPhone.text = user.phone
        self.lblEmail.text = user.email
    }
    
}
