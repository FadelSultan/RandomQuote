//
//  FavoriteQuotesVC.swift
//  RandomQuote
//
//  Created by fadel sultan on 6/26/20.
//  Copyright © 2020 fadel sultan. All rights reserved.
//

import UIKit

class FavoriteQuotesVC: UIViewController {

    var arrQuotes:[RandomQuoteVC.model]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension FavoriteQuotesVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQuotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteQuotesCell", for: indexPath) as? FavoriteQuotesCell else {
            return UITableViewCell()
        }
        if let quote = arrQuotes?[indexPath.row] {
            cell.set(quote: quote)
        }
        return cell
    }
    
}

// Set same file swift for super class or set new file :)
class FavoriteQuotesCell : UITableViewCell {
    
//    outlet
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelQuote: UILabel!
    
    func set(quote q:RandomQuoteVC.model) {
        labelAuthor.text = q.author
        labelQuote.text = q.en
    }
}
