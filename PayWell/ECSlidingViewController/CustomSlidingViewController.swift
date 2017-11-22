//
//  CustomSlidingViewController.swift
//  DashPress
//
//  Genesis Global
//

import UIKit

class CustomSlidingViewController: ECSlidingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate : Bool {
//        if (appDelegate.shouldRotate == 0) {
//            return 0
//        } else {
//            return 1
//        }
        return true
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.shouldRotate == 0) {
            return UIInterfaceOrientationMask.portrait
        } else {
            return UIInterfaceOrientationMask.all
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
