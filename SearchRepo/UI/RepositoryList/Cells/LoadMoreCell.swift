//
//  LoadingIndicatorCell.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 08.02.2021.
//

import UIKit

class LoadMoreCell: UICollectionViewCell {
    static let font = AppFont()
    static let inset = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
    
    static func cellSize(width: CGFloat, text: String) -> CGSize {
        return TextSize.size(text, font: RepositoryDescriptionCell.font, width: width, insets: RepositoryDescriptionCell.inset).size
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = RepositoryDescriptionCell.font
        label.textColor = .white
        label.textAlignment = .center
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView()
        activity.color = .white
        return activity
    }()
    
    func startAnimating(){
        label.text = ""
        activityIndicator.startAnimating()
        activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2);
        self.contentView.addSubview(activityIndicator)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(hex6: 0x0c1f3f)
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds.inset(by: RepositoryDescriptionCell.inset)
    }
}
