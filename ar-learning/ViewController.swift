//
//  ViewController.swift
//  ar-learning
//
//  Created by Matei Cananau on 2023-04-16.
//

import UIKit
import RealityKit
import ModelIO
import MetalKit
import CoreLocation
import ARKit



class ViewController: UIViewController, ARSessionDelegate {
    @IBOutlet var arView: ARView!

	override func viewDidLoad() {
		super.viewDidLoad()

		let configuration = ARImageTrackingConfiguration()
		if let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) {
			configuration.trackingImages = trackingImages
			configuration.maximumNumberOfTrackedImages = 1
			print("Found \(trackingImages.count) reference image(s) in the Photos folder.")
		} else {
			print("No reference images found in the Photos folder.")
		}
		arView.session.delegate = self
		arView.session.run(configuration)
		
		/*
		let usd = try! Entity.load(named: "modelChair.usd")
		
		
		let anchor = AnchorEntity(world: SIMD3(x: 3, y: 0, z: 3))
		anchor.addChild(usd)
		arView.scene.addAnchor(anchor)
		*/
		
		/*
        
        //1. 3D Model
        let sphere = MeshResource.generateSphere(radius: 0.05)
        let material = SimpleMaterial(color: .orange, isMetallic: true)
        let sphereEntity = ModelEntity(mesh: sphere, materials: [material])
        
        

        //2. Create Anchor (locks model onto real world)
        let sphereAnchor = AnchorEntity(world: SIMD3(x: 0, y: 0, z: 0))     //SIMD3: 3 parallell calculations
        sphereAnchor.addChild(sphereEntity)

        //3. Add anchor to scene
        arView.scene.addAnchor(sphereAnchor)
		*/
    }
	
	func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
			// Find the image anchor
			guard let imageAnchor = anchors.first(where: { $0 is ARImageAnchor }) as? ARImageAnchor else { return }
			
			// Load the chair model
			let usd = try! Entity.load(named: "modelChair.usd")
			
			// Create an anchor entity and add the chair model as its child
			let anchor = AnchorEntity(anchor: imageAnchor)
			anchor.addChild(usd)
			
			// Add the anchor to the scene
			arView.scene.addAnchor(anchor)
		}
}


