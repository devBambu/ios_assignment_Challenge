//
//  MusicHeaderView.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/13/26.
//
import UIKit
import SnapKit

final class MusicHeaderView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
        }
        
        secondaryLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MusicHeaderView {
    func configure(with: Section) {
        
    }
}
