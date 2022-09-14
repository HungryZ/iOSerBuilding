//
//  RxSwiftViewController.swift
//  iOSerBuilding
//
//  Created by 张海川 on 2021/8/19.
//

import UIKit
import RxSwift
import RxCocoa
import Then

struct Test {
    var num: Int
}

@objc class RxSwiftViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var textField = UITextField(frame: CGRect(x: 100, y: 100, width: 100, height: 50)).then {
        $0.text = "10000"
    }
    
    deinit {
        print("\(type(of: self).description()).\(#function)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textField);
        
//        textField.rx.text.on(<#T##event: Event<String?>##Event<String?>#>)
        textField.rx.text.orEmpty.changed.subscribe { next in
            print(next as String)
        }.disposed(by: disposeBag)

        
        var test = Test(num: 4)
        print(withUnsafePointer(to: &test, {$0}))
        test.num = 5
        print(withUnsafePointer(to: &test, {$0}))
        
        var test2 = test
        print(withUnsafePointer(to: &test2, {$0}))
    }
}
