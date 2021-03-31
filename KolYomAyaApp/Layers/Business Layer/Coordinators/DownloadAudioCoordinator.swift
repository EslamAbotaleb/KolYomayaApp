//
//  DownloadAudioCoordinator.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 3/29/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import Foundation

import UIKit
import Foundation
final class DownloadAudioCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    private var viewController: UIViewController?
  
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    func didFinish() {
        parentCoordinator?.childDidFinish?(self)
    }

    func start() {
        let viewController = PlayAudioOfflineViewController.init(nibName: "PlayAudioOfflineViewController", bundle: nil)
        let downloadAudioCoordinator = DownloadAudioCoordinator(viewController: viewController)
        childCoordinators.append(downloadAudioCoordinator)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        appDelegate.window?.rootViewController = navigationController
    }
   
}
