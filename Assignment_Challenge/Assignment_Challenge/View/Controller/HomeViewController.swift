//
//  ViewController.swift
//  Assignment_Challenge
//
//  Created by t2025-m0143 on 3/11/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import AVFoundation

class HomeViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    let viewModel: HomeViewModel
    
    private let disposeBag = DisposeBag()
    private let homeView = HomeView()
    
    let searchKeywordRelay = BehaviorRelay<String>(value: "")
    private var musicPlayer: AVPlayer?
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        bind()
    }
    
    //MARK: init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: bind
    private func bind() {
        if let searchBar = navigationItem.searchController?.searchBar {
            searchBar.rx.text.orEmpty
                .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
                .bind(to: searchKeywordRelay)
                .disposed(by: disposeBag)
        }
        
        let input = HomeViewModel.Input(
            fetchData: .just(()),
            searchText: .empty(),
//            playMusic: playMusic
        )
        
        let output = viewModel.transform(input)
        
        let spring = output.spring
            .map { musics in
                musics.map {
                    MusicCollectionView.Item.spring($0)
                }
            }
        
        let summer = output.summer
            .map { musics in
                musics.map {
                    MusicCollectionView.Item.summer($0)
                }
            }
        
        let autumn = output.autumn
            .map { musics in
                musics.map {
                    MusicCollectionView.Item.autumn($0)
                }
            }
        
        let winter = output.winter
            .map { musics in
                musics.map {
                    MusicCollectionView.Item.winter($0)
                }
            }
        
        // 컬렉션뷰 바인딩
        Observable
            .combineLatest(spring, summer, autumn, winter)
            .subscribe(
                onNext: { [homeView] in
                homeView.setSnapshot(with: [$0, $1, $2, $3])
            },
                onError: { [weak self] error in
                    self?.showAlert(title: "Network Error", message: "데이터를 가져올 수 없습니다.\nError: \(error)")
            })
            .disposed(by: disposeBag)
        
        // 미리듣기 관련
        let playMusic = homeView.collectionView.rx.itemSelected
            .map { [weak self] indexPath in
                self?.homeView.fetchItem(of: indexPath)
            }
//        
//        playMusic
//            .bind(onNext: { [weak self] item in
//                switch item {
//                case .spring(let music):
//                
//                default:
//                    break
//                }
//            })
        
        playMusic
            .subscribe(
                onNext: { [weak self] item in
                    switch item {
                    case .spring(let music):
                        self?.playPreview(of: music)
                    default:
                        break
                    }
                },
                onError: { [weak self] error in
                    print(error)
                })
            .disposed(by: disposeBag)

        
    }
}

extension HomeViewController {
    private func setNavigationController() {
        self.title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.preferredSearchBarPlacement = .stacked
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        
        present(alert, animated: true)
    }
}

extension HomeViewController {
    private func playPreview(of music: Music) {
        guard let url = URL(string: music.previewUrl ?? "") else { return }
        
        let item = AVPlayerItem(url: url)
        
        if musicPlayer?.currentItem == item {
            if musicPlayer?.timeControlStatus == .paused {
                musicPlayer?.seek(to: .zero) // 음원의 처음 부분으로 돌아감
                musicPlayer?.play()
            } else if musicPlayer?.timeControlStatus == .playing {
                musicPlayer?.pause()
            }
        } else {
            musicPlayer = AVPlayer(playerItem: item)
            musicPlayer?.play()
            musicPlayer?.actionAtItemEnd = .pause
        }
        
    }
    
    private func stopPreview(of music: Music) {
        musicPlayer?.pause()
        musicPlayer?.seek(to: .zero)
    }
}
