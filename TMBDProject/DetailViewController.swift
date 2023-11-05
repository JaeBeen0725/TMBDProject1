//
//  DetailViewController.swift
//  TMBDProject
//
//  Created by Jae Oh on 11/5/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Cast {
    let castTumbnail: String
    let castName: String
    let charactorName: String
}

class DetailViewController: UIViewController {
    @IBOutlet var moviebackGroundImageView: UIImageView!
    @IBOutlet var movieTextView: UITextView!
    
    @IBOutlet var castTableView: UITableView!
    
    var titleText: String = ""
    var id = 1
    var backgroundImagae = ""
    var textVieww = ""
    var castList: Tmdb = Tmdb(id: 0, cast: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        castTableView.dataSource = self
        castTableView.delegate = self
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(backgroundImagae)")
        moviebackGroundImageView.kf.setImage(with: url)
        
        movieTextView.text = textVieww
        print(textVieww)
        self.title = titleText
        detail(id: id)
        castTableView.rowHeight = 200
    }
    
    func detail(id: Int) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(APIkey.tmdbKey)"
        AF.request(url, method: .get).validate().responseDecodable(of: Tmdb.self) { response in
            
            guard let value = response.value else { return }
            

            self.castList = value
       
        }
        
    }
}



extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castList.cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell else {return UITableViewCell() }
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(castList.cast[indexPath.item].profilePath ?? "빈사진" )")
        cell.actorImageView.kf.setImage(with: url)
        
        cell.actorNameLabel.text = castList.cast[indexPath.row].originalName
        cell.characterNameLabel.text = castList.cast[indexPath.row].name
        
        return cell
    }
}
