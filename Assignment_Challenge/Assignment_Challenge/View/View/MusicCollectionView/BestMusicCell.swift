//
//  BestMusicCell.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/12/26.
//

import UIKit
import SnapKit

final class BestMusicCell: UICollectionViewCell {
    static let id = "BestMusicCell"
    
    let noteView = UIView()
    let albumImage = UIImageView()
    let titleLabel = UILabel()
    let artistLabel = UILabel()
    let noteImage: UIImage? = {
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .secondaryWhite)
        return UIImage(systemName: "music.note", withConfiguration: config)
    }()
    
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
        
        albumImage.image = noteImage
        albumImage.contentMode = .center
        albumImage.backgroundColor = .systemGray4
        albumImage.layer.cornerRadius = 10
        albumImage.clipsToBounds = true
        albumImage.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        
        artistLabel.font = .systemFont(ofSize: 12, weight: .medium)
        artistLabel.textColor = .secondaryLabel
    }
    
    private func setLayout() {
        let noteImageView = UIImageView(image: noteImage)
        noteImageView.contentMode = .scaleAspectFit
        
        let songBackgroundView = UIView()
        songBackgroundView.backgroundColor = .secondaryWhite
        
        let songlabelStack = makeLabelStack(of: [titleLabel, artistLabel])
        let songStack = makeSongStack(of: [albumImage, songlabelStack])
        
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

extension BestMusicCell {
    func configure(with music: Music) {
//        albumImage.image = UIImage
        titleLabel.text = music.title
        artistLabel.text = music.artist
    }
}

extension BestMusicCell {
    // 곡 정보 스택 생성
    private func makeSongStack(of views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }
    
    // 곡 정보 레이블 스택 생성
    private func makeLabelStack(of views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }
    
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
