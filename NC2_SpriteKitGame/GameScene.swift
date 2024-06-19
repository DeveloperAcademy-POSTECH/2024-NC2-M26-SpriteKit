//
//  GameScene.swift
//  NC2_SpriteKitGame
//
//  Created by 김상준 on 6/19/24.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    let background = SKSpriteNode(imageNamed: "background")
    var player = SKSpriteNode()
    let ground = SKSpriteNode(imageNamed: "ground") // 시작 플래폼
    
    let gameOverLine = SKSpriteNode(color: .red,size: CGSize(width: 10000, height: 10))
    
    var selectedCharacter: String = ""
    let motionManager = CMMotionManager()
    var currentXVelocity: CGFloat = 0
    
    let scoreLabel = SKLabelNode(fontNamed: "NeoDunggeunmo")
    let bestScoreLabel = SKLabelNode(fontNamed: "NeoDunggeunmo")
    
    var firstJump = false
    var score = 0
    var bestScore = 0
    let defaults = UserDefaults.standard
    let cam  = SKCameraNode()
    
    enum bitmasks: UInt32{
        
        case player = 0b1 // 1
        case platform = 0b10 // 2
        case gameOverLine // 4
    }
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        self.size = CGSize(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
        physicsWorld.contactDelegate = self // 물리엔진 선언
        
        setupScore()
        setupGameOverLine()
        setupScene()
        setupPlayer()
        setupCamera()
        setupMotionManager()
        
        movePlatform(40, 360, 150, 150)
        movePlatform(40, 360, 400, 400)
        movePlatform(40, 360, 650, 650)
        movePlatform(40, 360, 900, 900)
//        movePlatform(40, 360, 900, 900)
    }
    
    //MARK: Scene 설정 함수
    func setupScene(){
        //MARK: Background
        background.position = CGPoint(
            x:size.width / 2 ,
            y: size.height / 2
        )
        background.setScale(3)
        background.zPosition = 1
        addChild(background)
        
        //MARK: Ground
        ground.position = CGPoint(
            x: size.width / 2,
            y: -size.height / 2
        )
        ground.size = CGSize(width: size.width, height:100)
        ground.zPosition = 2
        ground.physicsBody?.isDynamic = false // 그라운드 형태 보존
        addChild(ground)
        
    }
    
    //MARK: Player 설정 함수
    func setupPlayer(){
        //MARK: Player
        player = SKSpriteNode(imageNamed: selectedCharacter)
        
        // 선택된 캐릭터에 따라 플레이어 이미지 설정
        if let playerImage = UIImage(named: selectedCharacter) {
            player.texture = SKTexture(image: playerImage)
        }
        
        player.position = CGPoint(
            x: size.width / 2,
            y: -size.height / 2 + 70
        )
        player.zPosition = 4
        player.size = CGSize(width: 100, height: 100)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.isDynamic = false
        player.physicsBody?.restitution = 0.2
        player.physicsBody?.friction = 0
        player.physicsBody?.angularDamping = 0
        player.physicsBody?.categoryBitMask = bitmasks.player.rawValue
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = bitmasks.platform.rawValue | bitmasks.gameOverLine.rawValue
        addChild(player)
        
    }
    
    //MARK: Camera 설정 함수
    func setupCamera(){
        
        cam.setScale(1)
        cam.position.x = player.position.x
        camera = cam
    }
    
    //MARK: CoreMotion 설정 함수
    func setupMotionManager(){
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1/60
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else { return }
                self.processDeviceMotion(data)
            }
        }
        
    }
    
    //MARK: GameOverLine 설정함수
    func setupGameOverLine(){
        
        //MARK: GameOverLine
        
        gameOverLine.position = CGPoint(
            x: player.position.x,
            y: player.position.y - 300
        )
        
        gameOverLine.zPosition = -1
        gameOverLine.physicsBody = SKPhysicsBody(rectangleOf: gameOverLine.size)
        gameOverLine.physicsBody?.affectedByGravity = false
        gameOverLine.physicsBody?.categoryBitMask = bitmasks.gameOverLine.rawValue
        gameOverLine.physicsBody?.contactTestBitMask = bitmasks.platform.rawValue | bitmasks.player.rawValue
        addChild(gameOverLine)
        
    }
    
    //MARK: Score 위치 설정 함수
    func setupScore(){
        //MARK: Score
        scoreLabel.position.x = 70
        scoreLabel.zPosition = 20
        scoreLabel.fontColor = .black
        scoreLabel.fontSize = 20
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)
        
        //MARK: BestScore
        
        bestScore = defaults.integer(forKey: "best")
        bestScoreLabel.position.x = 100
        bestScoreLabel.zPosition = 20
        bestScoreLabel.fontColor = .black
        bestScoreLabel.fontSize = 20
        bestScoreLabel.text = "BestScore: \(bestScore)"
        addChild(bestScoreLabel)
        
    }
    
    // MARK: player 위치에 따른 Update 함수
    override func update(_ currentTime: TimeInterval) {
        cam.position.y = player.position.y + 250
        background.position.y = player.position.y + 100
        
        // 게임 오버라인 조정
        if player.physicsBody!.velocity.dy > 0 {
            gameOverLine.position.y = player.position.y - 300
        }
        
        // 스코어 라벨 위치 조정
        bestScoreLabel.position.y = player.position.y + 450
        scoreLabel.position.y = player.position.y + 400
        
    }
    
    //MARK: 캐릭터 좌우 움직임
    func processDeviceMotion(_ data: CMDeviceMotion) {
        let attitude = data.attitude
        let roll = attitude.roll
        let sensitivity: CGFloat = 0.5
        let maxVelocity: CGFloat = 1000
        currentXVelocity = roll * sensitivity * maxVelocity
        player.physicsBody?.velocity.dx = currentXVelocity
    }
    //MARK: 첫번째 터치시만 클릭시 반응
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?) {
        if !firstJump {
            player.physicsBody?.isDynamic = true
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
            firstJump = true
        }
    }
    
    //MARK: 플레이어 플랫폼 충돌 관리 로직
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA: SKPhysicsBody
        let contactB: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            contactA = contact.bodyA // player
            contactB = contact.bodyB // platform
            
        }else{
            contactA = contact.bodyB // player
            contactB = contact.bodyA //platform
        }
        
        // 플랫폼 밟을시
        if player.physicsBody!.velocity.dy < 0 {
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 950) // 플랫폼 컨택시 점프
            contactB.node?.removeFromParent()
            
            movePlatform(40, 360, 900, 900)
            
            addScore()
        }
        
        //MARK: 게임오버 라인 플레이 충돌시 게임오버
        if contactA.categoryBitMask == bitmasks.player.rawValue && contactB.categoryBitMask == bitmasks.gameOverLine.rawValue{
            gameOver(selectedCharacter: selectedCharacter)
        }
    }
    
    // MARK: 플랫폼 생성 함수
    func movePlatform(_ xLowestValue: Int,_ xHighestValue: Int,_ yLowestValue: Int,_ yHighestValue: Int){
        let platform = SKSpriteNode(imageNamed: "groundSub")
        
        platform.position = CGPoint(
            x: GKRandomDistribution(lowestValue: xLowestValue, highestValue: xHighestValue).nextInt(),
            y: GKRandomDistribution(lowestValue: yLowestValue, highestValue: yHighestValue).nextInt() + Int(player.position.y)
        )
        if score >= 10 {
            
            let moveRight = SKAction.moveBy(x: 80, y: 0, duration: 1) // 오른쪽으로 이동
            let moveLeft = SKAction.moveBy(x: -80, y: 0, duration: 1) // 왼쪽으로 이동
            let sequence = SKAction.sequence([moveRight, moveLeft])
            let repeatForever = SKAction.repeatForever(sequence)
            platform.run(repeatForever)
        }
        platform.zPosition = 3
        platform.setScale(0.25)
        platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platform.size.width - 100,height: platform.size.height))
        
        platform.physicsBody?.affectedByGravity = false // 중력 참일시 플랫폼 낙하
        platform.physicsBody?.categoryBitMask = bitmasks.platform.rawValue
        platform.physicsBody?.collisionBitMask = 0
        platform.physicsBody?.contactTestBitMask = bitmasks.player.rawValue
        
        addChild(platform)
        
    }
    
    // MARK: GameOver 함수
    func gameOver(selectedCharacter: String){
        let gameOverScene = GameOverScene(size: self.size)
        let transition = SKTransition.crossFade(withDuration: 0.5)
        firstJump = false
        gameOverScene.selectedCharacter = selectedCharacter
        view?.presentScene(gameOverScene, transition: transition)
        
        if score > bestScore{
            bestScore = score
            
            defaults.set(bestScore,forKey: "best")
        }
    }
    
    // MARK: Score 추가 함수
    func addScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
}




