//
//  RepositroryDescriptionCell.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 07.02.2021.
//
import UIKit

class RepositoryDescriptionCell: UICollectionViewCell {
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
    return label
  }()
  
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
