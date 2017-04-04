//
//  TableViewCell.swift

//
//  Created by Sandeep Penchala on 3/11/17.
//  Copyright © 2017 Sandeep Penchala. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var rank: UILabel!
    
    func setImage(withUrl url: URL){
        movieImage.af_setImage(
            withURL: url,
            placeholderImage: nil,
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: movieImage.bounds.size, radius: 20.0),
            imageTransition: .crossDissolve(0.5)
        )
    }
}
