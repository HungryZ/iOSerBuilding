//
//  RxSwiftViewController.swift
//  iOSerBuilding
//
//  Created by 张海川 on 2022/9/17.
//

import UIKit
import RxSwift
import RxCocoa
import Then

class RxSwiftViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    @IBOutlet weak var doSomethingOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let minimalUsernameLength: Int = 4
        let minimalPasswordLength: Int = 4

        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(
            usernameValid,
            passwordValid
        ) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid.bind(to: usernameValidOutlet.rx.isHidden).disposed(by: disposeBag)
        passwordValid.bind(to: passwordValidOutlet.rx.isHidden).disposed(by: disposeBag)
        everythingValid.bind(to: doSomethingOutlet.rx.isEnabled).disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap.subscribe { [weak self] what in
            self?.showAlert()
        }.disposed(by: disposeBag)
        
    }
    
    func showAlert() {
        let alertVC = UIAlertController(title: "RxExample",
                                        message: "This is wonderful",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        
        navigationController?.present(alertVC, animated: true)
    }
}
