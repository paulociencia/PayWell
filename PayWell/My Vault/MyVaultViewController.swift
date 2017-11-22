//
//  MyVaultViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit


class MyVaultViewController: UIViewController {
    
    //@IBOutlet weak var fileName: UILabel!
    //self.fileName.text = "IRS.pdf"
    let folders = ["Personal Folder", "Shared With Maicon Borges"]
    
    
    
}

extension MyVaultViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myVaultCell")!
        cell.textLabel?.text = folders[indexPath.row]
        
        let downloadIcon:FAKFontAwesome = FAKFontAwesome.folderIcon(withSize: 25)
        let downloadIconImage:UIImage = downloadIcon.image(with: CGSize(width: 25, height: 25))
        cell.imageView?.image = downloadIconImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected: \(indexPath.row)")
        // TODO: PASS DATA
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let newFolder = UITableViewRowAction(style: .default, title: "New Folder") {(action, index) in
            //print("delete button pressed")
        }
        
        newFolder.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") {(action, index) in
            //print("delete button pressed")
        }
        
        return [delete, newFolder]
    }
    
    
}

