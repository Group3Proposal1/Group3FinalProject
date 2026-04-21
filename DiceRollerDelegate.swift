//
//  DiceRollerDelegate.swift
//  Group3FinalProject
//
//  Created by Faesy, Bradley C. on 4/16/26.
//

import UIKit

// Protocol Called Everytime User Rolls Die And When User Leaves Without Rolling
protocol DiceRollerDelegate: AnyObject {
	func diceRoller (didRoll die: Die, result: Int)
	func diceRollerCancel()
}

extension DiceRollerDelegate {
	func diceRollerCancel() {}
}
