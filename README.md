# 🐣 계란주의보
<img width="257" height="136" alt="스크린샷 2026-01-09 오전 12 29 23" src="https://github.com/user-attachments/assets/b43ab4ef-564e-4f16-b2d7-0b3b5224af8d" />


> 계란주의보: 주제 및 예시사진
[![Swift](https://img.shields.io/badge/Swift-5-orange.svg)]()
[![Xcode](https://img.shields.io/badge/Xcode-26.0.1-blue.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)]()

---

<br>

## 👥 멤버
| 리야 | 쵸파 | 큐큐 |  
|:------:|:------:|:------:|  
| <img src="https://github.com/user-attachments/assets/71d51935-82fc-4225-b2dc-3cebbd426a5c" width="200" height="300" alt="IMG_6758" /> | <img src="https://github.com/user-attachments/assets/95c98c91-e35a-40c4-a83f-b6b627d1d14f" width="200" height="300" /> | <img src="https://github.com/user-attachments/assets/17b81e2b-766d-4358-a1ef-74052ee39027" width="200" height="300" alt="IMG_6758" /> |
| PL | FE | FE |  
| [GitHub](https://github.com/guingguing) | [GitHub](https://github.com/BeginnerKJS) | [GitHub](https://github.com/bella411) |

<br>


## 📱 소개

> 소개란

<br>

## 📆 프로젝트 기간
- 전체 기간: `2026.06.16. - 2026.06.22.`
- 개발 기간: `2026.06.16. - 2026.06.22.`

<br>

## 🤔 요구사항
For building and running the application you need:

iOS 26.0 <br>
Xcode 26.5 <br>
Swift 5

<br>

# 🥚 SunEgg - 자외선 케어 앱

> UMC 10기 해커톤 Team B iOS 레포지토리
> 
> 현재 위치의 자외선 지수와 날씨를 기반으로 맞춤형 알림을 제공하고, 선크림 도포 상태를 귀여운 계란 캐릭터로 시각화하는 iOS 앱입니다.

<br>

## 🏗 Architecture

- MVVM 기반 구조
- Moya + Alamofire 네트워크 레이어 분리
- CoreLocation 기반 실시간 위치 처리
- UNUserNotificationCenter 로컬 알림 관리
- Feature 단위 모듈화 구조

<br>

## 🔎 기술 스택

### 🖥 Development
<div align="left">
<img src="https://img.shields.io/badge/SwiftUI-42A5F5?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Alamofire-FF5722?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Moya-8A4182?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/CoreLocation-000000?style=for-the-badge&logo=apple&logoColor=white" />
<img src="https://img.shields.io/badge/UserNotifications-34C759?style=for-the-badge&logo=apple&logoColor=white" />
</div>

### ⚙️ Environment
<div align="left">
<img src="https://img.shields.io/badge/Xcode_16-007ACC?style=for-the-badge&logo=Xcode&logoColor=white" />
<img src="https://img.shields.io/badge/iOS_16.0+-000000?style=for-the-badge&logo=apple&logoColor=white" />
<img src="https://img.shields.io/badge/Swift_5.9-F05138?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Swift_Package_Manager-FA7343?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Git-F05033?style=for-the-badge&logo=git&logoColor=white" />
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" />
</div>

### 🤝 Collaboration
<div align="left">
<img src="https://img.shields.io/badge/Notion-white?style=for-the-badge&logo=Notion&logoColor=black" />
<img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=Discord&logoColor=white" />
<img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white" />
</div>

<br>

## 👥 팀원

| 역할 | 이름 |
|:---:|:---:|
| iOS | - |
| iOS | - |
| iOS | - |
| 백엔드 | - |
| 백엔드 | - |
| 기획 | - |
| 디자인 | - |

<br>

## 🌟 핵심 기능

| 기능 | 설명 |
|:---|:---|
| 📍 현재 위치 기반 날씨 | CoreLocation으로 실시간 위치를 받아 날씨 및 자외선 지수 표시 |
| 🔔 아침 알림 | 자외선 지수에 따라 맞춤형 외출 전 알림 발송 |
| 🥚 계란 캐릭터 | 선크림 도포 여부와 시간 경과에 따라 계란 색상 변화 |
| ☀️ 외출 모드 | 외출 시작/종료 관리 및 자외선 누적 노출 추적 |
| 🧴 선크림 리마인더 | 2~3시간 간격으로 재도포 알림 발송 |
| 🌙 자동 외출 종료 | 자외선 지수 2 이하 시 외출 모드 자동 종료 |

<br>

## 📱 서비스 플로우

```
아침 자외선 확인 → 아침 알림 발송
       ↓
앱 접속 → 홈 화면 (날씨, UV 지수, 계란 기본 상태)
       ↓
[외출 시작] → 외출 모드 전환 → 계란 색 변화 시작
       ↓
행동 입력
├── 선크림 발랐음 → 계란 하얘짐 + 2~3시간 후 재도포 알림
└── 이동 시간 입력
    ├── 발랐음 → 계란 색 변화 적게 반영
    └── 안 발랐음 → 계란 더 까맣게 변함
       ↓
외출 종료
├── [외출 종료] 직접 입력 → 홈 모드 복귀
└── 자외선 지수 2 이하 → 자동 외출 종료
```

<br>

## 🗂️ 폴더 구조

```
SunEgg
├── App
│   ├── SunEggApp.swift
│   └── AppState.swift
├── Common
│   ├── Enum
│   │   ├── UVLevel.swift
│   │   └── OutingMode.swift
│   ├── Protocol
│   └── UIComponents
│       ├── UVIndexBadge.swift
│       └── SunscreenButton.swift
├── Core
│   ├── DIContainer
│   ├── Location
│   │   └── LocationService.swift
│   ├── Notification
│   │   └── NotificationService.swift
│   ├── Navigation
│   └── Utils
├── Models
│   ├── Domain
│   │   ├── WeatherModel.swift
│   │   ├── EggState.swift
│   │   └── OutingSession.swift
│   └── DTO
│       └── WeatherResponseDTO.swift
├── Modules
│   ├── Home
│   │   ├── HomeView.swift
│   │   └── HomeViewModel.swift
│   ├── Outing
│   │   ├── OutingView.swift
│   │   ├── OutingViewModel.swift
│   │   └── EggView.swift
│   └── Onboarding
├── Service
│   ├── WeatherService.swift
│   ├── OutingStateManager.swift
│   └── NetworkCore
│       └── APIProviderStore.swift
├── Resource
│   ├── Extension
│   ├── Modifier
│   ├── UIConstants
│   └── Assets.xcassets
├── Info.plist
└── ContentView.swift
```

<br>

## ⚙️ 실행 방법

1. 레포 클론
```bash
git clone https://github.com/UMC10th-hackathon-team-B/UMC10th-hackathon-team-B-ios.git
```

2. `develop` 브랜치로 이동
```bash
cd UMC10th-hackathon-team-B-ios
git checkout develop
```

3. `Config.xcconfig` 파일에 API Key 입력 (팀 단톡방 참고)

4. Xcode에서 실행

> ⚠️ `Config.xcconfig`는 `.gitignore`에 포함되어 있어 별도 전달 필요

<br>

## 🔖 브랜치 컨벤션

### 🪵 브랜치 전략
- **main** : 출시 가능한 상태의 코드를 모아두는 브랜치 (직접 push ❌, PR로만 병합)
- **develop** : 다음 버전을 위해 개발 중인 코드를 모으는 브랜치 (기본 베이스)
- **feature** : 기능을 개발하는 브랜치 (develop에서 분기)
- **fix** : 버그를 수정하는 브랜치

### 🌿 네이밍 규칙
> **{태그}/#{이슈번호}-{기능설명}**

1. **태그**는 소문자로 작성합니다.
2. **이슈번호**는 Github Issues에 등록된 번호를 적습니다. (추적 용이)
3. **기능설명**은 짧은 영어 단어로, 띄어쓰기는 하이픈(-)으로 연결합니다.

### ✅ 사용 예시
- `feat/#1-home-view` (1번 이슈인 홈 화면 구현)
- `feat/#2-egg-animation` (2번 이슈인 계란 애니메이션 구현)
- `feat/#3-notification` (3번 이슈인 알림 기능 구현)
- `fix/#10-location-permission` (10번 이슈인 위치 권한 버그 수정)

<br>

## 📌 이슈 컨벤션
- 양식 | 이모지 커밋유형: 이슈 내용
- 예시 | ✨ FEAT: 계란 캐릭터 애니메이션 구현

<br>

## 🌀 코딩 컨벤션

### 선언 네이밍
1. **변수 & 상수**
   - *카멜 케이스(camelCase) 사용*
   - 의미 있고 설명적인 이름 사용
   - 너무 짧거나 모호한 이름 피하기

2. **함수 & 메서드**
   - *동사로 시작*
   - 함수의 역할을 명확히 설명

3. **클래스 & 구조체 & 열거형**
   - *대문자로 시작 (PascalCase)*

4. **타입 추론**
```swift
// Bad: 불필요한 타입 명시
let uvIndex: Double = 7.0

// Good: 타입 추론 사용
let uvIndex = 7.0
```

5. **오류 처리**
```swift
enum NetworkError: Error {
    case badURL
    case noData
}

func fetchWeather(lat: Double, lon: Double) async throws -> WeatherModel {
    guard let url = URL(string: baseURL) else {
        throw NetworkError.badURL
    }
    // ...
    throw NetworkError.noData
}

// 사용 예시
do {
    let weather = try await fetchWeather(lat: 37.5, lon: 127.0)
    print("날씨 데이터 수신 완료")
} catch NetworkError.badURL {
    print("잘못된 URL")
} catch {
    print("알 수 없는 오류")
}
```

### 공백
1. 들여쓰기는 tab 대신 띄어쓰기 4개로

2. 연산자 주변 공백
```swift
// 좋은 예
let eggLevel = uvIndex * 0.1

// 나쁜 예
let eggLevel=uvIndex*0.1
```

3. 중괄호는 엔터 없이 열기
```swift
// 좋은 예
func applyingSunscreen() {
    // ...
}

// 나쁜 예
func applyingSunscreen()
{
    // ...
}
```

4. 콜론 뒤에만 공백을 둡니다.
```swift
let uvLevel: Double
```

<br>

## 📁 PR 컨벤션

PR 시, 템플릿이 등장한다. 해당 템플릿에서 작성해야 할 부분은 아래와 같다.
1. `PR 유형 작성` : 어떤 변경 사항이 있었는지 [] 괄호 사이에 x를 입력하여 체크
2. `작업 내용 작성` : 작업 내용에 대해 자세하게 작성
3. `추후 진행할 작업` : PR 이후 작업할 내용에 대해 작성
4. `리뷰 포인트` : 본인 PR에서 꼭 확인해야 할 부분을 작성

#### 🌟 태그 종류 (커밋 컨벤션과 동일)
- `Feat` : 새로운 기능 추가
- `Fix` : 버그 수정
- `Design` : UI/UX 디자인 변경
- `!BREAKING CHANGE` : 커다란 API 변경의 경우
- `!HOTFIX` : 급하게 치명적인 버그를 고쳐야 하는 경우
- `Style` : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
- `Refactor` : 코드 리팩토링 (기능 변경 없음, 코드 구조 개선)
- `Comment` : 필요한 주석 추가 및 변경
- `Docs` : 문서 수정
- `Test` : 테스트 코드 추가, 테스트 리팩토링
- `Chore` : 빌드 업무 수정, 패키지 매니저 수정, 프로젝트 세팅
- `Rename` : 파일 혹은 폴더명을 수정하거나 옮기는 경우
- `Remove` : 파일을 삭제하는 경우

### ✅ PR 예시 모음
> 🎉 [Chore] 프로젝트 초기 세팅 <br>
> ✨ [Feat] 홈 화면 UI 구현 <br>
> 🐛 [Fix] 외출 모드 전환 오류 수정 <br>
> 💄 [Design] 계란 캐릭터 색상 조정 <br>
> 📝 [Docs] README에 프로젝트 소개 추가 <br>

<br>

## 📑 커밋 컨벤션

### 💬 깃모지 가이드

| 아이콘 | 코드 | 설명 | 원문 |
| :---: | :---: | :---: | :---: |
| 🐛 | bug | 버그 수정 | Fix a bug |
| ✨ | sparkles | 새 기능 | Introduce new features |
| 💄 | lipstick | UI/스타일 파일 추가/수정 | Add or update the UI and style files |
| ♻️ | recycle | 코드 리팩토링 | Refactor code |
| ➕ | heavy_plus_sign | 의존성 추가 | Add a dependency |
| 🔀 | twisted_rightwards_arrows | 브랜치 합병 | Merge branches |
| 💡 | bulb | 주석 추가/수정 | Add or update comments in source code |
| 🔥 | fire | 코드/파일 삭제 | Remove code or files |
| 🚑 | ambulance | 긴급 수정 | Critical hotfix |
| 🎉 | tada | 프로젝트 시작 | Begin a project |
| 🔒 | lock | 보안 이슈 수정 | Fix security issues |
| 🔖 | bookmark | 릴리즈/버전 태그 | Release / Version tags |
| 📝 | memo | 문서 추가/수정 | Add or update documentation |
| 🔧 | wrench | 구성 파일 추가/삭제 | Add or update configuration files |
| ⚡️ | zap | 성능 개선 | Improve performance |
| 🎨 | art | 코드 구조 개선 | Improve structure / format of the code |
| 📦 | package | 컴파일된 파일 추가/수정 | Add or update compiled files |
| 👽 | alien | 외부 API 변경 반영 | Update code due to external API changes |
| 🚚 | truck | 리소스 이동, 이름 변경 | Move or rename resources |
| 🙈 | see_no_evil | .gitignore 추가/수정 | Add or update a .gitignore file |

### 🏷️ 커밋 태그 가이드
- `Feat` : 새로운 기능 추가
- `Fix` : 버그 수정
- `Design` : 사용자 UI 디자인 변경
- `!BREAKING CHANGE` : 커다란 API 변경의 경우
- `!HOTFIX` : 급하게 치명적인 버그를 고쳐야 하는 경우
- `Style` : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
- `Refactor` : 코드 리팩토링 (기능 변경 없음, 코드 구조 개선)
- `Comment` : 필요한 주석 추가 및 변경
- `Docs` : 문서 수정
- `Test` : 테스트 코드 추가, 테스트 리팩토링
- `Chore` : 빌드 업무 수정, 패키지 매니저 수정, 프로젝트 세팅
- `Rename` : 파일 혹은 폴더명을 수정하거나 옮기는 경우
- `Remove` : 파일을 삭제하는 경우

### ✅ 커밋 예시 모음
> 🎉 [Chore] 프로젝트 초기 세팅 <br>
> ✨ [Feat] 홈 화면 날씨 카드 UI 구현 <br>
> ✨ [Feat] 계란 캐릭터 색상 애니메이션 구현 <br>
> 🐛 [Fix] 위치 권한 거부 시 크래시 수정 <br>
> 💄 [Design] 자외선 지수 배지 색상 조정 <br>
> 👽 [Feat] OpenWeatherMap API 연동 <br>
