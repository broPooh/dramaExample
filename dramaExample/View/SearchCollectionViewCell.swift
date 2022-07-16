//
//  SearchCollectionViewCell.swift
//  dramaExample
//
//  Created by bro on 2022/06/18.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchCollectionViewCell"
        
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 3
        return image
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage(tvShow: TvShow) {
        let imageUrl = "https://image.tmdb.org/t/p/original/\(tvShow.backdropPath ?? "")"
        postImageView.setImage(imageUrl: imageUrl)
    }
    
}
