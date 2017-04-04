import Alamofire
import SwiftyJSON

protocol ServiceLayerDelegate: class {
    func handleSuccess(response list: [Any]?)
    func handleFailure(error: Error?)
}
class ServiceLayer {
    
    //MARK:- Properties
    weak var delegate: ServiceLayerDelegate?
    //MARK:- Methods
    func fetchAllMovies() {
        let movieListEndpoint = Constants.allMoviesUrl
        let parameters: Parameters = ["authToken":Constants.authToken]
        Alamofire.request(movieListEndpoint, method: .get, parameters: parameters, encoding: JSONEncoding(options: []), headers: nil)
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: {[weak self] response in
                switch response.result {
                case .success(let data):
                    self?.processAllMoviesList(json: JSON(data: data))
                    return
                case .failure(let error):
                    self?.delegate?.handleFailure(error: error)
                    return
                }
                }
        )
    }
    
    
    func fetchMoviesByRank(startRankIndex: Int, numberOfMovies: Int) {
        let movieListEndpoint = Constants.moviesByRankUrl
        let parameters: Parameters = ["authToken":Constants.authToken, "startRankIndex": startRankIndex, "numMovies":numberOfMovies]
        Alamofire.request(movieListEndpoint, method: .get, parameters: parameters, encoding: JSONEncoding(options: []), headers: nil)
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: {[weak self] response in
                switch response.result {
                case .success(let data):
                    self?.processMoviesByRank(json: JSON(data: data))
                    return
                case .failure(let error):
                    self?.delegate?.handleFailure(error: error)
                    return
                }
                }
        )
    }
    
    
    func fetchMoviesByIds(ids:[Int]) {
        let movieListEndpoint = Constants.moviesByRankUrl
        let parameters: [String: AnyObject] = ["authToken":Constants.authToken as AnyObject, "movieIds": ids as AnyObject]
        Alamofire.request(movieListEndpoint, method: .get, parameters: parameters, encoding: JSONEncoding(options: []), headers: nil)
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: {[weak self] response in
                switch response.result {
                case .success(let data):
                    self?.processMoviesByRank(json: JSON(data: data))
                    return
                case .failure(let error):
                    self?.delegate?.handleFailure(error: error)
                    return
                }
                }
        )
    }
    
    
    fileprivate func processMoviesByRank(json: JSON) {
        
        guard let jsonList = json.array else {
            self.delegate?.handleFailure(error: nil)
            return
        }
        var movies = [MovieByRank]() // model
        for movie in jsonList {
            var movieObjbyRank = MovieByRank()
            movieObjbyRank.id           =  movie["Id"].int
            movieObjbyRank.rank         =  movie["Rank"].int
            movieObjbyRank.name         =  movie["Name"].string
            movies.append(movieObjbyRank)
        }
        self.delegate?.handleSuccess(response: movies)
    }
    
    fileprivate func processAllMoviesList(json: JSON) {
        
        guard let jsonList = json.array else {
            self.delegate?.handleFailure(error: nil)
            return
        }
        var movies = [Movie]() // model
        for movie in jsonList {
            var movieObj = Movie()
            movieObj.id           =  movie["Id"].int
            movieObj.rank         =  movie["Rank"].int
            movieObj.name         =  movie["Name"].string
            movieObj.duration     =  movie["Duration"].string
            movieObj.description  =  movie["Description"].string
            movieObj.director     =  movie["Director"].string
            movieObj.genres       =  movie["Genres"].arrayObject as? [String]
            movieObj.actors       =  movie["Actors"].arrayObject as? [String]
            movies.append(movieObj)
        }
        self.delegate?.handleSuccess(response: movies)
    }
}
