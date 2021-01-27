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
    
       var exploSet:[SKTexture] = []
       var player: AVAudioPlayer = AVAudioPlayer()
       
       //Lese alle Bilder aus dem explo.atlas ein
       func fillExploImageA(){
           //folder:explo.atlas
           let folder = SKTextureAtlas(named: "explo")
           for i in 1...folder.textureNames.count {
              
               exploSet.append(folder.textureNamed("explo\(i)"))
           }
           
       }
    
    func playSound(){
          let path = Bundle.main.path(forResource: "explosion", ofType:"mp3")!
          let url = URL(fileURLWithPath: path)
          do {
              player = try AVAudioPlayer(contentsOf: url)
              
              player.play()
              
          } catch {
              // couldn't load file :(
          }
      }
    
    func die(){
        fillExploImageA()
           print("die")
           
           playSound()
        
           self.physicsBody = nil
           
           self.run(SKAction.scale(to: CGSize(width: 500, height: 500), duration: 5))
           
           self.run(SKAction.animate(with: exploSet, timePerFrame: 0.1),completion:ende)
       }
       
       func ende(){
           self.removeFromParent()
       }
    
    
    
    
   //=======================================
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
        player.volume = 0
        playSound()
        self.physicsBody = SKPhysicsBody(circleOfRadius: (self.frame.height/2)-5)
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.mass =  5
        self.physicsBody?.friction = 100
    }
    
    func setPush(dx:CGFloat,dy:CGFloat){
      self.physicsBody?.applyForce(CGVector(dx: dx*3000, dy: dy*3000))
    }
 
    
    
}
