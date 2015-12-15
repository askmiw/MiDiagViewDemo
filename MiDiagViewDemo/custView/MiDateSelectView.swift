//
//  MiDateSelectView.swift
//  yunyouseller
//
//  Created by 周蜜 on 15/12/15.
//  Copyright © 2015年 www.miw.cn. All rights reserved.
//

import UIKit

class MiDateSelectView: UIView {

    @IBOutlet var datepicker: UIDatePicker!

    @IBAction func doOK(sender: UIButton) {
        event(date: sender.tag == 1 ? datepicker.date : nil)
    }
    private var event:(date:NSDate?)->() = {param in}
    func setEvent(curDate:NSDate,event:(date:NSDate?)->()){
        datepicker.date = curDate
        self.event = event
    }
}
func formatDate(date:NSDate,fmt:String)->String{
    let formatter = NSDateFormatter()
    formatter.dateFormat = fmt
    return formatter.stringFromDate(date)
}