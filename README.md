# Challenge
> **실전중심의 패턴 및 RxSwift 적용**

이번 과제는 실제 기업 과제 형식을 바탕으로 한 한층 더 실전 중심의 과제입니다.

실제 기업의 채용 과제에서는 상세하고 구체적인 요구사항이 아닌, 기본적이고 간략한 최소 요구사항만을 제시하는 것이 일반적입니다. 지원자가 스스로 문제를 해석하고 주도적으로 해결책을 모색하는 능력을 평가하기 위함입니다. 

App Store 앱을 참고하여 제시된 최소 요구사항을 충족함과 동시에 추가 기능 구현을 통해 창의성을 발휘해주세요. 

**기업 과제에서는 과제의 요구사항을 준수하되 여러분들의 강점을 최대한 어필할 수 있도록 결과물을 완성해야합니다.**

요구사항을 꼼꼼히 분석하신 후 구현 과정에서 본인만의 기술적 강점과 역량이 돋보일 수 있는 방안을 고려해 개발해 주시길 바랍니다.

<br>

# 📅 프로젝트 기간

2026.03.11. ~ 2026.03.19.

<br>

# 🏗 아키텍처

### MVVM

**MVVM을 적용한 이유**
- View와 비즈니스 로직 분리
- RxSwift 학습을 위함 (데이터 바인딩 등)

### Coordinator Pattern

**Coordinator 패턴을 적용한 이유**
- View의 네비게이션 로직 분리
- 화면 전환 시 데이터 전달의 책임 담당
: VC 간의 직접적인 접근이 필요 없음
- 의존성 주입 담당

<br>

# 📂 프로젝트 폴더 구조

```
Assignment_Challenge
└── Assignment_Challenge
    ├── App
    │   ├── AppCoordinator.swift
    │   ├── AppDelegate.swift
    │   └── SceneDelegate.swift
    │
    ├── Extension
    │   ├── UIColor.swift
    │   ├── UIImageView.swift
    │   └── UIStackView.swift
    │
    ├── Model
    │   ├── Music.swift
    │   ├── NetworkService.swift
    │   ├── Podcast.swift
    │   ├── Response.swift
    │   └── TvShow.swift
    │
    ├── View
    │   ├── Controller
    │   │   ├── HomeViewController.swift
    │   │   └── ResultViewController.swift
    │   │
    │   └── View
    │       ├── MusicCollectionView
    │       │   ├── MusicCardCell.swift
    │       │   ├── MusicCell.swift
    │       │   ├── MusicCollectionView.swift
    │       │   └── MusicHeaderView.swift
    │       │
    │       ├── ResultCollectionView
    │       │   ├── ResultCardCell.swift
    │       │   ├── ResultCollectionView.swift
    │       │   └── ResultHeaderView.swift
    │       │
    │       ├── HomeView.swift
    │       └── ResultView.swift
    │
    └── ViewModel
        ├── HomeViewModel.swift
        └── ViewModelProtocol.swift
```

### 구조별 역할
- **Model** : 앱에서 사용하는 데이터 모델 및 네트워크(모델, 네트워크 서비스)
- **Extension** : 공통 유틸리티 사용을 위한 확장 선언 파일 
- **View**
  <br>
    : View - UI 구성 요소 관리
  <br>
    : ViewController - ViewModel과의 바인딩
- **ViewModel** : 비즈니스 로직 처리  

<br>

# 🧰 기술 스택

### Language
- Swift

### Architecture
- MVVM
- Coordinator

### Library
| Library | 역할 |
|---|---|
| SnapKit | AutoLayout |
| RxSwift | 반응형 UI |
| Alamofire | 네트워크 통신 |
| Kingfisher | 이미지 캐싱 |
| AVFoundation | 미디어 재생 |

<br>

# ⭐ 핵심 기능

## 🏠 Home 화면
계절별 연관있는 음악들을 표시합니다.
Spring 섹션에서는 카드 셀 클릭 시 미리듣기 기능을 제공합니다.

<br>

## 🔍 검색 결과 화면
SearchBar에 입력한 검색어에 따라 검색 결과(TvShow, Podcast)를 표시합니다.

## 🎥 시연 영상

https://github.com/user-attachments/assets/0e0e7486-008f-45e7-a110-d5756d05265a

# 🛠 Troubleshooting
[searchText 이벤트가 중복 방출되는 현상](https://velog.io/@bambu113/%EB%82%B4%EC%9D%BC%EB%B0%B0%EC%9B%80%EC%BA%A0%ED%94%84-260317-TIL-Coordinator-%ED%8C%A8%ED%84%B4-%ED%8A%B8%EB%9F%AC%EB%B8%94%EC%8A%88%ED%8C%85)


<br>

# 🚀 향후 개선 사항

- 에러 처리 핸들링
- onError 처리 시 스트림 중지 버그 개선
- 상세 화면 구현
