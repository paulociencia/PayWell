//
//  ViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit

class MainViewController: UIViewController {
    
    @IBOutlet var tblItems : UITableView!
    var items : NSMutableArray! = NSMutableArray()
    
    let menuBackgroundColor = UIColor.leftMenuSelection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.leftMenuBg
        
        self.populateArray()
    }
    
    func populateArray() {
        
     /*   self.addItem(FAKFontAwesome.tachometerIcon(withSize: 18), withTitle:"Dashboard", andSegue:"MyAccount")
        self.addItem(FAKFontAwesome.moneyIcon(withSize: 18), withTitle:"Holdings", andSegue:"HoldingsSegue")
        self.addItem(FAKFontAwesome.dollarIcon(withSize: 18), withTitle:"Statements", andSegue:"StatementsSegue")
        self.addItem(FAKFontAwesome.fileIcon(withSize: 18), withTitle:"My Vault", andSegue:"MyVaultSegue")
        self.addItem(FAKFontAwesome.calendarIcon(withSize: 18), withTitle:"Appointments", andSegue:"AppointmentsSegue")
        self.addItem(FAKFontAwesome.usersIcon(withSize: 18), withTitle:"Advisors", andSegue:"AdvisorsSegue")
        self.addItem(FAKFontAwesome.newspaperOIcon(withSize: 18), withTitle:"News & Research", andSegue:"NewsSegue")
        self.addItem(FAKFontAwesome.bellIcon(withSize: 18), withTitle:"Alerts", andSegue:"AlertsSegue")
        self.addItem(FAKFontAwesome.bullhornIcon(withSize: 18), withTitle:"Announcements", andSegue:"AnnouncementsSegue")
        self.addItem(FAKFontAwesome.microphoneIcon(withSize: 18), withTitle:"Interactive Agent", andSegue:"InteractiveAgent") // TODO: update segue
        self.addItem(FAKFontAwesome.signOutIcon(withSize: 18), withTitle:"Logout", andSegue:"LogoutSegue")
        */
        
        self.addItem(FAKFontAwesome.moneyIcon(withSize: 18), withTitle:"Portador", andSegue:"PortadorSegue")
        self.addItem(FAKFontAwesome.moneyIcon(withSize: 18), withTitle:"Lojista", andSegue:"LojistaSegue")
        self.addItem(FAKFontAwesome.moneyIcon(withSize: 18), withTitle:"Payments", andSegue:"PaymentsSegue")
        self.addItem(FAKFontAwesome.photoIcon(withSize: 18), withTitle:"Identity / Take a Self", andSegue:"IdentitySegue")
        self.addItem(FAKFontAwesome.qrcodeIcon(withSize: 18), withTitle:"QRCode Reader", andSegue:"QRCodeSegue")
        self.addItem(FAKFontAwesome.stickyNoteIcon(withSize: 18), withTitle:"Notes", andSegue:"TouchIdSegue")
        self.addItem(FAKFontAwesome.smileOIcon(withSize: 18), withTitle:"Face ID", andSegue:"FaceIdSegue")
        self.addItem(FAKFontAwesome.signOutIcon(withSize: 18), withTitle:"Logout", andSegue:"LogoutSegue")
    }
    
    func addItem(_ icon:FAKIcon, withTitle title:String, andSegue segue:String) {
        items.add(["icon":icon, "title":title, "segue":segue])
    }
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath indexPath: IndexPath!) -> UITableViewCell! {
        var cell : LoginTableViewCell!
        var itemDic = items.object(at: indexPath.row) as! [String:AnyObject]
        cell = tblItems.dequeueReusableCell(withIdentifier: "MenuItemCell") as! LoginTableViewCell
        
        let icon = itemDic["icon"] as! FAKIcon
        icon.addAttribute(NSForegroundColorAttributeName, value: menuBackgroundColor)
        cell.itemImg.image = icon.image(with: CGSize(width: 20, height: 20))
        
        let title = itemDic["title"] as! String
        cell.itemTitle.text = title
        
        if (indexPath.row == 0) {
            cell.contentView.backgroundColor = menuBackgroundColor
            var itemDic = items.object(at: indexPath.row) as! [String:AnyObject]
            
            let icon = itemDic["icon"] as! FAKIcon
            icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.white)
            cell.itemImg.image = icon.image(with: CGSize(width: 20, height: 20))
            
            cell.itemTitle.textColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView!, didSelectRowAtIndexPath indexPath: IndexPath!){
        let indexP :IndexPath = IndexPath(row: 0, section: 0)
        let cell1 : LoginTableViewCell! = tblItems.cellForRow(at: indexP) as! LoginTableViewCell
        self.deselectCell(cell1, indexP: indexP)
        
        let cell : LoginTableViewCell! = tblItems.cellForRow(at: indexPath) as! LoginTableViewCell
        cell.contentView.backgroundColor = menuBackgroundColor
        
        var itemDic = items.object(at: indexPath.row) as! [String : AnyObject];
        
        let icon = itemDic["icon"] as! FAKIcon
        icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.white)
        cell.itemImg.image = icon.image(with: CGSize(width: 20, height: 20))
        
        cell.itemTitle.textColor = UIColor.white
        
        let segue = itemDic["segue"] as! NSString
        if ((segue.isEqual(to: "LogoutSegue"))) {
            logout()
            self.performSegue(withIdentifier: segue as String, sender: nil)
        } else if (!(segue.isEqual(to: "None"))) {
            self.performSegue(withIdentifier: segue as String, sender: nil)
        }
    }
    
    func logout(){
        // Kim, implement logout here
        let appDelegate : AppDelegate! = UIApplication.shared.delegate as! AppDelegate
        appDelegate.logout()
        //print("logout")
    }
    
    func deselectCell(_ cell:LoginTableViewCell, indexP indexPath:IndexPath) {
        cell.contentView.backgroundColor = UIColor.clear
        var itemDic = items.object(at: indexPath.row) as! [String : AnyObject];
        
        let icon = itemDic["icon"] as! FAKIcon
        icon.addAttribute(NSForegroundColorAttributeName, value: menuBackgroundColor)
        cell.itemImg.image = icon.image(with: CGSize(width: 20, height: 20))
        
        cell.itemTitle.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView!, didDeselectRowAtIndexPath indexPath: IndexPath!){
        let cell : LoginTableViewCell! = tblItems.cellForRow(at: indexPath) as! LoginTableViewCell
        self.deselectCell(cell, indexP: indexPath)
    }
    
    @IBAction func unwindToMenuViewController(_ segue: UIStoryboardSegue) {
        
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}


