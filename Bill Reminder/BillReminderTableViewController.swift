//
//  BillReminderTableViewController.swift
//  Bill Reminder
//
//  Created by Damien Byrd on 6/1/21.
//

import UIKit

class BillReminderTableViewController: UITableViewController {
    
    var allBills = [Bill]()

    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let archiveURL = documentsDirectory.appendingPathComponent("Contacts_test").appendingPathExtension("plist")
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedContactsData = try? Data(contentsOf: archiveURL),
           let decodedContacts = try? propertyListDecoder.decode([Bill].self, from: retrievedContactsData) {
            print(decodedContacts)
            allBills = decodedContacts
            
        }
    }

    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? AddNewBillViewController {
            if let bill = sourceViewController.bill {
                if let indexPath = tableView.indexPathForSelectedRow {
                    allBills[indexPath.row] = bill
                    tableView.reloadData()
                    
                } else {
                    allBills.append(bill)
                    tableView.reloadData()
                    
                }
                let archiveURL = documentsDirectory.appendingPathComponent("Contacts_test").appendingPathExtension("plist")
                
                let propertyListEncoder = PropertyListEncoder()
                let encodedBills = try? propertyListEncoder.encode(bill)
                try? encodedBills?.write(to: archiveURL, options: .noFileProtection)
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBills.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillTableViewCell") as! BillTableViewCell
        let bill = allBills[indexPath.row]
        
        cell.amountLabel.text = bill.amount
        cell.nameLabel.text = bill.category

        return cell
    }

    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath) ->
    UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           allBills.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: . automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "editBillSegue" {
//            let addNewBillController = segue.destination as? AddNewBillViewController
//
//            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
//                return
//            }
//            let bill = allBills [indexPath.row]
//            addNewBillController?.bill = bill
//        }
    }
}











/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 
 */
