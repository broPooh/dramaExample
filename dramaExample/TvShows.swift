//
//  TvShows.swift
//  dramaExample
//
//  Created by bro on 2022/06/18.
//

import Foundation

struct TvShows: Codable {
    let results: [TvShow]
}

struct TvShow: Codable {
    let id: Int
    let name: String
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backdropPath = "backdrop_path"
    }
}
