//
//  GameScene.swift
//  Pong
//
//  Created by Wesley Dashner on 5/3/19.
//  Copyright © 2019 Wesley Dashner. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    
    static let ball: UInt32 = 0x1 << 1
    static let paddles: UInt32 = 0x1 << 2
    static let border: UInt32 = 0x1 << 3
    
}

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var playerPaddle = SKSpriteNode()
    var enemyPaddle = SKSpriteNode()
    var border = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        ball = SKSpriteNode(imageNamed: "ball")
        ball.setScale(0.3)
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.width / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.paddles | PhysicsCategory.border
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.paddles | PhysicsCategory.border
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        self.addChild(ball)
        
        playerPaddle = SKSpriteNode(imageNamed: "paddle")
        playerPaddle.setScale(0.2)
        playerPaddle.position = CGPoint(x: 0, y: -self.frame.height / 2 + 70)
        playerPaddle.physicsBody = SKPhysicsBody(rectangleOf: playerPaddle.size)
        playerPaddle.physicsBody?.categoryBitMask = PhysicsCategory.paddles
        playerPaddle.physicsBody?.collisionBitMask = PhysicsCategory.ball
        playerPaddle.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        playerPaddle.physicsBody?.affectedByGravity = false
        playerPaddle.physicsBody?.isDynamic = false
        self.addChild(playerPaddle)
        
        enemyPaddle = SKSpriteNode(imageNamed: "paddle")
        enemyPaddle.setScale(0.2)
        enemyPaddle.position = CGPoint(x: 0, y: self.frame.height / 2 - 70)
        enemyPaddle.physicsBody = SKPhysicsBody(rectangleOf: enemyPaddle.size)
        enemyPaddle.physicsBody?.categoryBitMask = PhysicsCategory.paddles
        enemyPaddle.physicsBody?.collisionBitMask = PhysicsCategory.ball
        enemyPaddle.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        enemyPaddle.physicsBody?.affectedByGravity = false
        enemyPaddle.physicsBody?.isDynamic = false
        self.addChild(enemyPaddle)
        
        border.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.physicsBody?.categoryBitMask = PhysicsCategory.border
        border.physicsBody?.collisionBitMask = PhysicsCategory.ball
        border.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        self.addChild(border)
        
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 100))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            playerPaddle.position = CGPoint(x: location.x, y: playerPaddle.position.y)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            playerPaddle.position.x = location.x
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if enemyPaddle.position.x < ball.position.x {
            let move = SKAction.moveBy(x: 10, y: 0, duration: 0.0167)
            enemyPaddle.run(move)
        }
        else if enemyPaddle.position.x > ball.position.x {
            let move = SKAction.moveBy(x: -10, y: 0, duration: 0.0167)
            enemyPaddle.run(move)
        }
    }
    
}
