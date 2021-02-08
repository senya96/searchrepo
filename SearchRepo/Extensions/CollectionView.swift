//
//  CollectionView.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 08.02.2021.
//

import Foundation
import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String, color: UIColor = .black) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Saira-Regular", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
