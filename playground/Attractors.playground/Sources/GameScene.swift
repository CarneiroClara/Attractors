import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    
    var beeFrames: [SKTexture]?
    private let beeWidth: CGFloat = 44.5
    private let beeHeight: CGFloat = 35.25
    var bees: [SKSpriteNode] = []

    public override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        var frames:[SKTexture] = []
        
        for index in 1 ... 6 {
            let textureName = "bee-\(index)"
            frames.append(SKTexture(imageNamed: textureName))
        }
        
        self.beeFrames = frames
    }
    
    //MARK: Bee management methods
    public func addBee() {
        
        //init position bee
        let randomBeeYPositionGenerator = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.frame.size.height))
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
    
    //
    //    @objc static override var supportsSecureCoding: Bool {
    //        // SKNode conforms to NSSecureCoding, so any subclass going
    //        // through the decoding process must support secure coding
    //        get {
    //            return true
    //        }
    //    }
}
