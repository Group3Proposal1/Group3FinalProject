//
//  DiceViewController.swift
//  Group3FinalProject
//
//  Created by Faesy, Bradley C. on 4/16/26.
//
//	The DiceViewController Will Show Up After The User Has Selected Their Chosen Die.
//	This Will Hold The Selected Die Information, The Roll Button To Generated a Random Number, And Their Roll History

import UIKit
import AudioToolbox

class DiceViewController: UIViewController {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var modifierLabel: UILabel!
    @IBOutlet weak var modifierTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var diceImageView: UIImageView!
	
	var selectedDie: Die!
	weak var delegate: DiceRollerDelegate?
	var soundId: SystemSoundID = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        nameLabel.layer.cornerRadius = 10
        nameLabel.layer.masksToBounds = true
        
        descriptionText.layer.cornerRadius = 10
        descriptionText.layer.masksToBounds = true
        
        modifierLabel.layer.cornerRadius = 10
        modifierLabel.layer.masksToBounds = true
        
        modifierTextField.layer.cornerRadius = 10
        modifierTextField.layer.masksToBounds = true
        
        resultLabel.layer.cornerRadius = 10
        resultLabel.layer.masksToBounds = true


		
		nameLabel.text = selectedDie.name
		descriptionText.text = selectedDie.description
		
		if let last = selectedDie.lastRoll {
			resultLabel.text = "Your Last Roll Was \(last)"
		} else {
			resultLabel.text = "Roll The Dice"
		}
		
		if let soundURL = Bundle.main.url(forResource: "roll", withExtension: "wav"){
			AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundId)
		}
	}
    
    //animation function
    func animateDiceRoll() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: diceImageView.center.x - 8, y: diceImageView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: diceImageView.center.x - 8, y: diceImageView.center.y))
        diceImageView.layer.add(animation, forKey: "position")
    }
	
	@IBAction func rollButtonTapped(_ sender: UIButton) {
        //checks if input is valid if not then default to 0
        let modifier = Int(modifierTextField.text ?? "") ?? 0
		var die = selectedDie!
        let result = die.rollDie(with: modifier)
        
		AudioServicesPlaySystemSound(soundId)
        animateDiceRoll() //trigger animation
        
		resultLabel.text = "\(result)"
		diceImageView.image = UIImage(named: selectedDie.imageName)
		delegate?.diceRoller(didRoll: die, result: result)
	}
}
