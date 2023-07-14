//
//  CGRect.swift
//  AbsoluteFrameDemo
//
//  Created by Mykhailo Glagola on 14.07.2023.
//  Copyright © 2023 Mykhailo Glagola. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
