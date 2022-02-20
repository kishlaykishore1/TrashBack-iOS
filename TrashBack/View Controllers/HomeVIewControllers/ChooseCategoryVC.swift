//
//  ChooseCategoryVC.swift
//  TrashBack
//
//  Created by angrz singh on 25/01/22.
//

import UIKit

class ChooseCategoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblImpNotes: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variables
    var typeOfWasteVC: TypeOfWasteVC?
    var arrImage = [#imageLiteral(resourceName: "masque-de-dentiste"), #imageLiteral(resourceName: "dirty-shirt"), #imageLiteral(resourceName: "sneakers"), #imageLiteral(resourceName: "rope"), #imageLiteral(resourceName: "diaper"), #imageLiteral(resourceName: "sanitary-pad")]
    var arrTitle = ["Masque", "Vêtement", "Chaussure", "Corde", "Couche", "Serviettes/tampons hygiéniques"]
    var arrSubTitle = ["Met en moy. 400 ans à se dégrader", "Met en moy. 2 ans à se dégrader", "Met en moy. 30 ans à se dégrader", "Met en moy. 10 ans à se dégrader", "Met en moy. 450 ans à se dégrader", "Met en moy. 450 ans à se dégrader"]
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Annuler"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    // MARK: - Helper Methods
    
    func setup() {
        lblImpNotes.numberOfLines = 0
        lblImpNotes.textColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        let clickableTextTerms = NSMutableAttributedString(string: "Important ! ".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1), NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: lblImpNotes.font.pointSize) ?? UIFont.systemFont(ofSize: lblImpNotes.font.pointSize, weight: .medium)])
        let clickableTextPolicy = NSMutableAttributedString(string: "Notre équipe de modération pourra vérifier si la description est bien en accord avec le déchet pris en photo. En cas de mauvaise catégorisation répétées, ton compte pourra être suspendu et tes points seront réinitialisés.".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1),NSAttributedString.Key.font: UIFont(name: "DMSans-Regular", size: lblImpNotes.font.pointSize) ?? UIFont.systemFont(ofSize: lblImpNotes.font.pointSize, weight: .regular)])
        let finalString = NSMutableAttributedString()
        finalString.append(clickableTextTerms)
        finalString.append(clickableTextPolicy)
        lblImpNotes.attributedText = finalString
    }
    
    // MARK: - Button Action Methods
    
    @IBAction func action_otherTap(_ sender: UIControl) {
        setVibration()
        self.dismiss(animated: true) {
            self.typeOfWasteVC?.txtCategory.text = "Autre"
        }
    }
    
    @IBAction func action_backButton(_ sender: UIButton) {
        setVibration()
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - TableView DataSource
extension ChooseCategoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseCategoryTableCell") as! ChooseCategoryTableCell
        cell.lblTitle.text = arrTitle[indexPath.row]
        cell.lblSubTitle.text = arrSubTitle[indexPath.row]
        cell.imgView.image = arrImage[indexPath.row]
        return cell
    }
    
}

//MARK: - TableView Delegate
extension ChooseCategoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setVibration()
        self.dismiss(animated: true) {
            self.typeOfWasteVC?.txtCategory.text = self.arrTitle[indexPath.row]
        }
    }
}

// MARK: - SearchBar Delegate
extension ChooseCategoryVC: UISearchBarDelegate {
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.showsCancelButton = true
    return true
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    self.searchBar.endEditing(true)
    searchBar.resignFirstResponder()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.resignFirstResponder()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.searchBar.text = ""
    self.searchBar.endEditing(true)
    searchBar.showsCancelButton = false
    searchBar.resignFirstResponder()
  }
}
