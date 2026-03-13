//
//  MusicListCell.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/13/26.
//

import UIKit
import SnapKit

final class MusicListCell: UICollectionViewListCell {
    static let id = "MusicListCell"
    
    let albumImageView = UIImageView()
    let titleLabel = UILabel()
    let artistLabel = UILabel()
    let collectionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttributes() {
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .secondaryWhite)
        albumImageView.image = UIImage(systemName: "music.note", withConfiguration: config) // 이미지 기본값 - 음표 이미지
        albumImageView.contentMode = .center
        albumImageView.backgroundColor = .systemGray4
        
        titleLabel.font = .boldSystemFont(ofSize: 16)

        artistLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        collectionLabel.font = .systemFont(ofSize: 12)
        collectionLabel.textColor = .secondaryLabel
    }
    
    private func setLayout() {
        contentView.addSubview(albumImageView)

    }
}

extension MusicListCell {
    private func makeLabelStack() {
        
    }
}
