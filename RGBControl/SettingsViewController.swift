//
//  ViewController.swift
//  RGBControl
//
//  Created by Vladimir Khalin on 10.11.2022.
//

import UIKit

protocol SettingsVCDelegate {
    func setColor(color: UIColor)
}

final class SettingsViewController: UIViewController {
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var colorPalitraView: UIView!
    
    var RGBsettings: UIColor!
    var delegate: SettingsVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPalitraView.layer.cornerRadius = 20
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        let colorsPosition = UIColorSeparated(color: RGBsettings)
        
        // Выставляем слайдеры в цвета первого экрана
        redSlider.value = Float(colorsPosition[0])
        greenSlider.value = Float(colorsPosition[1])
        blueSlider.value = Float(colorsPosition[2])
        
        // В label показываем значения положениея слайдереров
        transferValueSliderToLable()
        
        // Присваиваем textField значениям label
        transferValueLableTotextFild()
        
        // Красим политру в цвет первого экрана
        self.colorPalitraView.backgroundColor = RGBsettings
        
        addToolBar()
    }
    @objc func tapDone() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func sliderActions(_ sender: UISlider) {
        transferValueSliderToLable()
        transferValueLableTotextFild()
        self.colorPalitraView.backgroundColor = makeUIColor()
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        RGBsettings = colorPalitraView.backgroundColor
        delegate?.setColor(color: RGBsettings)
        dismiss(animated: true)
    }
    
    private func addToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(tapDone))
        toolBar.items = [flex, barButton]
        redTextField.inputAccessoryView = toolBar
        greenTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
    }
    
    private func makeUIColor() -> UIColor {
        UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0)
    }
    
    private func transferValueLableTotextFild() {
        redTextField.text = redLabel.text
        greenTextField.text = greenLabel.text
        blueTextField.text = blueLabel.text
    }
    
    private func transferValueSliderToLable() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func UIColorSeparated(color: UIColor) -> [CGFloat] {
        guard let RGBcomponent = color.cgColor.components else { return [] }
        return RGBcomponent
    }
}

// :MARK - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let result = textField.text else { return }
        
        switch textField.tag {
        case 0: redSlider.value = Float(result) ?? 0.0
        case 1: greenSlider.value = Float(result) ?? 0.0
        default: blueSlider.value = Float(result) ?? 0.0
        }
        let newUIColor = makeUIColor()
        colorPalitraView.backgroundColor = newUIColor
    }
}

