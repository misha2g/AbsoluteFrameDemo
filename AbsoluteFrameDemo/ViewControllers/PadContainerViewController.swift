//
//  PadContainerViewController.swift
//  AppAbsoluteFrame
//
//  Created by Mykhailo Glagola on 08.12.2022.
//  Copyright © 2022 Mykhailo Glagola. All rights reserved.
//

import UIKit
import Combine
import AppAbsoluteFrame

class PadContainerViewController<T: iPadPreviewViewController>: UIViewController {
    private var previewViewController: iPadPreviewViewController
    private var subscribers = Set<AnyCancellable>()
    
    init(_ frameListener: AppFrameListener) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let controller: T = storyboard.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Cannot initialize \(T.storyboardIdentifier)")
        }
        previewViewController = controller
        super.init(nibName: nil, bundle: nil)
        frameListener.$applicationFrame
            .sink { [weak self] appFrame in
                self?.previewViewController.applicationDidChangeOnScreen(frame: appFrame)
            }
            .store(in: &subscribers)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewViewController.willMove(toParentViewController: self)
        view.addSubview(previewViewController.view)
        addChildViewController(previewViewController)
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillLayoutSubviews() {
        previewViewController.view.center = view.center
        previewViewController.view.bounds.size = previewViewController.preferredContentSize
        super.viewWillLayoutSubviews()
    }
}
