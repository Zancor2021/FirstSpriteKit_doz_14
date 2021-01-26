//
//  Bird.swift
//  FirstPhysicWorld_doz_09
//
//  Created by Alexander Hoch on 16.04.19.
//  Copyright © 2019 zancor. All rights reserved.
//

import UIKit
import SpriteKit

class Cloud: SKSpriteNode {
    
    var xspeed:CGFloat = 1
    var isRain:Bool = false
    
    
    func setAll(){
        setPosAndSize()        
    }
    
    func setPosAndSize(){
        self.position.x = 100
        self.position.y = 700
        self.size = CGSize(width: 200,height: 140)
    }
    
    
    func moveXLoop(){
        self.position.x = self.position.x + xspeed
        if(self.position.x > 1000){
            self.position.x = -200
        }
    }
    
    func moveXBorder(){
        self.position.x = self.position.x + xspeed
        if(self.position.x > 1000 || self.position.x < -200 ){
            xspeed = xspeed * -1
        }
    }
    
    private var rain:SKEmitterNode!
    func createRain(){
         rain = SKEmitterNode(fileNamed: "rain")! //MyParticle is the name of the sks file.
            rain.position.x = 0
        rain.position.y = -self.frame.height/2
            rain.zPosition = 1
        self.addChild(rain) //No
        self.isRain = true
    }
    
    func deleteRain(){
        rain.removeFromParent()
        self.isRain = false
        
    }

    
       
    
    
}
