//
//  GameViewController.swift
//  Attractors
//
//  Created by Clara Carneiro on 22/03/2019.
//  Copyright © 2019 Clara Carneiro. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class StartViewController: UIViewController {

    @IBOutlet var sceneView: SKView!

    var scene: StartScene?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.scene = StartScene(size: CGSize(width: self.sceneView.frame.size.width, height: self.sceneView.frame.size.height))
        self.sceneView.presentScene(scene)

//        if let scene = self.scene {
//            scene.flyBee()
//        }

        self.sceneView.showsFPS = true
        self.sceneView.showsNodeCount = true

    }

    @IBAction func addAction(_ sender: Any) {
        if let scene = self.scene {
            scene.addBee()
        }
    }
    
    @IBAction func removeAction() {
        guard let scene = self.scene else {return}
        scene.removeBee()
    }
}
