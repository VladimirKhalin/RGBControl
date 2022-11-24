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
    
    @IBOutlet var textFieldsRGBControl: [UITextField]!
    
    @IBOutlet var colorPalitraView: UIView!
    
    var RGBsettings: UIColor!
    var delegate: SettingsVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPalitraView.layer.cornerRadius = 20
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        textFieldsRGBControl[0].delegate = self
        textFieldsRGBControl[1].delegate = self
        textFieldsRGBControl[2].delegate = self
        
        let colorsPosition = UIColorSeparated(color: RGBsettings)
        
        // Выставляем слайдеры в цвета первого экрана
        redSlider.value = Float(colorsPosition[0])
        greenSlider.value = Float(colorsPosition[1])
        blueSlider.value = Float(colorsPosition[2])
        
        // В label показываем значения положениея слайдереров
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        
        // Присваиваем textField значениям label
        for textField in textFieldsRGBControl {
            switch textField.tag {
            case 0: textField.text = redLabel.text
            case 1: textField.text = greenLabel.text
            default: textField.text = blueLabel.text
            }
        }
        // Красим политру в цвет первого экрана
        self.colorPalitraView.backgroundColor = RGBsettings
    }
    
    @IBAction func sliderActions(_ sender: UISlider) {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        
        for textField in textFieldsRGBControl {
            switch textField.tag {
            case 0: textField.text = redLabel.text
            case 1: textField.text = greenLabel.text
            default: textField.text = blueLabel.text
            }
        }
        
        self.colorPalitraView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0)
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        RGBsettings = colorPalitraView.backgroundColor
        delegate?.setColor(color: RGBsettings)
        dismiss(animated: true)
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
        
        let newUIColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        colorPalitraView.backgroundColor = newUIColor
    }
}
