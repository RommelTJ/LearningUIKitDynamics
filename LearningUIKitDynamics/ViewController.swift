//
//  ViewController.swift
//  LearningUIKitDynamics
//
//  Created by Rommel Rico on 10/17/17.
//  Copyright © 2017 Rommel Rico. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    let manager:CMMotionManager = CMMotionManager()
    let noiseField = UIFieldBehavior.noiseField(smoothness: 1.0, animationSpeed: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up a UIDynamicAnimator on the view.
        animator = UIDynamicAnimator(referenceView: view)
        
        // Add a square to the view.
        let square = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        square.backgroundColor = .blue
        view.addSubview(square)
        
        // Add an ellipsis to the view.
        let ellipse = Ellipse(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        ellipse.backgroundColor = .yellow
        ellipse.layer.cornerRadius = 50
        view.addSubview(ellipse)
        
        
        let items = [square, ellipse]
        
        // Create some gravity so the items always fall towards the bottom.
        let gravity = UIGravityBehavior(items: items)
        animator.addBehavior(gravity)
        
        // Set up the noise field.
        noiseField.addItem(square)
        noiseField.addItem(ellipse)
        noiseField.strength = 0.5
        animator.addBehavior(noiseField)
        
        // Don't let objects overlap each other - set up a collide behavior.
        let collision = UICollisionBehavior(items: items)
        collision.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 20, left: 5, bottom: 5, right: 5))
        animator.addBehavior(collision)
        
        // Used to alter the gravity so it always points down.
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.1
            manager.startDeviceMotionUpdates(to: .main, withHandler: {
                (deviceManager: CMDeviceMotion?, error: Error?) in
                gravity.gravityDirection = CGVector(dx: deviceManager!.gravity.x, dy: -deviceManager!.gravity.y)
            })
        }
    }

    @IBAction func strengthValueChanged(_ sender: UISlider) {
        noiseField.strength = CGFloat(sender.value)
    }
    
    @IBAction func smoothnessValueChanged(_ sender: UISlider) {
        noiseField.smoothness = CGFloat(sender.value)
    }
    
    @IBAction func speedValueChanged(_ sender: UISlider) {
        noiseField.animationSpeed = CGFloat(sender.value)
    }
    
}

