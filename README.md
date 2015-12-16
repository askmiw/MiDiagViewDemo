# MiDiagViewDemo
接触swift有快1年了，之前也没弄过OC,边学边做工程，但一直没能找到一个合适的弹出自定义框组件。
第一次学着在gitHub上分享自己的成果，望大家指教。

# 效果图
![](https://github.com/askmiw/MiDiagViewDemo/blob/master/1.png)
![](https://github.com/askmiw/MiDiagViewDemo/blob/master/2.png)
![](https://github.com/askmiw/MiDiagViewDemo/blob/master/3.png)

# 基本功能
iOS Swift 弹出框工程样例
* 可以自定义显示位置
* 可以定义关闭按钮位置
* 对键盘弹出与关闭进行监控
* 在非显示区域单击可关闭

# 安装
拖动 MiDiagView.swift进工程即可
#基本使用方法
//显示一个已经生成好的v:UIView

        let d = MiDialogView()
        d.show(v)       //显示
        
显示后在非v所占有区域单击即可关闭显示

# 使用自定义视图

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
