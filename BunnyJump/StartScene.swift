//
//  StartScene.swift
//  BunnyJump
//
//  Created by 김상준 on 6/15/24.


import Foundation
import SpriteKit


class StartScene: SKScene{
    override func didMove(to view: SKView) {
        
        self.size = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        
        setupBackground()
        setupStartButtons()
        
    }
    
    func setupBackground() {
        
        let background = SKSpriteNode(imageNamed: "StartBackground")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = self.size
        addChild(background)
    }
    
    func setupStartButtons() {
        
        let startButton = SKSpriteNode(imageNamed: "StartButton")
        startButton.name = "startButton"
        startButton.position = CGPoint(x: size.width / 2, y: size.height / 5)
        addChild(startButton)
        
        let outAction = SKAction.fadeOut(withDuration: 0.5)
        let inAction = SKAction.fadeIn(withDuration: 0.5)
        let sequence = SKAction.sequence([outAction, inAction])
        
        startButton.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let startNode = atPoint(location)
            
            if startNode.name == "startButton"{
                let transition = SKTransition.doorway(withDuration: 3)
                self.view?.presentScene(CharacterScene(size: self.size),transition: transition)
            }
        }
    }
    
}
