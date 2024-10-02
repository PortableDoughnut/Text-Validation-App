//
//  ViewController.swift
//  Text Validation App Starter
//
//  Created by Jane Madsen on 10/1/24.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var statusMessageLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	var doesContainSpecialCharacter = {
		(string: String) -> Bool in
		let specialCharacters: Set<Character> = [",", ".", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=", "{", "}", "[", "]", "|", ";", ":", "\"", "<", ">", "?"]
		
		for character in specialCharacters {
			if string.contains(character) {
				return true
			}
		}
		return false
	}
	
	var doesContainCaseVariation = {
		(string: String) -> Bool in
		if string != string.lowercased() && string != string.uppercased() {
			return true
		} else {
			return false
		}
	}
	
	var doesContainEmailAdress = {
		(string: String) -> Bool in
		
		let domainExtensions: Set<String> = [".com", ".org", ".net", ".edu", ".gov", ".co.uk", ".co", ".co.jp", ".tv", ".io", ".shop", ".us", ".me"]
		
		if string.contains("@") {
			for extensions in domainExtensions {
				if string.contains(extensions) {
					return true
				}
			}
		}
		return false
	}
	
	@IBAction func validatePassword(_ sender: Any) {
		if doesContainEmailAdress(usernameTextField.text ?? "") {
			if passwordTextField.text?.count ?? 0 >= 8 {
				if doesContainSpecialCharacter(passwordTextField.text ?? "") {
					if doesContainCaseVariation(passwordTextField.text ?? "") {
						statusMessageLabel.text = "Log in successful"
					} else {
						statusMessageLabel.text = "Password must contain one uppercased character and one lowercased character."
					}
				} else {
					statusMessageLabel.text = "Password must contain at least one special character."
				}
			} else {
				statusMessageLabel.text = "Password must be at least 8 characters long."
			}
		} else {
			statusMessageLabel.text = "Please enter a valid email address."
			statusMessageLabel.textColor = .red
			return
		}
		guard passwordTextField.text?.count ?? 0 >= 8 else {
			statusMessageLabel.text = "Password must be at least 8 characters long."
			statusMessageLabel.textColor = .red
			return
		}
		guard doesContainSpecialCharacter(passwordTextField.text ?? "") else {
			statusMessageLabel.text = "Password must contain at least one special character."
			statusMessageLabel.textColor = .red
			return
		}
		guard doesContainCaseVariation(passwordTextField.text ?? "") else {
			statusMessageLabel.text = "Password must contain one uppercased character and one lowercased character."
			statusMessageLabel.textColor = .red
			return
		}
		statusMessageLabel.text = "Log in successful"
		statusMessageLabel.textColor = .green
	}
}
