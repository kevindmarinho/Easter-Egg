//
//  ARView.swift
//  EasterEgg
//
//  Created by kevin marinho on 02/03/23.
//

import ARKit
import SwiftUI
import RealityKit
import FocusEntity

struct ARViewContainer: UIViewRepresentable {
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    
    //funcao criada para instanciar o que sera exibido para o usuario
    func makeUIView(context: Context) -> ARView {
        let arView = ARView()
        
        let session = arView.session
        //configuracao de mundo, a funcao é criada para dectar planos verticais e horizontais
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        let coachingOverlay = ARCoachingOverlayView()
        //definida para permitir que o overlay se ajuste automaticamente ao tamanho da visualização AR
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //definida para usar a sessão AR configurada anteriormente
        coachingOverlay.session = session
        //definida como "verticalPlane" para orientar o usuário na detecção de planos verticais.
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)
        //classe definida no ARViewCoordinator no código que lida com gestos de toque na visualização AR
        context.coordinator.view = arView
        
        session.delegate = context.coordinator
        //tap para chamar a funcao chamar a funcao que seta o modelo 3D
        arView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )

        return arView
    }
    
    func makeCoordinator() -> Coordinator { Coordinator() }
}

