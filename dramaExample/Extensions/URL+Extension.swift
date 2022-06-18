//
//  URL+Extension.swift
//  dramaExample
//
//  Created by bro on 2022/06/18.
//

import Foundation

extension URL {
    static let baseURL = "https://api.themoviedb.org/3"
    
    static func searchTvShowsURL(text: String) -> URL {
        return URL(string: "\(baseURL)/search/tv?api_key=\(APIKEY().apiKey)&language=ko-KR&query=\(text)&region=ko-KR")!
    }
    
    static func detailURL(id: Int) -> URL {
        return URL(string: "\(baseURL)/tv/\(id)?api_key=\(APIKEY().apiKey)&language=ko-KR")!
    }
}
