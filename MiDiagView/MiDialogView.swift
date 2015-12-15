//
//  MiDialogView.swift
//  弹窗，可定制显示位置、关闭按钮位置
//
//  Created by 周蜜 on 15/12/14.
//  Copyright © 2015年 www.miw.cn. All rights reserved.
//

import UIKit


enum MiDialogPOSH {
    case Default,Center,Left,Right
}
enum MiDialogPOSV {
    case Default,Center,Top,Bottom
}
var _____keyBoardframe : CGRect?
class MiDialogView: UIView {
    
    init(){
        let size = UIScreen.mainScreen().bounds.size
        super.init(frame: CGRectMake(0, 0, size.width, size.height))
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     显示函数
     
     - parameter v:        需要显示的View
     - parameter pos:      显示View所在位置
     - parameter closePos: 关闭按钮位置
     */
    func show(v:UIView,
        pos:(h:MiDialogPOSH,v:MiDialogPOSV) = (.Center,.Bottom),
        closePos:(h:MiDialogPOSH,v:MiDialogPOSV) = (.Default,.Default)){
            
            self.resignFirstResponder()
            
            for x in self.subviews {
                x.removeFromSuperview()
            }
            
            let size = v.bounds.size
            var x :CGFloat = 20
            var y:CGFloat = 20
            switch pos.h {
            case .Center:
                x = (self.bounds.width - size.width) / 2
            case .Left:
                x = 20
            case .Right:
                x = self.bounds.width - size.width - 20
            case .Default:
                x = v.frame.origin.x
            }
            switch pos.v {
            case .Center:
                y = (self.bounds.height - size.height) / 2
            case .Top:
                y = 20
            case .Bottom:
                y = self.bounds.height - size.height
            case .Default:
                y = v.frame.origin.y
            }
            
            
            let btn = UIButton()
            btn.setTitle("✕", forState: UIControlState.Normal)
            var btnx :CGFloat = 20
            var btny:CGFloat = 20
            switch closePos.h {
            case .Center:
                btnx = x + size.width / 2
            case .Left:
                btnx = x
            case .Right:
                fallthrough
            case .Default:
                btnx = x + size.width
            }
            switch closePos.v {
            case .Center:
                btny = y + size.height
            case .Default:
                fallthrough
            case .Top:
                btny = y
            case .Bottom:
                y = y - 20
                btny = y + size.height
            }
            
            v.frame = CGRectMake(x, y, size.width, size.height)
            self.addSubview(v)
            
            self.maxY = y + size.height 
            
            btn.frame =  CGRectMake(btnx - 10, btny - 10, 20, 20)
            btn.layer.cornerRadius = 10
            btn.layer.masksToBounds = true
            btn.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.7)
            btn.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(btn)
            
            toShow()
            fixPos()
    }
    private var maxY :CGFloat = 0
    private func toShow(){
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "close"))
        
        UIApplication.sharedApplication().windows.first!.addSubview(self)
        UIApplication.sharedApplication().windows.first!.endEditing(true)
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            self.layer.opacity = 1
            self.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }, completion: nil)
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardOpen:", name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardOpen:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardOpen(notification:NSNotification){
        let userinfo:NSDictionary = notification.userInfo!
        let value: AnyObject? = userinfo[UIKeyboardFrameEndUserInfoKey]
        _____keyBoardframe = value?.CGRectValue
        print("位置：",maxY,_____keyBoardframe)
        
        fixPos()
        
    }
    private func fixPos(){
        if let kpos = _____keyBoardframe {
            var inputFrame = self.frame
            let s = self.bounds.size.height - maxY //- keyframe!.origin.y
            if s < kpos.size.height {
                inputFrame.origin.y = kpos.origin.y - self.bounds.size.height + s
                self.frame = inputFrame
                self.layoutIfNeeded()
            }
        }
    }
    func close(){
        for x in self.subviews {
            x.removeFromSuperview()
        }
        self.removeFromSuperview()
        
        let center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }
}
