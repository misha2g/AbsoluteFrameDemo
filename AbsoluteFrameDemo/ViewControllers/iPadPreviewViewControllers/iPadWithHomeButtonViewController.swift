//
//  iPadWithHomeButtonViewController.swift
//  AbsoluteFrameDemo
//
//  Created by Mykhailo Glagola on 14.07.2023.
//  Copyright © 2023 Mykhailo Glagola. All rights reserved.
//

import UIKit

class iPadWithHomeButtonViewController: iPadPreviewViewController {
    override var preferredContentSize: CGSize {
        get { CGSize(width: 214, height: 304) }
        set {
            print("Something tryes to set the size of: \(type(of: self)) to: \(newValue)")
        }
    }
}
