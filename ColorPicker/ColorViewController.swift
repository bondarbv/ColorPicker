//
//  ColorViewController.swift
//  ColorPicker
//
//  Created by Bohdan on 20.05.2022.
//

import UIKit
import SnapKit

class ColorViewController: UIViewController {
    
    //MARK: - Properties
    var redValue: Float!
    var blueValue: Float!
    var greenValue: Float!
    
    //MARK: - UI
    let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 30/255, green: 55/255, blue: 115/255, alpha: 1.0)
        view.layer.cornerRadius = 20
        return view
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let mainStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let colorLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let valueLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let slidersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let textFieldsStackVIew: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = -5
        return stackView
    }()
    
    let redLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Red:"
        return label
    }()
    
    let greenLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Green:"
        return label
    }()
    
    let blueLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "Blue:"
        return label
    }()
    
    let redValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0.66"
        return label
    }()
    
    let greenValueLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "0.55"
        return label
    }()
    
    let blueValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0.44"
        return label
    }()
    
    let redSlider: UISlider = {
       let slider = UISlider()
        slider.minimumValue = 0.00
        slider.maximumValue = 1.00
        slider.minimumTrackTintColor = .systemRed
        slider.addTarget(self, action: #selector(redValueChanged), for: .valueChanged)
        return slider
    }()
    
    let greenSlider: UISlider = {
       let slider = UISlider()
        slider.minimumValue = 0.00
        slider.maximumValue = 1.00
        slider.minimumTrackTintColor = .systemGreen
        slider.addTarget(self, action: #selector(greenValueChanged), for: .valueChanged)
        return slider
    }()
    
    let blueSlider: UISlider = {
       let slider = UISlider()
        slider.minimumValue = 0.00
        slider.maximumValue = 1.00
        slider.minimumTrackTintColor = .systemBlue
        slider.addTarget(self, action: #selector(blueValueChanged), for: .valueChanged)
        return slider
    }()
    
    let redValueTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.text = "0.66"
        return textField
    }()
    
    let greenValueTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.text = "0.55"
        return textField
    }()
    
    let blueValueTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.text = "0.44"
        return textField
    }()
    
    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = #colorLiteral(red: 0.1896009147, green: 0.4289529324, blue: 0.6825695634, alpha: 1)
        layout()
    }
    
    //MARK: - Methods
    @objc private func doneButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func redValueChanged() {
        redValue = (round(redSlider.value * 100) / 100)
        redValueLabel.text = String(round(redSlider.value * 100) / 100)
        redValueTextField.text = String(round(redSlider.value * 100) / 100)
    }
    
    @objc private func greenValueChanged() {
        greenValue = (round(greenSlider.value * 100) / 100)
        greenValueLabel.text = String(round(greenSlider.value * 100) / 100)
        greenValueTextField.text = String(round(greenSlider.value * 100) / 100)
    }
    
    @objc private func blueValueChanged() {
        blueValue = (round(blueSlider.value * 100) / 100)
        blueValueLabel.text = String(round(blueSlider.value * 100) / 100)
        blueValueTextField.text = String(round(blueSlider.value * 100) / 100)
    }
    
    //MARK: - Layout
    func layout() {
        view.addSubview(colorView)
        view.addSubview(mainStackView)
        view.addSubview(doneButton)
        
        mainStackView.addArrangedSubview(colorLabelStackView)
        mainStackView.addArrangedSubview(valueLabelStackView)
        mainStackView.addArrangedSubview(slidersStackView)
        mainStackView.addArrangedSubview(textFieldsStackVIew)
        
        colorLabelStackView.addArrangedSubview(redLabel)
        colorLabelStackView.addArrangedSubview(greenLabel)
        colorLabelStackView.addArrangedSubview(blueLabel)
        
        valueLabelStackView.addArrangedSubview(redValueLabel)
        valueLabelStackView.addArrangedSubview(greenValueLabel)
        valueLabelStackView.addArrangedSubview(blueValueLabel)
        
        slidersStackView.addArrangedSubview(redSlider)
        slidersStackView.addArrangedSubview(greenSlider)
        slidersStackView.addArrangedSubview(blueSlider)
        
        textFieldsStackVIew.addArrangedSubview(redValueTextField)
        textFieldsStackVIew.addArrangedSubview(greenValueTextField)
        textFieldsStackVIew.addArrangedSubview(blueValueTextField)
        
        
        colorView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(colorView.snp.bottom).offset(40)
            make.height.equalTo(120)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.centerX.equalToSuperview()
        }
        
        colorLabelStackView.snp.makeConstraints { make in
            make.width.equalTo(mainStackView.snp.width).multipliedBy(0.18)
        }
        
        valueLabelStackView.snp.makeConstraints { make in
            make.width.equalTo(mainStackView.snp.width).multipliedBy(0.15)
        }
        
        slidersStackView.snp.makeConstraints { make in
            make.width.equalTo(mainStackView.snp.width).multipliedBy(0.48)
        }
        
        textFieldsStackVIew.snp.makeConstraints { make in
            make.width.equalTo(mainStackView.snp.width).multipliedBy(0.15)
        }
        
    }


}

