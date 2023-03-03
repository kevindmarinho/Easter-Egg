//
//  ARViewCoodinator.swift
//  EasterEgg
//
//  Created by kevin marinho on 02/03/23.
//
import ARKit
import SwiftUI
import RealityKit
import FocusEntity

//classe criada para manipular a interacao do usuario com o objeto 3d
class Coordinator: NSObject, ARSessionDelegate {
    
    weak var view: ARView?
    var focusEntity: FocusEntity?
    //a função cria uma instância de "FocusEntity" e a adiciona à visualização AR para ajudar o usuário a posicionar objetos 3D.
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let view = self.view else { return }
        debugPrint("Anchors added to the scene: ", anchors)
        self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
    }
    
    //é chamado sempre que o usuário toca na visualização AR. Neste método, a função cria uma nova âncora (AnchorEntity) e adiciona um modelo 3D
    @objc func handleTap() {
        guard let view = self.view, let focusEntity = self.focusEntity else { return }
        
        let anchor = AnchorEntity()
        view.scene.anchors.append(anchor)
        
        let ghostEntity = try! ModelEntity.loadModel(named: "Easter_Egg")
        ghostEntity.scale = [0.0007, 0.0007, 0.0007]
        ghostEntity.position = focusEntity.position
        
        anchor.addChild(ghostEntity)
        
        for animation in ghostEntity.availableAnimations {
            ghostEntity.playAnimation(animation.repeat(duration: .infinity), transitionDuration: 1.25, startsPaused: false)
        }
    }
}
