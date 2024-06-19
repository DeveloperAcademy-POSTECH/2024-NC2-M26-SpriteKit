//
//  GameOverScene.swift
//  NC2_SpriteKit
//
//  Created by 김상준 on 6/13/24.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    var selectedCharacter: String = ""
    
    override func didMove(to view: SKView) {
        
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        setupBackground()
        setupGameOverImg()
        setupLabel()
        
    }
    
    func setupBackground() {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = 1
        background.size = self.size
        addChild(background)
    }
    func setupGameOverImg() {
        
        let playerImage = SKSpriteNode(imageNamed: selectedCharacter)
        playerImage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        playerImage.zPosition = 2
        playerImage.setScale(3)
        addChild(playerImage)
        
        let outAction = SKAction.rotate(byAngle: 1, duration: 1)
        let inAction = SKAction.rotate(byAngle: 1, duration: 1)
        let sequence = SKAction.sequence([outAction, inAction])
        playerImage.run(SKAction.repeatForever(sequence))
    }
    
    func setupLabel(){
        let tapLabel = SKSpriteNode(imageNamed: "ReplayButton")
        tapLabel.position = CGPoint(x: size.width / 2, y: size.height / 5)
        tapLabel.zPosition = 2
        addChild(tapLabel)
        
        let outAction = SKAction.fadeOut(withDuration: 0.5)
        let inAction = SKAction.fadeIn(withDuration: 0.5)
        let sequence = SKAction.sequence([outAction, inAction])
        
        tapLabel.run(SKAction.repeatForever(sequence))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let transition = SKTransition.flipVertical(withDuration: 1)
        
        view?.presentScene(CharacterScene(size: self.size), transition: transition)
    }
}



