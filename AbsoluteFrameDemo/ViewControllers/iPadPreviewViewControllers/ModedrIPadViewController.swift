//
//  ModedrIPadViewController.swift
//  AbsoluteFrameDemo
//
//  Created by Mykhailo Glagola on 14.07.2023.
//  Copyright © 2023 Mykhailo Glagola. All rights reserved.
//

import UIKit

class ModedrIPadViewController: iPadPreviewViewController {
    @IBOutlet private weak var homeButtonView: UIView!
    override var preferredContentSize: CGSize {
        get { CGSize(width: 220, height: 304) }
        set {
            print("Something tryes to set the size of: \(type(of: self)) to: \(newValue)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        homeButtonContainer?.alpha = 0
        updateHomeButtonPosition(animate: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        homeButtonContainer?.alpha = 0
        coordinator.animate(alongsideTransition: nil) { context in
            self.updateHomeButtonPosition()
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func updateHomeButtonPosition(animate: Bool = false) {
        let containerSpacing: CGFloat = 3
        var rotation: CGFloat = 0
        var translation: CGPoint = .zero
        
        switch view.window?.windowScene?.interfaceOrientation {
        case .none, .portrait, .unknown:
            rotation = .zero
            translation = .zero
        case .portraitUpsideDown:
            rotation = .zero
            translation.y = -canvas.bounds.height + containerSpacing * 2
        case .landscapeLeft:
            rotation = .pi / 2
            translation.x = -canvas.bounds.width / 2 - homeButtonView.bounds.width / 2
            translation.y = -canvas.bounds.width / 2 + containerSpacing
        case .landscapeRight:
            rotation = .pi / 2
            translation.x = -canvas.bounds.width / 2 - homeButtonView.bounds.width / 2
            translation.y = canvas.bounds.width / 2 - containerSpacing
        }
        homeButtonContainer.transform = CGAffineTransform(rotationAngle: rotation).translatedBy(x: translation.x, y: translation.y)
        
        
        if animate {
            UIView.animate(withDuration: 1/2) { [weak self] in
                self?.homeButtonContainer?.alpha = 1
            }
        } else {
            homeButtonContainer?.alpha = 1
        }
    }
}
