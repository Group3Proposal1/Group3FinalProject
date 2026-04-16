//
//  ViewController.swift
//  Group3FinalProject
//
//  Created by Faesy, Bradley C. on 4/16/26.
//
//	This View Controller Is The Inital View Controller, The First Screen The User Will See.
//	It Should Display All 6 Of The Different Die Types In DND. The D4, D6, D8, D10, D12, And D20.
//	Choosing One Of These Will Bring You To It's Own View Controller Or The DiceRoleViewController For That Die.

import UIKit

class DiceSelectionViewController: UIViewController {
	
	@IBOutlet weak var tableViewController: UITableView!
	//Button When Clicked Will Explain What The App Offers
	@IBAction func infoButtonTapped(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "How To Play", message: "Tap Any Die You Wish To Use To Open The Roll Screen. Press The Button To Get Your Random Dice Roll. Your Latest Roll For The Chosen Dice Will Be Shown", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default))
		present(alert, animated: true)
	}
	
	var dice: [Die] = AllDice.all
	//Dictionary for Roll History For The Most Recent Roll For Each Die
	var rollHistory: [String: Int] = [:]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableViewController.dataSource = self
		tableViewController.delegate = self
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//Re Load Roll History So It Shows Latest Roll
		//tableView.reloadData()
	}
}

//Table View Data Source
extension DiceSelectionViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int { return 1	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return dice.count	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiceTableViewCell", for: indexPath) as? DiceTableViewCell else {
			return UITableViewCell()
		}
		let die = dice[indexPath.row]
		cell.nameLabel.text = die.name
		cell.descriptionLabel.text = "\(dice.count) Sided Die"
		
		if let last = rollHistory[die.name] {
			cell.lastRollLabel.text = "Last Roll Is \(last)"
		} else {
			cell.lastRollLabel.text = "No Rolls Yet"
		}
		return cell
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "DND Dice"
	}
}

//Table View Delegate
extension DiceSelectionViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedDie = dice[indexPath.row]
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "DiceViewController") as! DiceViewController
		vc.selectedDie = selectedDie
		vc.delegate = self
		navigationController?.pushViewController(vc, animated: true)
	}
}

// Calls It's Methods To Update Roll History
extension DiceSelectionViewController: DiceRollerDelegate {
	func diceRoller(didRoll die: Die , result: Int) {
		rollHistory[die.name] = result
	}
}
