//
//  DetailTransaction.swift
//  simpleApp
//
//  Created by Son Dinh on 9/14/19.
//  Copyright © 2019 Son Dinh. All rights reserved.
//

import UIKit

class DetailTransaction: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var Back: UIBarButtonItem!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var receiptImage: UIImageView!
    
    
    var transaction : Transaction!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateTimeLabel.text = transaction.dateTime
        self.totalLabel.text = transaction.total.description
        // Do any additional setup after loading the view.
        self.navigationItem.title = transaction.store
        
        if let image = self.image {
            self.receiptImage.image = image
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell")!
        let itemPriceArr = dictToArray(self.transaction.items)
        let items = itemPriceArr[(indexPath as NSIndexPath).row]
        let (item, price) = items.first!
        cell.textLabel?.text = item
        cell.detailTextLabel?.text = price.description
        return cell
    }
    
    func dictToArray(_ dictionary: [String: Float]) ->[[String: Float]]{
        var itemPriceArr = [[String: Float]]()
        for (item, price) in dictionary{
            itemPriceArr.append([item: price])
        }
        return itemPriceArr
    }
    
    @IBAction func backToParent(_ sender: Any){
        let _ = navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
