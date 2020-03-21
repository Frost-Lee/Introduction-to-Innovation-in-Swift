//
//  ViewController.swift
//  catch_geometry
//
//  Created by 李灿晨 on 3/10/20.
//  Copyright © 2020 李灿晨. All rights reserved.
//

import UIKit
import SceneKit

class CatchGeometryViewController: UIViewController {

    @IBOutlet weak var scnView: SCNView!
    @IBOutlet weak var geometryIndicatorImageView: UIImageView!
    @IBOutlet weak var warningView: UIView!
    
    private var currentColor: GeometryColor = .red {
        didSet {
            geometryIndicatorImageView.tintColor = currentColor.getColor()
        }
    }
    private var currentShape: GeometryShape = .cube {
        didSet {
            geometryIndicatorImageView.image = currentShape.getIndicatorImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scnView.scene = SCNScene()
        scnView.scene?.physicsWorld.gravity = SCNVector3(0, -7, 0)
        scnView.scene?.physicsWorld.contactDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCamera()
        setupLight()
        setupPlane(position: SCNVector3(0, 0, 0))
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            self.launchGeometry(position: SCNVector3(0, 0.1, 0))
        }
    }
    
    @IBAction func changeShapeButtonTapped(_ sender: UIButton) {
        currentShape = GeometryShape(rawValue: (currentShape.rawValue + 1) % GeometryShape.allCases.count)!
    }
    
    @IBAction func changeColorButtonTapped(_ sender: UIButton) {
        currentColor = GeometryColor(rawValue: (currentColor.rawValue + 1) % GeometryColor.allCases.count)!
    }
    
    private func setupCamera() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 2.5, z: 2)
        cameraNode.eulerAngles.x = -.pi / 6
        scnView.scene?.rootNode.addChildNode(cameraNode)
    }
    
    private func setupLight() {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scnView.scene?.rootNode.addChildNode(lightNode)
    }
    
    private func setupPlane(position: SCNVector3) {
        let planeNode = PlaneNode()
        planeNode.position = position
        planeNode.eulerAngles.x = -.pi / 2
        scnView.scene?.rootNode.addChildNode(planeNode)
    }
    
    private func launchGeometry(position: SCNVector3) {
        let geometryNode = GeometryNode()
        geometryNode.position = position
        scnView.scene?.rootNode.addChildNode(geometryNode)
        geometryNode.launch()
    }

}

extension CatchGeometryViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let geometryNode = contact.nodeB as! GeometryNode
        if geometryNode.color == currentColor && geometryNode.shape == currentShape {
            geometryNode.explode(particleSystemName: "Explode", applyColor: true)
        } else {
            geometryNode.explode(particleSystemName: "Big Explode", applyColor: false)
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.1, animations: {
                    self.warningView.alpha = 0.5
                }, completion: { finished in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.warningView.alpha = 0
                    })
                })
            }
        }
    }
}
