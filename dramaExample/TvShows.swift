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

struct TvShow: Codable, Hashable {
    let id: Int
    let name: String
    let backdropPath: String?
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: TvShow, rhs: TvShow) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backdropPath = "backdrop_path"
    }
}
