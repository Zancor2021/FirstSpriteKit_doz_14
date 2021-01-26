//
//  Bird.swift
//  FirstPhysicWorld_doz_09
//
//  Created by Alexander Hoch on 16.04.19.
//  Copyright © 2019 zancor. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class Pig: MySprite {
    
    
 
    func setAll(){
        setPosAndSize()
        setPhysics()
   
    }
    
    func setPosAndSize(){
        self.position.x = 400
        self.position.y = 400
        self.size = CGSize(width: 80,height: 80)
    }
    
    func setPhysics(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: (self.frame.height/2)-5)
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.mass =  5
        self.physicsBody?.friction = 100
    }
    
    func setPush(dx:CGFloat,dy:CGFloat){
      self.physicsBody?.applyForce(CGVector(dx: dx*3000, dy: dy*3000))
    }
 
    
    
}
