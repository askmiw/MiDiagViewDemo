//
//  SellerSearch2View.swift
//  yunyouseller
//
//  Created by 周蜜 on 15/12/14.
//  Copyright © 2015年 www.miw.cn. All rights reserved.
//

import UIKit

class MiSearchView: UIView,UITextFieldDelegate {

    @IBOutlet var keyWord: UITextField!
    @IBOutlet var beginTime: UITextField!
    @IBOutlet var endTime: UITextField!
    
    @IBAction func submit(sender: UIButton) {
        event(begin: beginTime.text, end: endTime.text, keyWord: keyWord.text)
    }
    private var event :(begin:String?,end:String?,keyWord:String?)->() = {param in}
    func setEvent(event:(begin:String?,end:String?,keyWord:String?)->()){
        self.event = event
        beginTime.delegate = self
        endTime.delegate = self
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        let nib = NSBundle.mainBundle().loadNibNamed("View", owner: nil, options: nil)
        let v = nib[0] as! MiDateSelectView
        v.frame = CGRectMake(0, 0, self.bounds.width - 20, 200)
        
        let d = MiDialogView()
        v.setEvent(NSDate()) { (date) -> () in
            if let d = date {
                let fmt = NSDateFormatter()
                fmt.dateFormat = "yyyy-MM-dd"
                textField.text = fmt.stringFromDate(d)
            }
            d.close()
        }
        d.show(v)
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
