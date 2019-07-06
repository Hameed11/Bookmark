//
//  LinksViewController.swift
//  Bookmark
//
//  Created by Hameed Abdullah on 6/28/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit
import CoreData
import SafariServices

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class LinksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
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
    
    //MARK:_  delete object
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // return .none cuz we are going to set our custom func to delete
        return UITableViewCell.EditingStyle.delete
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rawAction, indexpath) in
            //delete
            self.removeLink(atIndexPath: indexPath)
            
            //fetch after delete
            self.fetchCoreDataObj()
            
            //this going to remove certain row that we have  deleted
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return [deleteAction]
    }
    
    
   
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let link = links[indexPath.row]
        
        if let encoded = link.url?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {

            guard let url = URL(string: encoded) else { return}
            let safari = SFSafariViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
//
//        guard let u = link.url else { return }
//
//        guard let url: URL = URL(string: u) else {
//            fatalError("could not create URL");
//
//        }
//
//        let safariViewController: SFSafariViewController = SFSafariViewController(url: url);
//        present(safariViewController, animated: true)
    }
    
    
//    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        let link = links.remove(at: fromIndexPath.row)
//        links.insert(link, at: to.row)
//        tableView.reloadData()
//    }
    
    

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
    //remove a link at certine indexPath, indexPath: an enternal parameter of type indexPath use it to remove an object
    func removeLink(atIndexPath indexPath: IndexPath) {
        
        //1 reference to managedContext
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
           //2 call managedContext.delete, we need to get a certine NSManagedObject links[indexPath.row]
        manageContext.delete(links[indexPath.row])
        
         //3 tell the managedObject to update itself
        do {
            try manageContext.save()
        } catch {
            debugPrint("coudn't remove: \(error.localizedDescription)")
        }
    }
    
    
}






















