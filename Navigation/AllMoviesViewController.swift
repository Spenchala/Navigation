//
//  ViewController.swift

//
//  Created by Sandeep Penchala on 3/11/17.
//  Copyright © 2017 Sandeep Penchala. All rights reserved.
//

import UIKit

class AllMoviesViewController: UITableViewController {
    var serviceLayer:ServiceLayer?
    fileprivate var movieList: [Movie]?
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceLayer = ServiceLayer()
        serviceLayer?.delegate = self
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        serviceLayer?.fetchAllMovies()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailInfo"{
            let detailedViewController = segue.destination as! MovieDetailsViewController
            detailedViewController.movie = movieList?[0]
    }
}
}
extension AllMoviesViewController:ServiceLayerDelegate{
    func handleSuccess(response list: [Any]?) {
        let moviesArray = list as! [Movie]
        movieList = moviesArray
        tableView.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func handleFailure(error: Error?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
//UITableViewDataSource
extension AllMoviesViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = "Cell"
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! TableViewCell
        guard let movie = movieList?[indexPath.row] else {
            return cell
        }
        cell.movieName.text = movie.name
        cell.movieDuration.text = movie.duration
        cell.desc.text = movie.description
        cell.rank.text = "Rank : \(movie.rank!)"
        if let url = URL(string :String(format: Constants.imageUrl, Constants.getRandomHexinString(), Constants.getRandomHexinString())) {
            cell.setImage(withUrl: url)
            print(url)
        }
        return cell
    }
}

//UITableViewDelegate
extension AllMoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = movieList?.count else{
            return 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetailsViewController.movie = movieList?[indexPath.row]
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
