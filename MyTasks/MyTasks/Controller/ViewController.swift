//
//  ViewController.swift
//  MyTasks
//
//  Created by Дарья on 14.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    
    private var userName = Persistance.shared.userName
    private var surname = Persistance.shared.surname
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = "Hi! Your name is \(userName ?? "...") \(surname ?? "")"
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if nameTF.text == nil, surnameTF.text == nil {return}
        
        Persistance.shared.userName = nameTF.text
        Persistance.shared.surname = surnameTF.text
        
        helloLabel.text = "Hi! Your name is \(nameTF.text ?? "...") \(surnameTF.text ?? "")"
    }
    
}

