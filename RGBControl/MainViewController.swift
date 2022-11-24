//
//  MainViewController.swift
//  RGBControl
//
//  Created by Vladimir Khalin on 24.11.2022.
//

import UIKit

final class MainViewController: UIViewController, SettingsVCDelegate {
    
    @IBOutlet var BackgroundVC: UIView!
    
    var currentColor: UIColor!
    var settingsViewController: SettingsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentColor = BackgroundVC.backgroundColor
    }
    
    func setColor(color: UIColor) {
        self.BackgroundVC.backgroundColor = color
        currentColor = BackgroundVC.backgroundColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.RGBsettings = currentColor
        
        self.settingsViewController = settingsVC
        self.settingsViewController.delegate = self
    }
}



