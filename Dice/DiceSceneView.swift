//
//  DiceSceneView.swift
//  Dice
//
//  Created by Angelos Staboulis on 10/9/25.
//

import Foundation
import SwiftUI
import SceneKit

struct DiceSceneView: UIViewRepresentable {
    @Binding var rollTrigger: Bool

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = createScene()
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.black
        sceneView.autoenablesDefaultLighting = true

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        if rollTrigger {
            rollDice(in: uiView)
            DispatchQueue.main.async {
                rollTrigger = false
            }
        }
    }

    private func createScene() -> SCNScene {
        let scene = SCNScene()

        let dice = createDiceNode()
        dice.name = "dice"
        scene.rootNode.addChildNode(dice)

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 8)
        scene.rootNode.addChildNode(cameraNode)

        return scene
    }

    private func createDiceNode() -> SCNNode {
        let dice = SCNBox(width: 2, height: 2, length: 2, chamferRadius: 0.2)

        let materials = (1...6).map { number -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "dice\(number)")
            return material
        }

        dice.materials = [materials[0], materials[1], materials[2], materials[3], materials[4], materials[5]]
        let node = SCNNode(geometry: dice)
        return node
    }

    private func rollDice(in view: SCNView) {
        guard let diceNode = view.scene?.rootNode.childNode(withName: "dice", recursively: true) else { return }

        let randomX = Float.random(in: 2...6) * .pi
        let randomY = Float.random(in: 2...6) * .pi
        let randomZ = Float.random(in: 2...6) * .pi

        let action = SCNAction.rotateBy(x: CGFloat(randomX),
                                        y: CGFloat(randomY),
                                        z: CGFloat(randomZ),
                                        duration: 5.0)
        action.timingMode = .easeInEaseOut

        diceNode.runAction(action)
    }
}
