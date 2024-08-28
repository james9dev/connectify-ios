## Connectify
- 온라인 소셜 데이팅 서비스
- 소셜 인증
- 회원 검증
- 이미지 검증
- 회원 추천, 매칭
- 인앱 결제, 상품 구독

![connectify_screenshot_001](https://github.com/user-attachments/assets/22c01118-f9b3-4326-9551-8f73c4fa23c1)
![connectify_screenshot_002](https://github.com/user-attachments/assets/3318c0e7-8acf-420a-8887-c2b86492bc3a)
![connectify_screenshot_003](https://github.com/user-attachments/assets/25b25cd9-886a-4c58-98ac-57fd89a7be64)

## Architecture
- **SwiftUI와 TCA, TCACoordinators를 활용한 프로젝트**
- **[The Composable Architecture(TCA)](https://github.com/pointfreeco/swift-composable-architecture)**
   <br>TCA는 값 타입에 기반하여 각 객체를 모듈화하고 애플리케이션 전체의 상태를 일관적으로 관리할 수 있게 표준을 제안한다. 최소 기능 단위로 구성된 각 Unit 객체는 다른 기능으로의 결합-분리를 쉽게 할 수 있다. TCA를 활용한 프로젝트는 일관적인 방식으로 애플리케이션의 상태를 관리할 수 있고, 테스트의 유연성을 확보할 수 있다.
- **[TCACoordinators](https://github.com/johnpatrickmorgan/TCACoordinators)**
   <br> Composable Architecture(TCA)를 사용하여 SwiftUI에서 탐색에 대한 유연한 접근 방식을 제공한다. 이를 통해 단일 상태 조각으로 복잡한 탐색 및 프레젠테이션 흐름을 관리할 수 있으며, 이를 상위 수준 코디네이터로 끌어올릴 수 있다. 이 패턴을 사용하면 앱의 탐색 흐름 내에서 컨텍스트에 대한 제로 널리지 상태의 격리된 화면 기능을 작성할 수 있다.

## App Tech Stack
- iOS
- Swift
- SwiftUI
- TCA, TCACoordinators
- SPM
- Alamofire, Kingfisher, Firebase
- Kakao, AdMob


## Server
[Server Github Link 'connectify-api-server'](https://github.com/james9dev/connectify-api-server)
- Java, Spring boot 3.0, JPA, MariaDB, AWS
