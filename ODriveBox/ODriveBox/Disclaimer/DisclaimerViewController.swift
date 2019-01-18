//
//  DisclaimerViewController.swift
//  ODriveBox
//
//  Created by Ahmed ATIA on 05/01/2019.
//  Copyright © 2019 Ahmed ATIA. All rights reserved.
//

import UIKit

class DisclaimerViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var mainDirInfoView: UIView!
    @IBOutlet weak var notcieLabel: UILabel!
    @IBOutlet weak var noticeSecondLabel: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayViewOrGoToFDriveilesVC()
    }
    
    // MARK: - User Action
    @IBAction func goToListOfFiles(_ sender: Any) {
        self.performSegue(withIdentifier: UtilitySegueId.driveFiles.rawValue, sender: String.self)
    }
    
    // MARK: - Methods
    private func displayViewOrGoToFDriveilesVC() {
        self.noticeSecondLabel.alpha = 0
        self.confirmBtn.alpha = 0
        // Chek if we already have the id in user default
        if UserDefaults.standard.string(forKey: UtilityUserDefaultKey.mainDriveID.rawValue) != nil {
            self.mainDirInfoView.alpha = 0
            self.performSegue(withIdentifier: UtilitySegueId.driveFiles.rawValue, sender: String.self)
        }
        else {
            getMainDirData()
        }
    }
    
    private func getMainDirData() {
        File.fetchFilesFromDrive{(success,error) in
            if success {
                print("Fetching Main Dir Data With Success...")
                self.animateMainDirView()
            }else {
                if let error = error {
                    print("Failure while Fetching Main Dir Data ...",error)
                }
            }
        }
    }
    
    private func animateMainDirView() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.notcieLabel.center.y += -10
        }, completion: { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.notcieLabel.alpha = 0
                self.noticeSecondLabel.center.y += -10
                self.confirmBtn.center.y += -10
                self.noticeSecondLabel.alpha = 1
                self.confirmBtn.alpha = 1
            })
        })
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == UtilitySegueId.driveFiles.rawValue {
            let controller = segue.destination as! DriveFilesViewController
            // data from user Default
            if let DriveDirID = UserDefaults.standard.string(forKey: UtilityUserDefaultKey.mainDriveID.rawValue) {
                controller.mainParentID = DriveDirID
            }
        }
    }
}
