//
//  ElsharawyViewController + TableView.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/26/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
extension ElsharawyViewController: UITableViewDataSource, UITableViewDelegate {
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows() ?? 0
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ElsharawyTableViewCell.reuseIdentifier, for: indexPath) as? ElsharawyTableViewCell else {
            fatalError("This cell not found called elsharahy section programs")
        }
        cell.configure(viewModel: (self.elsharawyProgramModel?.programsList[indexPath.row])!)
        return cell
      }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.programId = self.elsharawyProgramModel?.programsList[indexPath.row].id
        coordinator?.programName = self.elsharawyProgramModel?.programsList[indexPath.row].programName
        UserDefaults.standard.setValue(coordinator?.programId, forKeyPath: "programId")
        UserDefaults.standard.setValue(coordinator?.programName, forKeyPath: "programName")
        UserDefaults.standard.synchronize()
        coordinator?.start()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }

    
}
