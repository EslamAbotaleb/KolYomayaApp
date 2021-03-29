//
//  SideMenuViewController.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/21/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

class SideMenuViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SideMenuListViewModel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.insetsContentViewsToSafeArea = false
        self.tableView.contentInsetAdjustmentBehavior = .never
        print("statusAppearView\(statusAppearView)")
        bottomViewPlayer(isHidden: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = SideMenuListViewModel()
        viewModel.registtableViewCell(nibName: "SideMenuCell", tableView: tableView!)
        viewModel.onUpdate = {  [weak self] in
            self?.tableView.reloadData()
        }
       
    }
   
}
