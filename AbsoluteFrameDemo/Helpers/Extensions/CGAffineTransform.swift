//
//  CGAffineTransform.swift
//  AbsoluteFrameDemo
//
//  Created by Mykhailo Glagola on 14.07.2023.
//  Copyright © 2023 Mykhailo Glagola. All rights reserved.
//

import UIKit

extension CGAffineTransform {
    init(_ interfaceOrientation: UIInterfaceOrientation?) {
        let angle: CGFloat
        switch interfaceOrientation {
        case .portraitUpsideDown:
            angle = .pi
        case .landscapeRight:
            angle = 3 * .pi / 2
        case .landscapeLeft:
            angle = .pi / 2
        default:
            angle = 0
        }
        self = CGAffineTransform(rotationAngle: angle)
    }
}
