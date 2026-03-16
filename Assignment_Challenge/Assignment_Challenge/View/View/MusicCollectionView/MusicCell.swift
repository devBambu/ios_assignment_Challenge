//
//  MusicListCell.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/13/26.
//

import UIKit
import SnapKit
import Kingfisher

final class MusicCell: UICollectionViewCell {
    static let id = "MusicListCell"
    
    let albumImageView = UIImageView()
    let titleLabel = UILabel() // 곡 제목
    let artistLabel = UILabel() // 가수
    let collectionLabel = UILabel() // 앨범명
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttributes() {
        albumImageView.kf.indicatorType = .activity
        albumImageView.contentMode = .center
        albumImageView.backgroundColor = .systemGray4
        albumImageView.layer.cornerRadius = 10
        albumImageView.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 1

        artistLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        collectionLabel.font = .systemFont(ofSize: 12)
        collectionLabel.textColor = .secondaryLabel
    }
    
    private func setLayout() {
        let songLabelStack = UIStackView(vertical: [titleLabel, artistLabel, collectionLabel])
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(songLabelStack)

        albumImageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
        }
        
        songLabelStack.snp.makeConstraints {
            $0.centerY.equalTo(albumImageView)
            $0.leading.equalTo(albumImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

extension MusicCell {
    func configure(with music: Music) {
        titleLabel.text = music.title
        artistLabel.text = music.artist
        collectionLabel.text = music.collection
        
        // 이미지
        let imageUrl = URL(string: music.artworkUrl60 ?? "")
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .secondaryWhite) // placeholder 이미지 config

        albumImageView.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(systemName: "music.note", withConfiguration: config), // 이미지를 가져오지 못했을 경우 나타낼 이미지
            options: [.transition(.fade(1.2))] // 1.2초 내에 이미지를 가져오지 못하면 애니메이션 표출
        )
    }
}
