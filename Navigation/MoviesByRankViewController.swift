//
//  MoviesByRankViewController.swift

//
//  Created by Sandeep Penchala on 3/12/17.
//  Copyright © 2017 Sandeep Penchala. All rights reserved.
//

import Foundation
import UIKit
class MoviesByRankViewController: UITableViewController {
    var serviceLayer:ServiceLayer?
    fileprivate var movieByRankList: [MovieByRank]?
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceLayer = ServiceLayer()
        serviceLayer?.delegate = self
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        serviceLayer?.fetchMoviesByRank(startRankIndex: 1, numberOfMovies: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
extension MoviesByRankViewController: ServiceLayerDelegate{
    func handleSuccess(response list: [Any]?) {
        let moviebyRankArray = list as! [MovieByRank]
        movieByRankList = moviebyRankArray
        tableView.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func handleFailure(error: Error?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

//UITableViewDataSource
extension MoviesByRankViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = "Cell"
        let cell:MovieByRankTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! MovieByRankTableViewCell
        guard let movie = movieByRankList?[indexPath.row] else {
            return cell
        }
        cell.id.text = "Id : \(movie.id!)"
        cell.rank.text = "Rank : \(movie.rank!)"
        cell.name.text = "Name : \(movie.name!)"
        return cell
    }
}

//UITableViewDelegate
extension MoviesByRankViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = movieByRankList?.count else{
            return 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
