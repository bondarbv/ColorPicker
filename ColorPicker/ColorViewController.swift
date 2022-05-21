//
//  ColorViewController.swift
//  ColorPicker
//
//  Created by Bohdan on 20.05.2022.
//

import UIKit
import SnapKit

final class ColorViewController: UIViewController {
    
    var delegate: ColorViewControllerDelegate!
    
    //MARK: - Properties
    private var redValue: CGFloat = CGFloat.random(in: 0.00 ... 1.00)
    private var blueValue: CGFloat = CGFloat.random(in: 0.00 ... 1.00)
    private var greenValue: CGFloat = CGFloat.random(in: 0.00 ... 1.00)
    
    //MARK: - UI
    private let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.addTarget(self, action: #selector(saveColor), for: .touchUpInside)
        return button
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let colorLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private let valueLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private let slidersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private let textFieldsStackVIew: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private let redLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Red:"
        return label
    }()
    
    private let greenLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Green:"
        return label
    }()
    
    private let blueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Blue:"
        return label
    }()
    
    private let redValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let greenValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let blueValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let redSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.00
        slider.maximumValue = 1.00
        slider.minimumTrackTintColor = .systemRed
        slider.addTarget(self, action: #selector(redValueChanged), for: .valueChanged)
        return slider
    }()
    
    private let greenSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.00
        slider.maximumValue = 1.00
        slider.minimumTrackTintColor = .systemGreen
        slider.addTarget(self, action: #selector(greenValueChanged), for: .valueChanged)
        return slider
    }()
    
    private let blueSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.00
        slider.maximumValue = 1.00
        slider.minimumTrackTintColor = .systemBlue
        slider.addTarget(self, action: #selector(blueValueChanged), for: .valueChanged)
        return slider
    }()
    
    private let redValueTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let greenValueTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let blueValueTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let toolbar: UIToolbar = {
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let next = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextPressed))
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        
        let toolbar = UIToolbar()
        toolbar.setItems([next, space, done], animated: false)
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = .systemBlue
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }()
    
    //MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        redValueTextField.delegate = self
        greenValueTextField.delegate = self
        blueValueTextField.delegate = self
        
        redValueTextField.inputAccessoryView = toolbar
        greenValueTextField.inputAccessoryView = toolbar
        blueValueTextField.inputAccessoryView = toolbar
        
        navigationItem.setHidesBackButton(true, animated: false)
        view.backgroundColor = #colorLiteral(red: 0.1896009147, green: 0.4289529324, blue: 0.6825695634, alpha: 1)
        checkColorAndValue()
        layout()
    }
    
    //MARK: - Methods
    @objc private func saveColor() {
        view.endEditing(true)
        delegate.changeViewColor(red: redValue, green: greenValue, blue: blueValue)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func donePressed() {
        if redValueTextField.isEditing {
            redValueTextField.resignFirstResponder()
        } else if greenValueTextField.isEditing {
            greenValueTextField.resignFirstResponder()
        } else if blueValueTextField.isEditing {
            blueValueTextField.resignFirstResponder()
        }
    }
    
    @objc private func nextPressed() {
        if redValueTextField.isEditing {
            greenValueTextField.becomeFirstResponder()
        } else if greenValueTextField.isEditing {
            blueValueTextField.becomeFirstResponder()
        } else if blueValueTextField.isEditing {
            redValueTextField.becomeFirstResponder()
        }
    }
    
    @objc private func redValueChanged() {
        redValue = CGFloat((round(redSlider.value * 100) / 100))
        checkColorAndValue()
    }
    
    @objc private func greenValueChanged() {
        greenValue = CGFloat((round(greenSlider.value * 100) / 100))
        checkColorAndValue()
    }
    
    @objc private func blueValueChanged() {
        blueValue = CGFloat((round(blueSlider.value * 100) / 100))
        checkColorAndValue()
    }
    
    private func checkColorAndValue() {
        redSlider.value = Float(redValue)
        greenSlider.value = Float(greenValue)
        blueSlider.value = Float(blueValue)
        
        
        redValueLabel.text = String(round(redValue * 100) / 100)
        greenValueLabel.text = String(round(greenValue * 100) / 100)
        blueValueLabel.text = String(round(blueValue * 100) / 100)
        
        redValueTextField.text = String(round(redSlider.value * 100) / 100)
        greenValueTextField.text = String(round(greenSlider.value * 100) / 100)
        blueValueTextField.text = String(round(blueSlider.value * 100) / 100)
        
        colorView.backgroundColor = UIColor(red: redValue * 255 / 255, green: greenValue * 255 / 255, blue: blueValue * 255 / 255, alpha: 1.0)
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

//MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let number = Float(text) else { return }
        if textField == redValueTextField && number <= 1 {
            redValue = CGFloat(number)
            print(redValue)
            checkColorAndValue()
        } else if textField == greenValueTextField && number <= 1 {
            greenValue = CGFloat(number)
            checkColorAndValue()
        } else if textField == blueValueTextField && number <= 1 {
            blueValue = CGFloat(number)
            checkColorAndValue()
        }
    }
}
