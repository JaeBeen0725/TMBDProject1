//
//  ViewController.swift
//  TMBDProject
//
//  Created by Jae Oh on 11/5/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class HomeViewController: UIViewController {
  
    
    @IBOutlet weak var movieTableView: UITableView!
    
    
    var movieList : TMDBData = TMDBData(totalPages: 0, page: 0, totalResults: 0, results: [])
    let genreList : [Int : String] = [28:"Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80: "Crime", 99: "Documentary", 18: "Drama", 10751: "Family", 14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction", 10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        title = "WEEKLY"
        movieTableView.rowHeight = 150      //movie()
        
      callrequest()
        
    }
    
    func callrequest() {
        let url = "https://api.themoviedb.org/3/trending/all/week?api_key=\(APIkey.tmdbKey)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: TMDBData.self) { response in
            
            guard let value = response.value else { return }
            
            self.movieList = value
            print(self.movieList.results[3].originalTitle)
                    self.movieTableView.reloadData()
            
        }
        
    }

    
}



extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        cell.numberLabel.text = "\(indexPath.row + 1)"
        cell.numberLabel.font = UIFont.boldSystemFont(ofSize: 50)
        cell.numberLabel.textAlignment = .center
        cell.movieTitle.text = "Title"
        cell.genreTitle.text = "Genre"
        cell.genreTitle.font = UIFont.boldSystemFont(ofSize: 20)
        cell.movieTitle.font = UIFont.boldSystemFont(ofSize: 20)
        cell.movieDateLabel.text = movieList.results[indexPath.item].releaseDate
        cell.movieTitleLabel.sizeToFit()
        cell.movieGenreLabel.text = genreList[movieList.results[indexPath.item].genreIDS[0]]
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movieList.results[indexPath.item].posterPath)") {
            cell.movieImageView.kf.setImage(with: url)
        } else {
            print("이미지 없음")
        }
        
        cell.movieImageView.contentMode = .scaleAspectFill
       
        cell.movieTitleLabel.text = movieList.results[indexPath.row].originalTitle ?? movieList.results[indexPath.row].name
       
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        vc.id = movieList.results[indexPath.row].id
       
        if movieList.results[indexPath.row].originalTitle != nil {
            vc.titleText = movieList.results[indexPath.row].originalTitle ?? "타이틀 없음"
        } else {
            vc.titleText = "notitle"
        }
      
        vc.backgroundImagae = movieList.results[indexPath.row].backdropPath
        
        vc.textVieww = movieList.results[indexPath.row].overview
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

