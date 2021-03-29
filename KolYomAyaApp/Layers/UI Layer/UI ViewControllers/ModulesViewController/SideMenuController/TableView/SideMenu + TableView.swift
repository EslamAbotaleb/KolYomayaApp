//
//  SideMenu + TableView.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/21/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        self.tableView.isScrollEnabled = false
        return "Section \(section)"
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 120.0)
        view.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.4666666667, alpha: 1)
        view.frame.size.width = self.view.frame.size.width
        view.frame.size.height = 200
        let img = UIImage(named:"1024X1024_logo")

        let imageView : UIImageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 30, width: self.view.bounds.width, height: 120.0)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.frame.size.width = view.frame.size.width
        imageView.frame.size.height = 200
        imageView.image = img
        view.addSubview(imageView)

        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.reuseIdentifier, for: indexPath) as? SideMenuCell else {
            fatalError("SideMenutableViewCell not found")
        }
        let sideMenuItemViewModel = viewModel.items[indexPath.row]
        cell.configure(sideMenuItemViewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        viewModel.selectRow(indexPath: indexPath.row)
    }
}
