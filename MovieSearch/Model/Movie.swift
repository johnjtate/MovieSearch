//
//  Movie.swift
//  MovieSearch
//
//  Created by John Tate on 9/7/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

struct JsonDictionary: Decodable {
    
    let results: [Movie]
    
}

struct Movie: Decodable {
    
    let title: String
    let rating: Double
    let poster: String 
    let summary: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case poster = "poster_path"
        case summary = "overview"
    }
}
