//
//  AlbumReciterCoordinator.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
final class AlbumReciterCoordinator: Coordinator, DelegateQuarnListenProtcol {
   
    
   private(set) var childCoordinators: [Coordinator] = []
    var viewController: UIViewController?
    var parentCoordinator: Coordinator?
    var reciterId: Int?
    var imageReciter: String?
    var nameReciter: String?
    var statusListen: String?
    var results: [ResultReciter]?

    init(viewController: UIViewController,statusListen: String) {
        self.viewController = viewController
        self.statusListen = statusListen
    }
    func didFinish() {
        parentCoordinator?.childDidFinish?(self)
    }
    
    func start() {
        let viewController = AlbumReciterViewController.init(nibName: "AlbumReciterViewController", bundle: nil)
        viewController.statusListen = self.statusListen
        viewController.delgateQuarnListenProtcol = self
        viewController.delgateQuarnListenProtcol?.reciterId = reciterId
        viewController.delgateQuarnListenProtcol?.imageReciter = imageReciter
        viewController.delgateQuarnListenProtcol?.nameReciter = nameReciter
        let albumReciterCoordinator = AlbumReciterCoordinator(viewController: viewController, statusListen: viewController.statusListen!)
        childCoordinators.append(albumReciterCoordinator)
        let navigationController = UINavigationController(rootViewController: viewController)
        appDelegate.window?.rootViewController = nil
        appDelegate.window?.rootViewController = navigationController
        
    }
    
    
    
}
