//
//  TSMovingGround.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/14/16.
//  Copyright © 2016 Tevin Scott. All rights reserved.
//

import Foundation
import SpriteKit

class TSMovingGround: SKSpriteNode{
    let NUMOFSEGMENTS = 20;
    let COLORONE = UIColor(red:88/255, green: 148/255, blue: 87/255, alpha: 1.0);// light hue of green
    let COLORTWO = UIColor(red:120/255, green: 195/255, blue: 118/255, alpha: 1.0);//dark hue of green
    var adjustedDuration: TimeInterval?
    var moveLeft : SKAction?
    var resetPosition : SKAction?
    var moveSequence : SKAction?
    init(size: CGSize){
        super.init(texture: nil, color: UIColor.brown, size: CGSize(width: size.width*2, height: size.height))
        anchorPoint = CGPoint(x: 0, y: 0.5)//sets starting point for which the object is drawn from, default is top left
        
        for i in 0...NUMOFSEGMENTS{
            var segmentColor: UIColor!;
            //alternates colors of the ground utilizing the modulus operator
            if i % 2 == 0{
                segmentColor = COLORONE;
            }
            else{
                segmentColor = COLORTWO;
            }
            //sets the segment color of this iteration through the loop
            let segment = SKSpriteNode(color: segmentColor, size: CGSize(width: self.size.width/CGFloat(NUMOFSEGMENTS),  height: self.size.height))
            segment.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            segment.position = CGPoint(x: CGFloat(i)*segment.size.width, y: 0);
            addChild(segment);
     
 
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func start(){
        adjustedDuration = TimeInterval(frame.size.width / kDefaultXToMovePerSecond)//compensates for ground skipping
        moveLeft = SKAction.moveBy(x: -frame.size.width/2, y: 0, duration: adjustedDuration!/2)
        resetPosition = SKAction.moveTo(x: 0, duration: 0)
        //^^facinating allows you to chain actions in a specific order based on the position in the array parameter passed to the sequence func
        moveSequence = SKAction.sequence([moveLeft!, resetPosition!])
    
        //runAction(moveSequence)//runAction(moveSequence, completion: nil) no longer works for indefinite running omit completion condition completely
        //even better way of solving repeating runAction
        run(SKAction.repeatForever(moveSequence!))
        // from what can be inferred this behaves like a thread duration being the ticks()
        
    }
    func stop(){
        self.removeAllActions()
    }
}
