//
//  ViewController.swift
//  MiDiagViewDemo
//
//  Created by 周蜜 on 15/12/15.
//  Copyright © 2015年 www.miw.cn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let d = MiDialogView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var dateResult: UILabel!
    @IBAction func doDatePicker(sender: UIButton) {
        let nib = NSBundle.mainBundle().loadNibNamed("View", owner: nil, options: nil)
        let v = nib[0] as! MiDateSelectView
        v.frame.size = CGSizeMake(view.bounds.width - 20, 200)
        
        v.setEvent(NSDate()) { (date) -> () in
            if let d = date {
                let fmt = NSDateFormatter()
                fmt.dateFormat = "yyyy-MM-dd"
                self.dateResult.text = fmt.stringFromDate(d)
            }
            self.d.close()
        }
        d.show(v,pos: (h:.Center,v:.Center))
    }

    @IBOutlet var multResult: UILabel!
    @IBAction func doTest(sender: UIButton) {
        let nib = NSBundle.mainBundle().loadNibNamed("View", owner: nil, options: nil)
        let v = nib[1] as! MiSearchView
        v.frame.size = CGSizeMake(view.bounds.width - 20, 200)
        
        v.setEvent { (begin, end, keyWord) -> () in
            self.multResult.text = "\(begin!)  \(end!)  \(keyWord!)"
            self.d.close()
        }
        d.show(v)
    }

}

