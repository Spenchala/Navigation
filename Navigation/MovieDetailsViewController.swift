//
//  MovieDetailsViewController.swift

//
//  Created by Sandeep Penchala on 3/12/17.
//  Copyright © 2017 Sandeep Penchala. All rights reserved.
//

import Foundation
import UIKit
class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var genresTextView: UITextView!
    @IBOutlet weak var actorsTextView: UITextView!
    @IBOutlet weak var directorLabel: UILabel!
    var movie:Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {
            return
        }
        
        directorLabel.text = "Director : \(movie.director!)"
        let actors = movie.actors?.joined(separator: "\n")
        actorsTextView.text = "Actors : \(actors!)"
        
        let genres = movie.genres?.joined(separator: "\n")
        genresTextView.text = "Genres : \(genres!)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
