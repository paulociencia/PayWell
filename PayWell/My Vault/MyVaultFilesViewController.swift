//
//  MyVaultFilesViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit

class MyVaultFilesViewController: UIViewController {
    
    let files = ["IRS.pdf", "Statement.pdf", "Archives_08.png", "Files.pdf", "Invoice_01.pdf"]
    
    //myVaultFilesCell
    
}

extension MyVaultFilesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(files.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myVaultFilesCell")!
        cell.textLabel?.text = files[indexPath.row]
        
        let downloadIcon:FAKFontAwesome = FAKFontAwesome.folderIcon(withSize: 25)
        let downloadIconImage:UIImage = downloadIcon.image(with: CGSize(width: 25, height: 25))
        cell.imageView?.image = downloadIconImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("MY FILES")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let upload = UITableViewRowAction(style: .default, title: "Upload") {(action, index) in
            //print("delete button pressed")
        }
        
        upload.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") {(action, index) in
            //print("delete button pressed")
        }
        
        return [delete, upload]
    }
    
}

