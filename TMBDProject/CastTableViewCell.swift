//
//  CastTableViewCell.swift
//  TMBDProject
//
//  Created by Jae Oh on 11/5/23.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet var actorImageView: UIImageView!
    @IBOutlet var actorNameLabel: UILabel!
    @IBOutlet var characterNameLabel: UILabel!
    
    @IBOutlet weak var charactorName: UILabel!
    
    @IBOutlet weak var actorName: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

