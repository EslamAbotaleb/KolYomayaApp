//
//  DetailTafserBookSelectedCoordinator.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/24/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

final class DetailTafserBookSelectCoordinator: Coordinator, DelegateDetailTafserBookSelect {
    var numberOfPages: Int?
    
    var bookId: Int?
    
    var bookName: String?
    
  private(set) var childCoordinators: [Coordinator] = []
    var parentCooridnator: Coordinator?
    private var viewController: UIViewController?
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    func didFinish() {
        parentCooridnator?.childDidFinish?(self)
    }
    
    func start() {
        
        let viewController = DetailTafserBookSelectViewController.init(nibName: "DetailTafserBookSelectViewController", bundle: nil)
        viewController.delgateBook = self

        viewController.delgateBook?.bookId = bookId
        viewController.delgateBook?.numberOfPages = numberOfPages
        viewController.delgateBook?.bookName = bookName
        let detailTafserBookSelectCoordinator = DetailTafserBookSelectCoordinator(viewController: viewController)
        childCoordinators.append(detailTafserBookSelectCoordinator)
        let navigationController = UINavigationController(rootViewController: viewController)
        appDelegate.window?.rootViewController = navigationController
    }
    
    
}
