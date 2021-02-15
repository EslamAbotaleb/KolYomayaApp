//
//  TermsAndConditionCoordinator.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 2/15/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import Foundation
import UIKit
import Foundation
final class TermsAndConditionsCoordinator: Coordinator {
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
        let viewController = TermsAndConidtionViewController.init(nibName: "TermsAndConidtionViewController", bundle: nil)
        let qiblaLocationCoordinator = TermsAndConditionsCoordinator(viewController: viewController)
        childCoordinators.append(qiblaLocationCoordinator)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        appDelegate.window?.rootViewController = navigationController
    }
   
}
