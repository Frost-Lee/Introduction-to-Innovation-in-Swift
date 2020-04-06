//
//  ViewController.swift
//  catch_geometry
//
//  Created by 李灿晨 on 3/10/20.
//  Copyright © 2020 李灿晨. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class CatchGeometryViewController: UIViewController {

    @IBOutlet weak var arscnView: ARSCNView!
    @IBOutlet weak var geometryIndicatorImageView: UIImageView!
    @IBOutlet weak var warningView: UIView!
    
    var arCoachingOverlayView: ARCoachingOverlayView!
    
    private var planeNode: PlaneNode?
    private var geometryNodeLaunchTimer: Timer?
    
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
        arscnView.scene = SCNScene()
        arscnView.scene.physicsWorld.gravity = SCNVector3(0, -2, 0)
        arscnView.delegate = self
        arscnView.autoenablesDefaultLighting = true
        arscnView.scene.physicsWorld.contactDelegate = self
        setupARCoachView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arscnView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pauseGame()
        arscnView.session.pause()
    }
    
    @IBAction func changeShapeButtonTapped(_ sender: UIButton) {
        currentShape = GeometryShape(rawValue: (currentShape.rawValue + 1) % GeometryShape.allCases.count)!
    }
    
    @IBAction func changeColorButtonTapped(_ sender: UIButton) {
        currentColor = GeometryColor(rawValue: (currentColor.rawValue + 1) % GeometryColor.allCases.count)!
    }
    
    private func setupARCoachView() {
        arCoachingOverlayView = ARCoachingOverlayView()
        arCoachingOverlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arCoachingOverlayView)
        NSLayoutConstraint.activate([
            arCoachingOverlayView.topAnchor.constraint(equalTo: view.topAnchor),
            arCoachingOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            arCoachingOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            arCoachingOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        arCoachingOverlayView.delegate = self
        arCoachingOverlayView.session = arscnView.session
    }
    
    private func setupGame(rootNode: SCNNode) {
        planeNode = PlaneNode(device: arscnView.device!)
        rootNode.addChildNode(planeNode!)
    }
    
    private func startGame() {
        geometryNodeLaunchTimer?.invalidate()
        geometryNodeLaunchTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            let geometryNode = GeometryNode()
            self.planeNode!.parent!.addChildNode(geometryNode)
            geometryNode.position = SCNVector3(0, 0.2, 0)
            geometryNode.launch()
        }
        geometryNodeLaunchTimer?.fire()
    }
    
    private func pauseGame() {
        geometryNodeLaunchTimer?.invalidate()
    }

}

extension CatchGeometryViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return}
        guard planeNode == nil else {return}
        setupGame(rootNode: node)
        startGame()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return}
        guard node.childNodes.first is PlaneNode else {return}
        (node.childNodes.first as! PlaneNode).update(from: anchor as! ARPlaneAnchor)
    }
}

extension CatchGeometryViewController: ARCoachingOverlayViewDelegate {
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        pauseGame()
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        startGame()
    }
}

extension CatchGeometryViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let geometryNode = contact.nodeA as? GeometryNode ?? contact.nodeB as! GeometryNode
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
