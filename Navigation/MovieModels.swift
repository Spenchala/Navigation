import Foundation
import UIKit

struct Movie
 {
    var id: Int?
    var rank: Int?
    var name: String?
    var duration: String?
    var description: String?
    var director: String?
    var genres: [String]?
    var actors: [String]?
}

struct MovieByRank {
    var id:Int?
    var rank:Int?
    var name: String?
}

struct Constants {
     static let baseUrl = "https://interview.zocdoc.com/api/1/FEE"
     static let allMoviesUrl = baseUrl + "/AllMovies"
     static let moviesByRankUrl = baseUrl + "/MoviesByRank"
     static let movieDetails = baseUrl + "/MovieDetails"
     static let authToken = "3b502b3f-b1ff-4128-bd99-626e74836d9c"
     static let imageUrl = "http://placehold.it/150/%@/%@"
    static let homePage = "https://www.google.com/"
    
    static func getRandomHexinString() -> String{
        let randomRed = String(format: "%2x",Int(CGFloat(drand48())*255))
        let randomGreen = String(format: "%2x",Int(CGFloat(drand48())*255))
        let randomBlue = String(format: "%2x",Int(CGFloat(drand48())*255))
        return randomRed + randomGreen + randomBlue
    }
}
