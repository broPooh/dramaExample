//
//  Seasons.swift
//  dramaExample
//
//  Created by bro on 2022/06/18.
//

import Foundation

struct Seasons: Codable {
    var seasons: [Season]?
}


struct Season: Codable {
    var airDate: String?
    var episodeCount: Int?
    var id: Int?
    var overview: String?
    var posterPath: String?
    var seasonNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case overview
        case id
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

