//
//  GameScene.swift
//  Attractors
//
//  Created by Clara Carneiro on 22/03/2019.
//  Copyright © 2019 Clara Carneiro. All rights reserved.
//

import SpriteKit
import GameplayKit

public class StartScene: SKScene {

    var beeFrames: [SKTexture]?
    private let beeWidth: CGFloat = 44.5
    private let beeHeight: CGFloat = 35.25
    var bees: [SKSpriteNode] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        var frames:[SKTexture] = []
        //Init sprite bee + anim
        let beeAtlas = SKTextureAtlas(named: "Bee")

        for index in 1 ... beeAtlas.textureNames.count {
            let textureName = "bee-\(index)"
            let texture = beeAtlas.textureNamed(textureName)
            frames.append(texture)
        }

        self.beeFrames = frames
    }

    //MARK: Bee management methods
    public func addBee() {
        
        //init position bee
        let randomBeeYPositionGenerator = GKRandomDistribution(lowestValue: 100, highestValue: Int(self.frame.size.height))
        let yPosition = CGFloat(randomBeeYPositionGenerator.nextInt())
        
        let rightToLeft = arc4random() % 2 == 0

        let xPosition = rightToLeft ? self.frame.size.width + self.beeWidth / 2 : -self.beeWidth / 2
        
        let bee = self.createBeeNode(onPostion: CGPoint(x: xPosition, y: yPosition))
        if rightToLeft {
            bee.xScale = 1
        }
        
        let distance = self.frame.size.width + bee.size.width
        let time = TimeInterval(abs(distance / 140))

        let allActions = SKAction.repeatForever(SKAction.sequence(setupBeeActions(rightToLeft: rightToLeft, time: time, distance: distance)))
        bee.run(allActions)
    }
    
    public func removeBee() {
        if bees.count > 0 {
            let indexGenerator = GKRandomDistribution(lowestValue: 0, highestValue: bees.count - 1)
            let removedBee = bees.remove(at: indexGenerator.nextInt())
            removedBee.removeAllActions()
            removedBee.removeFromParent()
        }
    }
    
    //MARK: Private methods
    private func createBeeNode(onPostion position: CGPoint) -> SKSpriteNode {
        let texture = self.beeFrames?[0]
        let bee = SKSpriteNode(texture: texture)
        bee.size = CGSize(width: self.beeWidth, height: self.beeHeight)
        bee.xScale = -1
        bee.position = position
        self.addChild(bee)
        bee.run(SKAction.repeatForever(SKAction.animate(with: self.beeFrames!, timePerFrame: 0.05, resize: false, restore: true)))
        self.bees.append(bee)
        return bee
    }
    
    private func setupBeeActions(rightToLeft: Bool, time: TimeInterval, distance: CGFloat) -> [SKAction] {
        return [setupFlyAction(forward: rightToLeft, time: time, distance: distance),
            setupFlipAction(forward: rightToLeft),
            setupFlyAction(forward: !rightToLeft, time: time, distance: distance),
            setupFlipAction(forward: !rightToLeft)]
    }
    
    private func setupFlyAction(forward: Bool, time: TimeInterval, distance: CGFloat) -> SKAction {
        let distanceToCover = distance * (forward ? -1.0 : 1.0)
        return SKAction.moveBy(x: distanceToCover, y: 0, duration: time)
    }
    
    private func setupFlipAction(forward: Bool) -> SKAction {
        return SKAction.scaleX(to: forward ? -1.0 : 1.0, duration: 0.0)
    }
}
