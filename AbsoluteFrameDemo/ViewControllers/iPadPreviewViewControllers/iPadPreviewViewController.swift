//
//  iPadPreviewViewController.swift
//  AppAbsoluteFrame
//
//  Created by Mykhailo Glagola on 06.12.2022.
//  Copyright © 2022 Mykhailo Glagola. All rights reserved.
//

import UIKit
import AppAbsoluteFrame

class iPadPreviewViewController: UIViewController {
    @IBOutlet weak var padImageView: UIImageView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var homeButtonContainer: UIView!
    @IBOutlet weak var canvas: UIView!
    
    private lazy var appFrameLayer: CALayer = {
        let layer = CALayer()
        layer.frame = canvas.bounds
        layer.backgroundColor = view.tintColor.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0
        canvas.layer.addSublayer(layer)
        return layer
    } ()
    
    static var storyboardIdentifier: String {
        String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { context in
            self.animateSizeChanged()
        }
    }
    
    private func animateSizeChanged() {
        view.transform = CGAffineTransform(view.window?.windowScene?.interfaceOrientation)
    }
    
    func applicationDidChangeOnScreen(frame: CGRect) {
        // Ignoring frame since fixed screen bounds and fixed app frame is needed
        guard let window = view.window, let scene = window.windowScene else { return }
        let absoluteFrame = AppAbsoluteFrame(window: window, scene: scene)
        
        let screenBounds = absoluteFrame.fixedScreenBounds
        let scale = canvas.bounds.width / screenBounds.width
        
        let previewFrame = absoluteFrame.fixedAppFrame.applying(CGAffineTransform(scaleX: scale, y: scale))
        let isSlideOver = min(frame.minX, frame.minY) > 0
        
        appFrameLayer.cornerRadius = isSlideOver ? 5 : 0
        appFrameLayer.shadowOpacity = isSlideOver ? 0.2 : 0
        
        appFrameLayer.position = previewFrame.center
        
        appFrameLayer.bounds = CGRect(origin: .zero, size: previewFrame.size)
        animateSizeChanged()
    }
}
