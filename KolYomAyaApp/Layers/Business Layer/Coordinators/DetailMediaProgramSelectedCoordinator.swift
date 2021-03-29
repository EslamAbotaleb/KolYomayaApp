//
//  DetailMediaProgramSelectedCoordinator.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
final class DetailMediaProgramSelectedCoordinator: Coordinator, DelegateElsharawayMediaSelect {
    var programId: Int?
    var programName: String?
   private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var viewModel: MediaList?
    private var viewController: UIViewController?

    func didFinish() {
        parentCoordinator?.childDidFinish?(self)
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    func start() {
        let viewController = DetailMediaProgramSelectedController.init(nibName: "DetailMediaProgramSelectedController", bundle: nil)
        viewController.delegateElsharawyProgramId = self
        viewController.delegateElsharawyProgramId?.programId = programId
        viewController.delegateElsharawyProgramId?.programName = programName
        viewController.viewModel = viewModel
        let detaiLMediaProgramCoordinator = DetailMediaProgramSelectedCoordinator(viewController: viewController)
        childCoordinators.append(detaiLMediaProgramCoordinator)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        appDelegate.window?.rootViewController = navigationController
    }
    
    
}
