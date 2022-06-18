//
//  UIImageView+Extension.swift
//  dramaExample
//
//  Created by bro on 2022/06/18.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
