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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        var frames:[SKTexture] = []

        let beeAtlas = SKTextureAtlas(named: "Bee")

        for index in 1 ... beeAtlas.textureNames.count {
            let textureName = "bee-\(index)"
            let texture = beeAtlas.textureNamed(textureName)
            frames.append(texture)
        }

        self.beeFrames = frames


    }

    public func flyBee() {
        let texture = self.beeFrames?[0]
        let bee = SKSpriteNode(texture: texture)

        bee.size = CGSize(width: 44.5, height: 35.25)

        let randomBeeYPositionGenerator = GKRandomDistribution(lowestValue: 100, highestValue: Int(self.frame.size.height))
        let yPosition = CGFloat(randomBeeYPositionGenerator.nextInt())

        let rightToLeft = arc4random() % 2 == 0

        let xPosition = rightToLeft ? self.frame.size.width + bee.size.width / 2 : -bee.size.width / 2

        bee.xScale = -1
        bee.position = CGPoint(x: xPosition, y: yPosition)

        if rightToLeft {
            bee.xScale = 1
        }

        self.addChild(bee)

        bee.run(SKAction.repeatForever(SKAction.animate(with: self.beeFrames!, timePerFrame: 0.05, resize: false, restore: true)))

        var distanceToCover = self.frame.size.width + bee.size.width

        if rightToLeft {
            distanceToCover *= -1
        }

        let time = TimeInterval(abs(distanceToCover / 140))

        let moveAction = SKAction.moveBy(x: distanceToCover, y: 0, duration: time)

        let removeAction = SKAction.run {
            bee.removeAllActions()
            bee.removeFromParent()

        }

        let allActions = SKAction.repeatForever(SKAction.sequence([moveAction, removeAction]))

        bee.run(allActions)
    }

}
