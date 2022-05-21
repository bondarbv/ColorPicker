//
//  StartViewController.swift
//  ColorPicker
//
//  Created by Bohdan on 20.05.2022.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(chooseColor))
    }
    
    @objc private func chooseColor() {
        let vc = ColorViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
