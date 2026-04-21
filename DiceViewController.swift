//
//  DiceViewController.swift
//  Group3FinalProject
//
//  Created by Faesy, Bradley C. on 4/16/26.
//
//	The DiceViewController Will Show Up After The User Has Selected Their Chosen Die.
//	This Will Hold The Selected Die Information, The Roll Button To Generated a Random Number, And Their Roll History

import UIKit

class DiceViewController: UIViewController {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var diceImageView: UIImageView!
	
	var selectedDie: Die!
	weak var delegate: DiceRollerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nameLabel.text = selectedDie.name
		descriptionLabel.text = selectedDie.description
		
		if let last = selectedDie.lastRoll {
			resultLabel.text = "Your Last Roll Was \(last)"
		} else {
			resultLabel.text = "Roll The Dice"
		}
	}
    
    func animateDiceRoll() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: diceImageView.center.x - 8, y: diceImageView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: diceImageView.center.x + 8, y: diceImageView.center.y))
        
        diceImageView.layer.add(animation, forKey: "position")
    }
    
	@IBAction func rollButtonTapped(_ sender: UIButton) {
		var die = selectedDie!
		let result = die.rollDie()
        
        animateDiceRoll()
        
		resultLabel.text = "\(result)"
		diceImageView.image = UIImage(named: selectedDie.imageName)
		delegate?.diceRoller(didRoll: die, result: result)
	}
}
