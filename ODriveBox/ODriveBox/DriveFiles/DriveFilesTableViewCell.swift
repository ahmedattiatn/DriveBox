//
//  DriveFilesTableViewCell.swift
//  ODriveBox
//
//  Created by Ahmed ATIA on 05/01/2019.
//  Copyright © 2019 Ahmed ATIA. All rights reserved.
//

import UIKit

class DriveFilesTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var isDirImageView: UIImageView!
    
    // MARK: - Proprities
    let  dirImageName =  "dir"
    let  fileImageName =  "files"
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods
    func updateGraphicElementsOfOffer(_ file: File) {
        fileNameLabel.text = file.name
        fileImageView.image = file.isDir ? UIImage(named: dirImageName) : UIImage(named: fileImageName)
        isDirImageView.isHidden = file.isDir ? false : true
    }
}
