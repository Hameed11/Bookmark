//
//  LinksViewController.swift
//  Bookmark
//
//  Created by Hameed Abdullah on 6/28/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class LinksViewController: UIViewController, UITableViewDataSource {
    
    
    var links: [Link] = [Link]()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCoreDataObj()
        tableView.reloadData()
    }
    
    func fetchCoreDataObj() {
        fetch { (complete) in
            if complete {
                //if fetch completed show  result on tableview if not dont show tableview cuz it is hidden from default
                
                if links.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
                
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! LinksTableViewCell
        
        let link = links[indexPath.row]
        cell.confCell(link: link)
        
        return cell
    }

}



extension LinksViewController {
    
    func fetch(completion: (_ completion: Bool) -> ()) {
        
        //get the managed object context first
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        //create fetch request
        let fetchReq = NSFetchRequest<Link>(entityName: "Link")
        
        do {
            links = try managedContext.fetch(fetchReq)
            print("successfully fetched data")
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    
    
    //REMOVE Object
    
    
    
}






















