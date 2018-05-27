//
//  SettingsViewController.swift
//  CSGOSpectator
//
//  Created by student on 28/03/2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import CSGOSpectatorKit

class SettingsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var underscoreView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        confirmButton.setImage(#imageLiteral(resourceName: "send_active"), for: .normal)
        confirmButton.setImage(#imageLiteral(resourceName: "send_not"), for: .disabled)
        textField.tintColor = UIColor.lightGreen
        guard let text = textField.text else { return }
        confirmButton.isEnabled = !text.isEmpty
        textField.addTarget(self, action: #selector(updateButton(textField:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @IBAction func confirmPressed() {
        print("Confirm pressed")
    }
    
}

// MARK: Text Field methods
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        emailLabel.textColor = UIColor.lightGreen
        underscoreView.backgroundColor = UIColor.lightGreen
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        emailLabel.textColor = UIColor.gray
        underscoreView.backgroundColor = UIColor.gray
        return true
    }
    
    @objc func updateButton(textField: UITextField) {
        guard let text = textField.text else { return }
        confirmButton.isEnabled = text.isEmail
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
}
