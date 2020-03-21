//
//  Structures.swift
//  catch_geometry
//
//  Created by 李灿晨 on 3/15/20.
//  Copyright © 2020 李灿晨. All rights reserved.
//

import UIKit
import SceneKit


enum GeometryShape: Int, CaseIterable {
    case sphere = 0
    case cube = 1
    case pyramid = 2
    
    func getGeometry() -> SCNGeometry {
        switch self {
        case .sphere:
            return SCNSphere(radius: 0.05)
        case .cube:
            return SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        case .pyramid:
            return SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        }
    }
    
    func getIndicatorImage() -> UIImage {
        switch self {
        case .sphere:
            return UIImage(systemName: "circle")!
        case .cube:
            return UIImage(systemName: "square")!
        case .pyramid:
            return UIImage(systemName: "triangle")!
        }
    }
}


enum GeometryColor: Int, CaseIterable {
    case red = 0
    case blue = 1
    case yellow = 2
    
    func getColor() -> UIColor {
        switch self {
        case .red:
            return .systemPink
        case .blue:
            return .systemTeal
        case .yellow:
            return .systemYellow
        }
    }
}


enum ColliderType: Int {
    case geometry = 0b1
    case plane = 0b10
}


class GeometryNode: SCNNode {
    
    var color: GeometryColor = GeometryColor(rawValue: Int.random(in: 0...2))!
    var shape: GeometryShape = GeometryShape(rawValue: Int.random(in: 0...2))!
    
    private var particleNode: SCNNode = SCNNode()
    
    override init() {
        super.init()
        let geometry = shape.getGeometry()
        geometry.materials.first?.diffuse.contents = color.getColor()
        self.geometry = geometry
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        physicsBody?.mass = 2.0
        physicsBody?.isAffectedByGravity = true
        categoryBitMask = ColliderType.geometry.rawValue
        physicsBody?.collisionBitMask = ColliderType.plane.rawValue | ColliderType.geometry.rawValue
        physicsBody?.contactTestBitMask = ColliderType.plane.rawValue
        name = "geometry"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Required initialization not implemented.")
    }
    
    func launch() {
        let maxHorizontalForce: Float = 0.8
        let force = SCNVector3(
            Float.random(in: -maxHorizontalForce...maxHorizontalForce),
            10,
            Float.random(in: -maxHorizontalForce...maxHorizontalForce)
        )
        self.physicsBody?.applyForce(force, at: SCNVector3(0.001, 0.001, 0.001), asImpulse: true)
    }
    
    func explode(particleSystemName: String, applyColor: Bool) {
        let parent = self.parent
        self.removeFromParentNode()
        let particleSystem = SCNParticleSystem(named: particleSystemName, inDirectory: nil)!
        if applyColor {
            particleSystem.particleColor = color.getColor()
        }
        particleNode.addParticleSystem(particleSystem)
        particleNode.position = presentation.position
        parent?.addChildNode(particleNode)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            self.particleNode.removeFromParentNode()
        }
    }
    
}


class PlaneNode: SCNNode {
    
    override init() {
        super.init()
        let geometry = SCNPlane(width: 1, height: 1)
        geometry.materials.first?.diffuse.contents = UIColor.white
        geometry.materials.first?.isDoubleSided = true
        self.geometry = geometry
        physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        physicsBody?.isAffectedByGravity = false
        categoryBitMask = ColliderType.plane.rawValue
        physicsBody?.contactTestBitMask = ColliderType.geometry.rawValue
        physicsBody?.collisionBitMask = ColliderType.geometry.rawValue
        name = "Plane"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Required initialization not implemented.")
    }
    
}
