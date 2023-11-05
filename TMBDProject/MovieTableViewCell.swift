//
//  MovieTableViewCell.swift
//  TMBDProject
//
//  Created by Jae Oh on 11/5/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet var movieDateLabel: UILabel!
    @IBOutlet var movieGenreLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
