//
//  DataStructureViewController.swift
//  iOSerBuilding
//
//  Created by 张海川 on 2022/3/5.
//

import UIKit

class DataStructureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        BinaryTree.create("124##5##36##7##")?.traverse(.inorder)
    }
}
