//
//  HomeTableViewController.swift
//  eCommerce
//
//  Created by Raven-Mac 2 on 15/11/21.
//

import UIKit
import Firebase

class HomeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refresher: UIActivityIndicatorView!
    
    let refreshControl = UIRefreshControl()
    
    // Data model: These strings will be the data for the table view cells
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
//        // Register the table view cell class and its reuse id
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()

        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "HomeTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "HomeTableViewCell")
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        // create a new cell if needed or reuse an old one
//        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
//
//        // set the text from the data model
//        cell.textLabel?.text = self.productArray[indexPath.row].name
//
//        return cell
        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell {
//            return cell
//        }
//
//        return UITableViewCell()
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath) as! GroupTableViewCell
        let product = productArray[indexPath.row]
        cell.bioLabel.text = product.url
        cell.bioLabel.textColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    private var productArray: Array<Product> = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        readCategoryData()
    }
    
    private func readCategoryData() {
        productArray.removeAll()
        let ref: DatabaseReference = Database.database().reference()
        
        ref.child("products/categories").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    if childSnapshot.key == "version" {
                        continue
                    }
                    let dictionary = childSnapshot.value as? [String:Any]
                    let product = Product(dictionary: dictionary!)
                    
                    print(product)
                    
                    self.productArray.append(product)
                }
            }
            
            self.tableView.reloadData()
            self.refresher.isHidden = true
            self.refreshControl.endRefreshing()
//            let name = snapshot.value as? String ?? "Unknown";
//            print(name)
        });
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
//        // Do your job, when done:
//        refreshControl.endRefreshing()
        readCategoryData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
