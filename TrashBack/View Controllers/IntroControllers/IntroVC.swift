//
//  IntroVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 12/01/22.
//

import UIKit

class IntroVC: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var btnSkip: UIButton!
  @IBOutlet weak var btnNext: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var btnBack: UIButton!
    
  // MARK: - Variables
  let arrText = ["Ramasse les déchets\nprès de chez toi", "Jette les déchets\net gagne des points", "Échange tes points\ncontre des cadeaux"]
  let arrSubText = ["Parcours les espaces verts\nà la recherche de détritus", "Prends tes ramassages en photos\npour valider tes points", "Des bons d'achats, des réductions et pleins\nd'autres lots sont disponibles"]
  let arrImg = [#imageLiteral(resourceName: "ic_Intro1"), #imageLiteral(resourceName: "ic_Intro2"), #imageLiteral(resourceName: "ic_Intro3")]
  var isFromSettings = false
  
  // MARK: - View Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
      if isFromSettings {
          btnBack.isHidden = false
      } else {
          btnBack.isHidden = true
      }
    self.navigationController?.navigationBar.isHidden = true
    DispatchQueue.main.async {
      self.btnNext.layer.cornerRadius = self.btnNext.frame.height / 2
    }
  }
  
  // MARK: - Button Action Methods
  
    @IBAction func btnBack_Action(_ sender: UIButton) {
     setVibration()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionBtnSkip(_ sender: UIButton) {
    setVibration()
      if isFromSettings {
          self.dismiss(animated: true, completion: nil)
      } else {
          let vc = StoryBoard.Main.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
          self.navigationController?.pushViewController(vc, animated: true)
      }
        
  }
  
  @IBAction func actionBtnNext(_ sender: UIButton) {
    setVibration()
      if isFromSettings {
          if self.pageControl.currentPage != 2 {
            collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage + 1, section: 0), at: .centeredHorizontally, animated: true)
          } else {
              self.dismiss(animated: true, completion: nil)
          }
      } else {
          if self.pageControl.currentPage != 2 {
            collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage + 1, section: 0), at: .centeredHorizontally, animated: true)
          } else {
                let vc = StoryBoard.Main.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
                self.navigationController?.pushViewController(vc, animated: true)
          }
      }
   
  }
}

// MARK: - Collection View Delegate Methods
extension IntroVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    self.pageControl.currentPage = indexPath.item
//    if indexPath.item == 3 {
//      btnNext.setTitle("Démarrer", for: .normal)
//    } else {
//      btnNext.setTitle("Suivant", for: .normal)
//    }
  }
}

// MARK: - Collection View DataSource Methods
extension IntroVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrImg.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCollectionCell", for: indexPath) as! IntroCollectionCell
        cell.lblTitle.text = arrText[indexPath.item]
        cell.lblSubText.text = arrSubText[indexPath.item]
        cell.imgIntro.image = arrImg[indexPath.item]
    return cell
  }
}

// MARK: - Collection View DelegateFlow Layout Methods
extension IntroVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
}

// MARK: - Collection View Cell Class
class IntroCollectionCell: UICollectionViewCell {
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblSubText: UILabel!
  @IBOutlet weak var imgIntro: UIImageView!
}
