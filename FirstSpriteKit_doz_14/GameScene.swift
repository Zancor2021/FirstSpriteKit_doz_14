//
//  GameScene.swift
//  FirstSpriteKit_doz_14
//
//  Created by Alexander Hoch on 26.01.21.
//  Copyright © 2021 zancor. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /************START****************/
    override func didMove(to view: SKView) {
        
         setPhysicWorld()
    }
    /*****************************************/
    func createCircle(){
        
    }
    
    func createRect(){
        
    }
    
    func createSpriteWithImage(pos: CGPoint){
        let pig:SKSpriteNode = SKSpriteNode(imageNamed: "p1")
               pig.position.x = startPos.x
               pig.position.y = startPos.y
               pig.size = CGSize(width: 100,height: 100)
        
               pig.physicsBody = SKPhysicsBody(circleOfRadius: (pig.frame.height/2)-5)
               pig.physicsBody?.allowsRotation = true
               pig.physicsBody?.mass =  5
               pig.physicsBody?.friction = 100
        
          
           self.addChild(pig)
         setPush(obj: pig, dx: 100, dy: -100)
    }
    
    func createParticle(){
        
    }
    /************************************/
    func setPush(obj:SKSpriteNode,dx:CGFloat,dy:CGFloat){
         let dxnew = startPos.x - dx
         let dynew = startPos.y - dy
            (obj.physicsBody?.applyForce(CGVector(dx: dxnew*3000, dy: dynew*3000)))!
       }
    /*****************************************/
    func setPhysicWorld(){
              //erzeuge ein Rechteck mit Physic das so gross ist wie diese GameScene
              let rect:CGRect = CGRect(x: 0,y: 0,width: self.frame.width,height: self.frame.height)
              self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
              
              //setze die Gravitation in diesem Rechteck
              self.physicsWorld.gravity = CGVector(dx: 0, dy:0)
           //**2**.
              self.physicsWorld.contactDelegate = self
    }
    
    /************************/
    var startPos = CGPoint(x: 500, y: 500)
    
    func touchDown(atPoint pos : CGPoint) {
       startPos.x = pos.x
        startPos.y = pos.y
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
         createSpriteWithImage(pos:pos)
    }
    
    /************************/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
               
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    /***********************/
}
