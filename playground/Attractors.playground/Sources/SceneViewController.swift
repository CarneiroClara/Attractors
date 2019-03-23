import UIKit
import SpriteKit

public class SceneViewController: UIViewController {
    
    var skView: SKView!
    var skScene: GameScene!
    public var sceneSize: CGSize!
    
    public override func loadView() {
        let view = UIView()
        self.view = view
        self.view.backgroundColor = .red
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sceneSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.setupViews()
    }
    
    private func setupViews() {
        let skViewSize = designConstants.beeScene(screenSize: self.sceneSize).size
        self.skView = SKView(frame: CGRect(origin: CGPoint(x: 0, y: sceneSize.height * 0.1), size: skViewSize))
        self.view.addSubview(self.skView)
        
        self.skScene = GameScene(size: self.skView.frame.size)
        self.skView.presentScene(self.skScene)
        
        let addButton: UIButton = {
            let buttonSize = designConstants.button(screenSize: self.sceneSize).size
            let button = UIButton(frame: CGRect(origin: CGPoint(x: sceneSize.width * 0.15, y: sceneSize.height * 0.01), size: buttonSize))
            button.setTitle("Add bee", for: .normal)
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(addBee), for: .touchUpInside)
            return button
        }()
        
        let removeButton: UIButton = {
            let buttonSize = designConstants.button(screenSize: self.sceneSize).size
            let button = UIButton(frame: CGRect(origin: CGPoint(x: sceneSize.width - sceneSize.width * 0.45, y: sceneSize.height * 0.01), size: buttonSize))
            button.setTitle("Remove bee", for: .normal)
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(removeBee), for: .touchUpInside)
            return button
        }()
        
        self.view.addSubview(addButton)
        self.view.addSubview(removeButton)
    }
    
    @objc func removeBee() {
        self.skScene.removeBee()
    }
    
    @objc func addBee() {
        self.skScene.addBee()
    }
}

extension SceneViewController {
    enum designConstants {
        case button(screenSize: CGSize)
        case beeScene(screenSize: CGSize)
        
        var size: CGSize {
            switch self {
            case .button(let screenSize):
                return CGSize(width: screenSize.width * 0.3, height: screenSize.height * 0.08)
            case .beeScene(let screenSize):
                return CGSize(width: screenSize.width, height: screenSize.height * 0.4)
            }
        }
    }
}
