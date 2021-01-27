//
//  GameScene.swift
//  FirstSpriteKit_doz_14
//
//  Created by Alexander Hoch on 26.01.21.
//  Copyright © 2021 zancor. All rights reserved.
//

import SpriteKit
import GameplayKit

class MySprite:SKSpriteNode{
    var isTouched = false
    
    func checkIsTouched( pos : CGPoint){
        
        if(pos.x < self.position.x + self.frame.width/2 &&
            pos.x > self.position.x - self.frame.width/2 &&
            pos.y < self.position.y + self.frame.height/2 &&
            pos.y > self.position.y - self.frame.height/2
            
            ){
            
            self.isTouched = true
            
            }
      
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var fireMask:UInt32 = 0x01
    var pigMask:UInt32  = 0x02
    
    /************START****************/
    override func didMove(to view: SKView) {
        createBG()
        createCloud()
         createPig()
        createFire()
         setPhysicWorld()
        createSun()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
           // Called before each frame is rendered
        cloud.moveXBorder()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("A:::\(contact.bodyA.categoryBitMask)")
        print("B:::\(contact.bodyB.categoryBitMask)")
        //
        if (contact.bodyA.categoryBitMask == 2) &&
                      (contact.bodyB.categoryBitMask == 4294967295) {
            pig.die()
            
        }
    }
    /******************************************/
    func createSun(){
        let sun = SKSpriteNode(imageNamed:"sun")
        sun.size = CGSize(width: 100,height: 100)
        sun.position = CGPoint(x: self.frame.width-200,y: self.frame.height-100)
        
            sun.zPosition = 38
        let scale = SKAction.scale(to: 1.4, duration: 0.5)
        let fade = SKAction.fadeAlpha(to: 0.2, duration: 1)
        let fade2 = SKAction.fadeAlpha(to: 1, duration: 1)
        let scale2 = SKAction.scale(to: 1, duration: 0.5)
       
        let rot = SKAction.rotate(byAngle: 1, duration: 1)
        let rot2 = SKAction.rotate(byAngle: -1, duration: 1)
        
         let sequence = SKAction.sequence([rot,scale, fade,fade2,scale2,rot2])
        let  repeatAction =        SKAction.repeatForever(sequence)
        
        self.addChild(sun)
        sun.run(repeatAction)
    }
    /*****************************************/
    var cloud:Cloud!
     func createCloud(){
         cloud = Cloud(imageNamed: "cloud1")
         cloud.zPosition = 40
         cloud.setAll()
         self.addChild(cloud)
         cloud.createRain()
     }
    
    func createBG(){
        bg = SKSpriteNode(imageNamed: "bgfire")
        bg.size = self.frame.size
        bg.position = CGPoint(x: bg.frame.width/2,y: bg.frame.height/2)
        self.addChild(bg)
    }
    
    func createCircle(){
        
    }
    
    func createRect(){
        
    }
    
    var pig:Pig!
    func createPig(){
          pig = Pig(imageNamed: "p1")
                pig.setPosAndSize()
        pig.zPosition = 100
                self.addChild(pig)
        pig.physicsBody?.categoryBitMask = pigMask
        pig.physicsBody?.contactTestBitMask = fireMask
        
          
    }
    
    private var fire:SKEmitterNode!
       func createFire(){
            fire = SKEmitterNode(fileNamed: "fire2")! //MyParticle is the name of the sks file.
               fire.position.x = 600
           fire.position.y = 50
        
               fire.zPosition = 1
               fire.alpha = 0.8
        
        fire.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1000,height: 100))
               
               fire.physicsBody?.mass =  500
               fire.physicsBody?.friction = 100
        
           self.addChild(fire) //No
        
        fire.physicsBody?.categoryBitMask = pigMask
        fire.physicsBody?.contactTestBitMask = fireMask
       
       }
    /************************************/
    func shoot(x:CGFloat,y:CGFloat){
            var dx = pig.position.x - x
            var dy = pig.position.y - y
           pig.setPhysics()
           pig.setPush(dx: dx, dy: dy)
       }
    
    /******************************************/
    var bg:SKSpriteNode!
    /*****************************************/
    func setPhysicWorld(){
              //erzeuge ein Rechteck mit Physic das so gross ist wie diese GameScene
              let rect:CGRect = CGRect(x: 0,y: 0,width: self.frame.width,height: self.frame.height)
              self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
              
              //setze die Gravitation in diesem Rechteck
              self.physicsWorld.gravity = CGVector(dx: 0, dy:-9.8)
           //**2**.
              self.physicsWorld.contactDelegate = self
    }
    
    /************************/
    
    /***************************/
    
    func touchDown(atPoint pos : CGPoint) {
          pig.checkIsTouched(pos: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
       if(pig.isTouched){
          shoot(x: pos.x, y: pos.y)
          pig.isTouched = false
        }
        
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
    
    
   
    /***********************/
}
