//
//  MovieController.swift
//  MovieSearch
//
//  Created by John Tate on 9/7/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static let shared = MovieController()
    
    private init() {}
    
    var movies: [Movie] = []
    
    // MARK: - Properties
    let baseURLString = "https://api.themoviedb.org/3/search/movie"
    let api_key: String = "32a7740d7e459ee84e78297b1fa1288c"
    
    func searchForMovies(searchText: String, completion: @escaping ([Movie]?) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else {
            fatalError("Bad base URL")
        }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let queryItem1 = URLQueryItem(name: "api_key", value: api_key)
        let queryItem2 = URLQueryItem(name: "query", value: searchText)
        components?.queryItems = [queryItem1, queryItem2]
        
        guard let url = components?.url else { completion([]); return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                if let error = error {
                    print("Error with dataTask: \(#function) \(error) \(error.localizedDescription)")
                    completion([]); return
                }
                
                guard let data = data else { completion([]); return }
            
                let moviesArray = try JSONDecoder().decode(JsonDictionary.self, from: data).results
                self.movies = moviesArray
                completion(moviesArray)
                
            } catch let error {
                print("Error with JSONDecoder: \(error) \(error.localizedDescription)")
                completion([]); return
            }
        }.resume()
    }
    
    func fetchPoster(movie: Movie, completion: @escaping (UIImage?) -> Void) {
        
        //The image URL is different:
        // http://image.tmdb.org/t/p/w500/(imageEndpoint)
        // where /(imageEndpoint) is poster in our movie object
        
        let baseImageUrl = "http://image.tmdb.org/t/p/w500"
        let imageEndpoint = movie.poster
        let imageURL = baseImageUrl + imageEndpoint
        print(imageURL)
        
        guard let urlString = URL(string: imageURL) else { completion(nil); return }
        
        URLSession.shared.dataTask(with: urlString) { (data, _, error) in
            
            do {
                if let error = error { throw error }
                
                guard let data = data else { throw NSError() }
                
                let image = UIImage(data: data)
                completion(image)
                
            } catch let error {
                print("Error fetching image \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            
        }.resume()
    }
}
