import UIKit
import SpriteKit

public class SceneViewController: UIViewController {
    
    var beeSkView: SKView!
    var beeSkScene: GameScene!
    var graphicSkView: SKView!
    var graphicSkScene: GraphicGameScene!
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
        
        //Bee skView
        let skViewSize = designConstants.beeScene(screenSize: sceneSize).size
        self.beeSkView = SKView(frame: CGRect(origin: CGPoint(x: 0, y: sceneSize.height * 0.1), size: skViewSize))
        self.view.addSubview(self.beeSkView)
        
        self.beeSkScene = GameScene(size: self.beeSkView.frame.size)
        self.beeSkView.presentScene(self.beeSkScene)
        
        //Graphic skView
        
        let graphicViewSize = designConstants.graphicScene(screenSize: sceneSize).size
        self.graphicSkView = SKView(frame: CGRect(origin: CGPoint(x: 0, y: sceneSize.height * 0.5), size: graphicViewSize))
        self.view.addSubview(self.graphicSkView)
        
        self.graphicSkScene = GraphicGameScene(size: self.graphicSkView.frame.size)
        self.graphicSkView.presentScene(self.graphicSkScene)
        
        //Buttons
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
        self.beeSkScene.removeBee()
    }
    
    @objc func addBee() {
        self.beeSkScene.addBee()
    }
}

extension SceneViewController {
    enum designConstants {
        case button(screenSize: CGSize)
        case beeScene(screenSize: CGSize)
        case graphicScene(screenSize: CGSize)
        
        var size: CGSize {
            switch self {
            case .button(let screenSize):
                return CGSize(width: screenSize.width * 0.3, height: screenSize.height * 0.08)
            case .beeScene(let screenSize):
                return CGSize(width: screenSize.width, height: screenSize.height * 0.4)
            case .graphicScene(let screenSize):
                return CGSize(width: screenSize.width, height: screenSize.height * 0.5)
            }
        }
    }
}
