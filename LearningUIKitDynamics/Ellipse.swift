//
//  Ellipse.swift
//  LearningUIKitDynamics
//
//  Created by Rommel Rico on 10/17/17.
//  Copyright © 2017 Rommel Rico. All rights reserved.
//

import UIKit

class Ellipse: UIView {
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType { return .ellipse }
}
