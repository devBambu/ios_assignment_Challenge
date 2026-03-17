//
//  UIImageView.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/16/26.
//

import UIKit
import SnapKit
import Kingfisher

extension UIImageView {
    // 이미지 캐싱 활용
    func setImage(with urlString: String) {
        self.kf.indicatorType = .activity // 이미지 다운로드가 진행중일 경우 인디케이터 표시 옵션
        
        let retry = DelayRetryStrategy(maxRetryCount: 1, retryInterval: .seconds(3)) // 이미지 다운로드 실패 시 재실행 -- 3초 뒤 1번 재실행
        let options: KingfisherOptionsInfo = [
            .retryStrategy(retry), // 재시도
            .transition(.fade(1.2)), // 1.2초 내에 이미지를 가져오지 못하면 애니메이션 표출
            .cacheOriginalImage // 원본 이미지 캐싱
        ]
        let symbolConfig = UIImage.SymbolConfiguration(hierarchicalColor: .secondaryWhite)

        
        // 캐시에서 이미지 가져오기
        ImageCache.default.retrieveImage(forKey: urlString, options: options) { [weak self] result in
            switch result {
            case .success(let cacheResult):
                if let image = cacheResult.image { // Cache Hit
                    Task { @MainActor [weak self] in
                        self?.image = image // 캐시에서 가져온 이미지 할당
                    }
                } else { // Cache Miss
                    let url = URL(string: urlString)
                    Task { @MainActor [weak self] in
                        self?.kf.setImage(
                            with: url,
                            placeholder: UIImage(systemName: "music.note", withConfiguration: symbolConfig), // 이미지 로딩 실패시 기본값
                            options: options
                        ) // url에서 가져온 이미지 할당
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
