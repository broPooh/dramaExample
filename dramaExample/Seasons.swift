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


struct Season: Codable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var airDate: String?
    var episodeCount: Int?
    var id: Int?
    var overview: String?
    var posterPath: String?
    var seasonNumber: Int?
    let identifier = UUID()

    
    enum CodingKeys: String, CodingKey {
        case overview
        case id
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

