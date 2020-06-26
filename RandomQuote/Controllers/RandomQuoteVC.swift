//
//  ViewController.swift
//  RandomQuote
//
//  Created by fadel sultan on 6/26/20.
//  Copyright © 2020 fadel sultan. All rights reserved.
//

import UIKit
import KeychainSwift

class RandomQuoteVC: UIViewController {
    
    //    outlets
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelQuote: UILabel!
    @IBOutlet weak var outletBtnAddTofavorite: UIButton!
    
//    variables
    let keychain = KeychainSwift()
    var quote:RandomQuoteVC.model?
    var arrQuots = [RandomQuoteVC.model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyChainToLabel()
        fetchRandomQuote()
    }
    
    //    Actions
    @IBAction func btnFetchNewRandom(_ sender: Any) {
        fetchRandomQuote()
    }
    
    @IBAction func btnAddToFavorite(_ sender: Any) {
        guard let quote = self.quote else {
            alert(warningMsg: "Can't add this quote becose some data is empty!")
            return
        }
        
        // Check data
        if (arrQuots.first(where: {$0.id == quote.id}) != nil) {
            alert(warningMsg: "The quote is in the array. The same quote cannot be repeated")
            return
        }
        
        arrQuots.append(quote)
        self.isAddToFavorite(true)
    }
    
    @IBAction func btnNavigatoToFavorite(_ sender: Any) {
        
        if arrQuots.count == 0 {
            alert(warningMsg: "Favorites is empty!")
            return
        }
        
        // I use navigation here to display title for FavoriteQuotesVC
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteQuotesVC") as! FavoriteQuotesVC
        vc.arrQuotes = self.arrQuots
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchRandomQuote() {
        FSProgress.start(add: view)
        model.get { (result, error) in
            FSProgress.hide()
            if let error = error  {
                //set alert to Refreh request
                self.alert(errorMsg: error.localizedDescription)
                return
            }
            
            guard let author = result?.author , let quote = result?.en else {
                self.alert(errorMsg: "Can't display \n Author or Quote is Empty!")
                return
            }
            
            //Set data to variable if user want to add to his favorite
            self.quote = result
            self.keychain.set(author, forKey: "author")
            self.keychain.set(quote, forKey: "quote")
            self.isAddToFavorite(false)
            self.labelAuthor.text = author
            self.labelQuote.text =  quote
        }
    }
    
    private func alert(errorMsg:String) {
        let alert = UIAlertController(title: "Oops!", message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fetch new random", style: UIAlertAction.Style.default, handler: { (_) in
            self.fetchRandomQuote()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func alert(warningMsg:String) {
        let alert = UIAlertController(title: "Oops!", message: warningMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func isAddToFavorite(_ yes:Bool) {
        outletBtnAddTofavorite.isEnabled = !yes
        outletBtnAddTofavorite.setTitle(yes == true ? "Added To Favorite 💛" : "Add To Favorite" , for: UIControl.State.normal)
    }
    
    private func setKeyChainToLabel() {
        labelAuthor.text = keychain.get("author")
        labelQuote.text = keychain.get("quote")
    }
}

