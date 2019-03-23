import UIKit
import SpriteKit

public class SceneViewController: UIViewController {
    
    var skView: SKView!
    var skScene: GameScene!
    var sceneWidth: CGFloat!
    var sceneHeight: CGFloat!
    
    public override func loadView() {
        let view = UIView()
        self.view = view
        self.view.backgroundColor = .red
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sceneWidth = self.view.frame.width
        self.sceneHeight = self.view.frame.height
        self.setupViews()
    }
    
    private func setupViews() {
        self.skView = SKView(frame: CGRect(x: 0, y: sceneHeight * 0.1, width: sceneWidth, height: sceneHeight * 0.4))
        self.view.addSubview(self.skView)
        
        self.skScene = GameScene(size: self.skView.frame.size)
        self.skView.presentScene(self.skScene)
        
        let addButton: UIButton = {
            let button = UIButton(frame: CGRect(x: sceneWidth * 0.15, y: 0, width: sceneWidth * 0.3, height: sceneHeight * 0.1))
            button.setTitle("Add bee", for: .normal)
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(addBee), for: .touchUpInside)
            return button
        }()
        
        let removeButton: UIButton = {
            let button = UIButton(frame: CGRect(x: sceneWidth - sceneWidth * 0.45, y: 0, width: sceneWidth * 0.3, height: sceneHeight * 0.1))
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
