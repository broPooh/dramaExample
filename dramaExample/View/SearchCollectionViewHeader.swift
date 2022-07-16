//
//  SearchCollectionViewHeader.swift
//  dramaExample
//
//  Created by bro on 2022/06/18.
//

import UIKit

class SearchCollectionViewHeader: UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
            
    var textLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 및 TV 프로그램"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
