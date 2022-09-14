////
////  MessageViewController.swift
////  iOSerBuilding
////
////  Created by 张海川 on 2022/3/6.
////
//
//import UIKit
//import ObjectiveC.runtime
//
//class MessageViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        
//        perform(NSSelectorFromString("triplekill"), with: nil)
//    }
//    
////    @objc func triplekill() {
////        print("Triple Kill!").
////    }
//    
//    @objc func backupMethod() {
//        print("backupMethod")
//    }
//    
////    override class func resolveInstanceMethod(_ sel: Selector!) -> Bool {
////        if sel == NSSelectorFromString("triplekill") {
////            let imp = class_getMethodImplementation(self, #selector(backupMethod))!
////            let method = class_getInstanceMethod(self, #selector(backupMethod))!
////            let types = method_getTypeEncoding(method)
////            return class_addMethod(self, sel, imp, types)
////        }
////
////        return false
////    }
//    
////    override func forwardingTarget(for aSelector: Selector!) -> Any? {
////        let other = OtherClass()
////        if other.responds(to: aSelector) {
////            return other
////        }
////
////        return super.forwardingTarget(for: aSelector)
////    }
//    
//    methodSignature(forSelector: <#T##Selector#>)
//    
//    override func doesNotRecognizeSelector(_ aSelector: Selector!) {
//        print("crash")
//    }
//}
//
//class OtherClass: NSObject {
//    
//    @objc func triplekill() {
//        print("OtherClass Triple Kill!")
//    }
//}
