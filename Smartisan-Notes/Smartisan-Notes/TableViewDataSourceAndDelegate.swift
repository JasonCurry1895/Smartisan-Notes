//
//  TableViewDataSourceAndDelegate.swift
//  Smartisan-Notes
//
//  Created by DiegoSan on 3/2/16.
//  Copyright © 2016 DiegoSan. All rights reserved.
//

import UIKit
import RealmSwift

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! NotesTableViewCell
        cell.note = notes[indexPath.row]
        
        return cell
    }
}


// MARK: - NotesTableViewCellDelegate
extension HomeViewController: NotesTableViewCellDelegate {
    func slideToDelete(cell: NotesTableViewCell) {
        // 1.
        let indexPath = tableView.indexPathForCell(cell)!
        
        // 2.
        try! realm.write { () -> Void in
            realm.delete(notes[indexPath.row])
        }
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
}