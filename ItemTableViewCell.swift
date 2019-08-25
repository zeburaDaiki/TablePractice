//
//  ItemTableViewCell.swift
//  TablePractice
//
//  Created by 別所大輝 on 2019/07/03.
//  Copyright © 2019 daiki. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbContentsName: UILabel!
    @IBOutlet weak var lbContentsPrice: UILabel!
    @IBOutlet weak var ivContents: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
