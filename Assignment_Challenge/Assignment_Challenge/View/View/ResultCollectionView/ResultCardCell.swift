//
//  ResultCardCell.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/18/26.
//

import UIKit
import SnapKit
import Kingfisher

final class ResultCardCell: UICollectionViewCell {
    static let id = "ResultCardCell"
    
    let titleLabel = UILabel()
    let secondaryLabel = UILabel()
    let artworkImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttributes() {
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.randomPastel
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        
        secondaryLabel.font = .systemFont(ofSize: 14, weight: .medium)
        secondaryLabel.textColor = .secondaryLabel
        
        artworkImageView.contentMode = .scaleAspectFill
    }
    
    private func setLayout() {
        let labelStack = UIStackView(vertical: [secondaryLabel, titleLabel])
        
        contentView.addSubview(artworkImageView)
        contentView.addSubview(labelStack)
        
        artworkImageView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
        
        labelStack.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalTo(artworkImageView.snp.top).offset(5)
        }
    }
}

extension ResultCardCell {
    func configure(with music: Music) {
        titleLabel.text = music.title
        secondaryLabel.text = music.artist
        artworkImageView.setImage(with: music.artworkUrl60 ?? "")
    }
}

