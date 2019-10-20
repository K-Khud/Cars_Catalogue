//
//  EditDetailsTableViewController.swift
//  CarsCatalogue
//
//  Created by Ekaterina Koreneva on 15/10/2019.
//  Copyright © 2019 Ekaterina. All rights reserved.
//

import UIKit

@IBDesignable class EditDetailsTableViewController: UITableViewController {

    var propertyForEdit = Int() {
        didSet {
            print("propertyForEdit =  \(propertyForEdit)")
        }
    }
    
    private let year = YearOfManufacture()
    
    var detail: String = "" {
        didSet {
            if propertyForEdit == 0 {
                if !year.rangeForYear.contains(Int(detail) ?? 0) {
                    detail = "Неверный формат данных"
            } else if detail == "" {
                detail = "Нет данных"
                }
            } else if !detail.contains(" ") {
                    detail = detail.capitalized
                }
            print("Detail changed to \(detail)")
        }
    }
    
    @IBOutlet weak var editTextField: UITextField! {
        didSet {
            print("Detail changed to \(String(describing: editTextField.text))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editTextField.text = detail
        editTextField.allowsEditingTextAttributes = true
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
               editTextField.becomeFirstResponder()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue" {
            detail = editTextField.text ?? ""
        }
    }
}
