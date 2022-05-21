//
//  StartViewController.swift
//  ColorPicker
//
//  Created by Bohdan on 20.05.2022.
//

import UIKit

protocol ColorViewControllerDelegate {
    func changeViewColor(red: CGFloat, green: CGFloat, blue: CGFloat)
}

final class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(chooseColor))
    }
    
    @objc private func chooseColor() {
        let vc = ColorViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StartViewController: ColorViewControllerDelegate {
    func changeViewColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
