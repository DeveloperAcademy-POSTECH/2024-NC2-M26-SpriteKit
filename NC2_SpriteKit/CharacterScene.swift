//
//  CharacterScene.swift
//  NC2_SpriteKit
//
//  Created by 김상준 on 6/17/24.
//

import Foundation
import SpriteKit

class CharacterScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        setupBackground()
        setupCharacterButtons()
    }
    
    func setupBackground() {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = self.size
        addChild(background)
    }
    
    func setupCharacterButtons() {
        //MARK: 루피 버튼
        
        let luffyButton = createCharacterButton(
            name: "luffyButton",
            text: "Tech",
            position: CGPoint(x: size.width * 0.33, y: size.height * 0.5),
            textureName: "Luffy"
        )
        
        addChild(luffyButton)
        //MARK: 라라 버튼
        let raraButton = createCharacterButton(
            name: "raraButton",
            text: "Design",
            position: CGPoint(x: size.width * 0.67, y: size.height * 0.5),
            textureName: "Rara"
        )
        addChild(raraButton)
    }
    func createCharacterButton(
        name: String,
        text: String,
        position: CGPoint,
        textureName: String
    ) -> SKSpriteNode {
        let button = SKSpriteNode(imageNamed: textureName)
        button.name = name
        button.position = position
        // 버튼에 레이블 추가
        let label = SKLabelNode(text: text)
        label.fontName = "NeoDunggeunmo"
        label.fontSize = 24
        label.fontColor = .black
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: -button.size.height / 2 - 20)
        button.addChild(label)
        
        return button
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "luffyButton" {
                transitionToGameScene(selectedCharacter: "Luffy")
            } else if touchedNode.name == "raraButton" {
                transitionToGameScene(selectedCharacter: "Rara")
            }
        }
    }
    
    func transitionToGameScene(selectedCharacter: String) {
        let gameScene = GameScene(size: self.size)
        let transition = SKTransition.crossFade(withDuration: 1)
        
        gameScene.selectedCharacter = selectedCharacter
        self.view?.presentScene(gameScene, transition: transition)
    }
}

