//
//  ViewController.swift
//  simpleApp
//
//  Created by Son Dinh on 9/11/19.
//  Copyright © 2019 Son Dinh. All rights reserved.
//

import UIKit

class HeadlineCeil: UITableViewCell{
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PhotoControllerDelegate {
    
    var transaction = [Transaction]()
    var count = 0
    
    var imageList = [UIImage]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "TransactionCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! HeadlineCeil
        let headline = self.transaction[(indexPath as NSIndexPath).row]
        cell.storeLabel.text = headline.store
        cell.priceLabel.text = headline.total.description
        cell.datetimeLabel.text = headline.dateTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailTransaction") as! DetailTransaction
        detailController.transaction = self.transaction[(indexPath as NSIndexPath).row]
        if (self.imageList.count >= (indexPath as NSIndexPath).row + 1){
            detailController.image = self.imageList[(indexPath as NSIndexPath).row]
        }
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    @IBOutlet weak var transactionView: UITableView!
    @IBOutlet weak var takePhoto: UIBarButtonItem!
    @IBOutlet weak var insightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.transactionView.delegate = self
        self.transactionView.dataSource = self
        if self.count == 0 {
            getFromFile()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    @IBAction func takePhoto(_ sender: Any){
        performSegue(withIdentifier: "photoSegue", sender: self)
    
    }
    
    @IBAction func insightView(_ sender: Any){
        performSegue(withIdentifier: "insightSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoSegue"{
            let photoController = segue.destination as! PhotoController
            photoController.count = self.count % 2
            photoController.delegate = self
//            photoController.parentVC = self
        }
        if segue.identifier == "insightSegue"{
            let _ = segue.destination as! InsightController
        }
    }
    
    func getFromFile(){
        let path: NSString = Bundle.main.path(forResource: "transactions",
                                              ofType: "json")! as NSString
        let data : NSData = try! NSData(contentsOfFile: path as String,
                                        options: NSData.ReadingOptions.dataReadingMapped)
        let user = try! JSONDecoder().decode(Result.self, from: data as Data)
        self.transaction = user.transactions
    }
    
    func PhotoControllerWillDismiss(update: Transaction, image: UIImage){
        self.transaction.insert(update, at: 0)
        self.imageList.insert(image, at: 0)
        self.count += 1
        transactionView.reloadData()
    }
}

