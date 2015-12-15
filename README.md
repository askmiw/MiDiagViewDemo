# MiDiagViewDemo
iOS Swift 弹出框工程样例
1、可以自定义显示位置
2、可以定义关闭按钮位置
3、对键盘弹出与关闭进行监控

# 安装
拖动 MiDiagView.swift进工程即可

# 使用

        let nib = NSBundle.mainBundle().loadNibNamed("View", owner: nil, options: nil)
        let v = nib[0] as! MiDateSelectView                     //自定义复杂View
        v.frame = CGRectMake(0, 0, self.bounds.width - 20, 200) //指定大小
        
        let d = MiDialogView()
        v.setEvent(NSDate()) { (date) -> () in                  //自定义View需要一个回调来关闭diag
            if let d = date {
                let fmt = NSDateFormatter()
                fmt.dateFormat = "yyyy-MM-dd"
                textField.text = fmt.stringFromDate(d)
            }
            d.close()   //关闭
        }
        d.show(v)       //显示
