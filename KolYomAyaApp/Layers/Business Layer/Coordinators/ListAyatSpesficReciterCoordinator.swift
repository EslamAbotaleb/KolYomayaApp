//
//  ListAyatSpesficReciterCoordinator.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

final class ListAyatSpesficReciterCooridnator: Coordinator, DelegateAudioListProtocol {
    var imageReciter: String?
    
    var nameReciter: String?
    var reciterId: Int?
    var statusListen: String?
    private(set) var childCoordinators: [Coordinator] = []
    var viewController: UIViewController?
    var parentCoodinator: Coordinator?
    var audioListReciter: [AudioList]?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    func didFinish() {
        parentCoodinator?.childDidFinish?(self)
    }
    
    func start() {
        let viewController = ListAyatSpesficReciterViewController.init(nibName: "ListAyatSpesficReciterViewController", bundle: nil)
        viewController.delegateAudioListProtocol = self
        viewController.reciterId = reciterId
        viewController.delegateAudioListProtocol?.audioListReciter = audioListReciter
        viewController.delegateAudioListProtocol?.nameReciter = self.nameReciter
        viewController.delegateAudioListProtocol?.imageReciter = self.imageReciter
        viewController.statusListen = self.statusListen
        let listAyatCoordinator = ListAyatSpesficReciterCooridnator(viewController: viewController)
        childCoordinators.append(listAyatCoordinator)
        let navigationController = UINavigationController(rootViewController: viewController)
        appDelegate.window?.rootViewController = navigationController
    }
   
}

