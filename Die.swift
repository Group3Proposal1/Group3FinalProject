//
//  Die.swift
//  Group3FinalProject
//
//  Created by Faesy, Bradley C. on 4/16/26.
//
//	This Is Where The Dice Will Be Defined

import UIKit

// Error Handling Using If Statements To Check If There Is Anything Wrong With The Input Or Output
// If There Is, Output To Result
// Most Likely Wont Be Used

//
struct Die {
	var lastRoll: Int?
	
	let sides: Int		// 4, 6, 8, 10, 12, 20
	let name: String 	// "d20"
	let description: String
	let imageName: String
	
	init(sides: Int, name: String, description: String, imageName: String) {
		self.sides = sides
		self.name = name
		self.description = description
		self.imageName = imageName
	}
	
	mutating func rollDie() -> Int {
		let result = Int.random(in: 1...sides)
		lastRoll = result
		return result
	}
}

struct AllDice {
	static let all: [Die] = [Die(sides: 4, name: "d4", description: "4 Sided Die, Used To Calculate Damage From Smaller Weapons Or Minor Healing Spells", imageName: "d4"), Die(sides: 6, name: "d6", description: "6 Sided Die, Used For Determaining Character Abilities And Calculating Damage For Most Weapons And Spells", imageName: "d6"), Die(sides: 8, name: "d8", description: "8 Sided Die, Used To Calculate Damage For Moderate Weapons And To Determain HP For Certain Classes", imageName: "d8"), Die(sides: 10, name: "d10", description: "10 Sided Die, Used To Calculate Damage For Heavier Weapons And HP For Certain Classes", imageName: "d10"),Die(sides: 12, name: "d12", description: "12 Sided Die, Used To Calculate Damage For Heavier Weapons Than The d12 And The HP For A Barbarian", imageName: "d12"), Die(sides: 20, name: "d20", description: "20 Sided Die, Used To Determain Success Or Failure Of Almost All Actions", imageName: "d20")]
}
