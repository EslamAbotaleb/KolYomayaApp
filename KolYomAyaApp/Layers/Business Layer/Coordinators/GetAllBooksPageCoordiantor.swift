//
//  GetAllBooksPageCoordiantor.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/28/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
final class GetAllBooksPageCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    private var viewController: UIViewController?
    var statusListen: String?
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    func didFinish() {
        parentCoordinator?.childDidFinish?(self)
    }
    func start() {
        let viewController = BookGetAllByPageNumberViewController.init(nibName: "BookGetAllByPageNumberViewController", bundle: nil)
        let bookGetAllByPageNumberCoordinator = GetAllBooksPageCoordinator(viewController: viewController)
        childCoordinators.append(bookGetAllByPageNumberCoordinator)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        appDelegate.window?.rootViewController = navigationController
    }
}
