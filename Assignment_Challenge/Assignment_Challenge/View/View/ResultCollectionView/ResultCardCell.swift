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
    
    let noteView = UIView()
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
        
        noteView.backgroundColor = randomBrightColor()
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        
        secondaryLabel.font = .systemFont(ofSize: 12, weight: .medium)
        secondaryLabel.textColor = .secondaryLabel
        
        artworkImageView.contentMode = .center
        artworkImageView.layer.cornerRadius = 10
        artworkImageView.clipsToBounds = true
        artworkImageView.snp.makeConstraints {
            $0.width.height.equalTo(35)
        }
        
        artworkImageView.kf.indicatorType = .activity // 이미지를 가져오는 동안 애니메이션 표출 옵션
    }
    
    private func setLayout() {
        let songBackgroundView = UIView()
        songBackgroundView.backgroundColor = .secondaryWhite
        
        let songlabelStack = UIStackView(vertical: [titleLabel, secondaryLabel])
        
        let songStack = UIStackView(horizontal: [artworkImageView, songlabelStack])
        
        contentView.addSubview(noteView)
        contentView.addSubview(songBackgroundView)
        
        noteView.addSubview(noteImageView)
        songBackgroundView.addSubview(songStack)
        
        noteImageView.snp.makeConstraints {
            $0.width.height.equalToSuperview().multipliedBy(0.4)
            $0.center.equalToSuperview()
        }
        
        noteView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(songBackgroundView.snp.top)
        }
        
        songStack.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        songBackgroundView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.25)
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

extension ResultCardCell {
    // 랜덤 컬러(밝은 색) 생성
    private func randomBrightColor() -> UIColor {
        let hue = CGFloat.random(in: 0...1)
        let saturation = CGFloat.random(in: 0.4...0.8)
        let brightness = CGFloat.random(in: 0.8...1.0)
        
        return UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: 1
        )
    }
}

