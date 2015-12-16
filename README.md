# MiDiagViewDemo
iOS Swift 弹出框工程样例
* 可以自定义显示位置
* 可以定义关闭按钮位置
* 对键盘弹出与关闭进行监控

# 安装
拖动 MiDiagView.swift进工程即可
#最简单的应用
//显示一个已经生成好的v:UIView
    let d = MiDialogView()
    d.show(v)
显示后在非v所点有的区域单击即可关闭显示

# 复杂使用

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
        //d.show(v,pos: (h:.Center,v:.Center)) 自定义位置显示
