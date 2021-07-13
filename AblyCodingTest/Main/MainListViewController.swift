//
//  ViewController.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit

class MainListViewController: UIViewController {

    let mainListView = MainLitView()
    let mainListViewModel = MainListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainListView)
        mainListView.setLayout()
        mainListViewModel.configure()
        // Do any additional setup after loading the view.
    }
    
    func setBinding() {
        
    }
}

