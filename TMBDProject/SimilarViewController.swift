//
//  SimilarViewController.swift
//  TMBDProject1
//
//  Created by Jae Oh on 11/8/23.
//

import UIKit
import Alamofire
import Kingfisher

class SimilarViewController: UIViewController {
    
    @IBOutlet weak var similerMovie: UICollectionView!
    
    @IBOutlet weak var movieImages: UICollectionView!
    
    @IBOutlet weak var movieBackDrop: UICollectionView!
    
    @IBOutlet weak var similarTitle: UILabel!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var backDropImageTitle: UILabel!
    
    var similarList = Similar(page: 0, results: [], totalPages: 0, totalResults: 0)
    var imagess = Images1(backdrops: [], id: 0, logos: [], posters: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mission: Impossible"
        similerMovie.dataSource = self
        similerMovie.delegate = self
        movieImages.dataSource = self
        movieImages.delegate = self
        movieBackDrop.dataSource = self
        movieBackDrop.delegate = self
        selectTamaCollecttionViewLayout(collectionView: similerMovie, widthnum: 3, heightnum: 1.2)
        selectTamaCollecttionViewLayout(collectionView: movieImages, widthnum: 3, heightnum: 1.2)
        selectTamaCollecttionViewLayout(collectionView: movieBackDrop, widthnum: 1.2, heightnum: 1.8)
      
        similarRequest()
        imagest()
        similarTitle.text = " Similar Movies"
        similarTitle.font = UIFont.boldSystemFont(ofSize: 23)
        
        imageTitle.text = " Images"
        imageTitle.font = UIFont.boldSystemFont(ofSize: 23)
        
        backDropImageTitle.text = " BackDrop Images"
        backDropImageTitle.font = UIFont.boldSystemFont(ofSize: 23)
    }
    
    func selectTamaCollecttionViewLayout(collectionView: UICollectionView, widthnum: Double, heightnum: Double) {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let spacing : CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
      
        layout.itemSize = CGSize(width: width / widthnum, height: width / heightnum)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }
    
    
    
    func similarRequest() {
        let url = "https://api.themoviedb.org/3/movie/575264/similar?api_key=\(APIkey.tmdbKey)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: Similar.self) { response in
            
            guard let value = response.value else { return }
            
            self.similarList = value
       
                    self.similerMovie.reloadData()
            
        }
        
    }

    func imagest() {
        let url = "https://api.themoviedb.org/3/movie/575264/images?api_key=\(APIkey.tmdbKey)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: Images1.self) { response in
            
            guard let value = response.value else { return }
            
            self.imagess = value
       
                    self.movieImages.reloadData()
            self.movieBackDrop.reloadData()
            
        }
        
    }
    
    
    
}



extension SimilarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == similerMovie {
            return similarList.results.count
        }
        else if collectionView == movieImages {
            return imagess.posters.count
        }
        else if collectionView == movieBackDrop {
            return imagess.backdrops.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if collectionView == similerMovie {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCollectionViewCell", for: indexPath) as? SimilarCollectionViewCell else {return UICollectionViewCell()}
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(similarList.results[indexPath.item].posterPath)")
                cell.SimilarImage.kf.setImage(with: url)
                
            return cell
        }
        else if collectionView == movieImages {
            guard let celll = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as? ImagesCollectionViewCell else {return UICollectionViewCell()}
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(imagess.posters[indexPath.row].filePath)")
            celll.images.kf.setImage(with: url)
            celll.images.contentMode = .scaleAspectFit
            return celll
        }
        else if collectionView == movieBackDrop {
            guard let cellll = collectionView.dequeueReusableCell(withReuseIdentifier: "BackDropCollectionViewCell", for: indexPath) as? BackDropCollectionViewCell else {return UICollectionViewCell()}
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(imagess.backdrops[indexPath.row].filePath)")
            cellll.backDropImage.kf.setImage(with: url)
            cellll.backDropImage.contentMode = .scaleAspectFill
            return cellll
        }
      
        
        
        return UICollectionViewCell()
    }
    
}
