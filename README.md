# 2024-NC2-M26-SpriteKit
<img width="808" alt="스크린샷 2024-06-19 오전 11 29 28" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M26-SpriteKit/assets/84498457/593f337f-5d24-4c71-9a36-1ee03c6eef8d">

## Team
|<img src="https://avatars.githubusercontent.com/u/84498457?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/113842420?v=4" width="150" height="150"/>|
|:-:|:-:|
|Luffy(테크)<br/>[@kimsangjunzzang](https://github.com/kimsangjunzzang)|Rara(디자인)<br/>[@bbang2001](https://github.com/bbang2001)|

## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About SpriteKit

SpriteKit은 Apple에서 제공하는 2D 게임 개발 프레임워크로, iOS, iPadOS, macOS, tvOS, watchOS 플랫폼에서 사용 가능하다. 
고성능 렌더링 엔진과 직관적인 API를 통해 2D 게임 및 인터랙티브 콘텐츠를 쉽고 빠르게 개발할 수 있도록 지원한다.

주요 특징
- 고성능 렌더링 : Metal 기반의 하드웨어 가속 렌더링을 통해 부드러운 애니메이션과 높은 프레임 속도를 제공.
- 다양한 기능 : 스프라이트, 텍스트, 파티클, 물리 엔진, 오디오, 비디오 등 게임 개발에 필요한 다양한 기능을 내장.
- 물리 엔진(2D) : 노드들 물리적 상호 작용, 충돌, 중력 및 제약 등 여러 2D 물리 엔진 기능들을 내장.

이를 바탕으로 2D 게임 개발, 인터렉트 콘텐츠, 애니메이션 등 여러 방면으로 활용할 수 있는 FrameWork이다.
  
## 🎯 What we focus on?
- SKSpriteNode 설정
    - 객체를 하나의 노드로 설정하여 그에 따른 상호 작용을 만들기 위한 초기 설정하였다.
- PhysicsBody
    - 객체, 즉 노드 간 물리적 상호작용을 만들기 위한 부분으로 노드 간 충돌시 그에 따른 플랫폼 삭제와 점프 반응을 구현하였다.
- Update func custom
    - 플랫폼을 밟고 올라 가면 화면이 전환 되어야하는데 그에 따른 업데이트 함수 구현을 하였다.
- CMDeviceMotion (CoreMotion)
    - Device-motion을 통한 센서값을 활용하여 기기 기울기에 따른 캐릭터의 움직임을 만들었다.
    - 유저의 원할한 게임 참여와 흥미로운 조작법으로 게임에 대한 흥미를 증진 시키기 위해 추가적으로 사용한 FrameWork이다.
- UserDefault
    - 로컬 데이터로 자신의 스코어를 저장 하며, 최고 점수를 갱신하는데 있어 흥미를 느끼게 하기 위함이다.

## 💼 Use Case
> 러너들이 가볍게 즐길 수 있도록 Apple developer Academy를 배경으로 한 점핑 게임을 만들자!

## 🖼️ Prototype
![PrototypeMovie](https://github.com/kimsangjunzzang/NC2_SpriteKit_Game/assets/84498457/34a585a8-e0c5-43ec-bb78-1c85a56915cd)

## 🛠️ About Code
<img width="1298" alt="코드" src="https://github.com/kimsangjunzzang/NC2_SpriteKit_Game/assets/84498457/a5a9afbf-3e78-426a-9742-15a7aae932a4">

