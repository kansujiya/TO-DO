//
//  TaskCell.swift
//  TO-DO
//
//  Created by Suresh Kansujiya on 24/08/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit
import ObjectiveC


class TaskCell: UITableViewCell {

    @IBOutlet weak var taskName : UILabel?
    @IBOutlet weak var btnCancel : UIButton?
    var currentTask : Task?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populateData(task : Task){
        taskName?.text = task.name
        btnCancel?.hidden = !task.isCancelBtnShown
        currentTask = task
    }
    
    func updateBtnCancelState(task : Task){
        btnCancel?.hidden = !task.isCancelBtnShown
    }
    
    //MARK: Private Method
    
    @IBAction func btnCancelClicked(sender : AnyObject?)
    {
        let btnSender = sender as! UIButton
        btnSender.hidden = true
        currentTask!.isCancelBtnShown = false
    }
}
