//
//  ElsharawyMediaProgramId + TableView .swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/26/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

extension ElsharawyMediaProgramIdViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ElsharawyMediaProgramIdTableViewCell.reuseIdentifier, for: indexPath) as? ElsharawyMediaProgramIdTableViewCell else {
            fatalError("Not found elsharawy media program id")
        }
        cell.configure(viewModel: (self.elsharawyMediaModel!.mediaList?[indexPath.row])!)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.viewModel = self.elsharawyMediaModel?.mediaList?[indexPath.row]
        coordinator?.programId = self.elsharawyMediaModel?.mediaList?[indexPath.row].id
        coordinator?.programName = self.elsharawyMediaModel?.mediaList?[indexPath.row].program?.programName
//        coordinator?.programName =  self.elsharawyProgramModel?.programsList[indexPath.row].programName
        
        coordinator?.start()
    }
}
