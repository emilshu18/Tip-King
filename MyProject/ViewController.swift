//
//  ViewController.swift
//  MyProject
//
//  Created by Emil Shukurov on 29/06/2021.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var buttom: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var peopleNum: UILabel!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tip = 10.0
    var num1 = 2.0
    var moneyAmount = 0.0
    var billTotal = 0.0
    var finalBill = ""
    var history = [Data]()
    
    @IBAction func segmentedTip(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tip = 10.0
        } else if sender.selectedSegmentIndex == 1 {
            tip = 15.0
        } else if sender.selectedSegmentIndex == 2 {
            tip = 20.0
        }
        billTextField.endEditing(true)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "result_vc") as! ResultViewController
        let bill2 = billTextField.text!
        if bill2 != "" {
            billTotal = Double(bill2)!
            moneyAmount = billTotal + (billTotal * tip / 100.0)
            finalBill =  String(Int(ceil((moneyAmount / num1))))
            vc.results = finalBill
            self.createItem(name: "Bill: \(bill2) Tip: \(Int(tip))% People: \(Int(num1)) Each Pays: \(finalBill)")
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func StepperCount(_ sender: UIStepper) {
        num1 = sender.value
        peopleNum.text = String(Int(num1))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buttom.layer.cornerRadius = 10.0
        stepper.layer.cornerRadius = 10.0
        tableView.delegate = self
        tableView.dataSource = self
        getAllItems()
        
    }
    func getAllItems() {
        do {
            history = try context.fetch(Data.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            //error
        }
    }
    func createItem(name: String) {
        let newItem = Data(context: context)
        newItem.name = name
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
    func updateItem(item: Data, newName: String) {
        item.name = newName
        do {
            try context.save()
        }catch{
            
        }
    }
    func deleteItem(item: Data) {
        context.delete(item)
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = history[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item =  history[indexPath.row]
        self.deleteItem(item: item)
    }
    
}
