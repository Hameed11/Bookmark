//
//  NotesViewController.swift
//  Bookmark
//
//  Created by Hameed Abdullah on 6/28/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        
        cell.textLabel?.text = "This is a column"
        
        return cell
        
    }

}
