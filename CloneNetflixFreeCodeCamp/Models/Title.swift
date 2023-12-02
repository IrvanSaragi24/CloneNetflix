//
//  Movie.swift
//  CloneNetflixFreeCodeCamp
//
//  Created by Irvan P. Saragi on 02/12/23.
//

import Foundation

struct TrendingTitleResponse : Codable{
    let results: [Title]
}

struct Title: Codable{
    let adult: Bool
    let id : Int
    let media_type : String?
    let original_name : String?
    let original_title : String?
    let poster_path : String?
    let overview : String?
    let vote_count: Int
    var release_date : String?
    let vote_average : Double
    let genre_ids : [Int]
}


