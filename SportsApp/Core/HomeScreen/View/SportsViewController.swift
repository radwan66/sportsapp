//
//  SportsViewController.swift
//  SportsApp
//
//  Created by radwan on 02/02/20224.
//

import UIKit

class SportsViewController: UIViewController, UINavigationControllerDelegate {
    var twoCellsLAyout = false
    @IBOutlet weak var SportsCollectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        SportsCollectionView.delegate = self
        SportsCollectionView.dataSource = self
        
        
        
        /// naviagtion Bar congig
        let addButton = UIBarButtonItem(image:UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(LayoutClicked(_:)))
        addButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.topItem?.title = "Sports"
        
        //config the collectionView Custom Cell
        SportsCollectionView.register(UINib(nibName: "SportsCell", bundle: nil), forCellWithReuseIdentifier: "SportsCell")
        
       
    }
    
   //sort function
     @IBAction func LayoutClicked(_ sender: Any) {
       
         if twoCellsLAyout{
             let addButton = UIBarButtonItem(image:UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(LayoutClicked(_:)))
             addButton.tintColor = UIColor.black
             navigationItem.rightBarButtonItem = addButton
             
            
             twoCellsLAyout = false
         }
         else {
             let addButton = UIBarButtonItem(image:UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(LayoutClicked(_:)))
             addButton.tintColor = UIColor.black
             navigationItem.rightBarButtonItem = addButton
             twoCellsLAyout = true
         }
    
        SportsCollectionView.reloadData()
    }
    
}






extension SportsViewController :UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  SportsCollectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCell
        cell.backgroundColor = .black
         cell.CellImage.contentMode = .scaleAspectFill
         cell.CellImage.clipsToBounds = true
        switch indexPath.row{
        case 0 :
            cell.CellLabel.text  = SportsCategory.Football.rawValue
              cell.CellImage.image =  UIImage(named: SportsCategory.Football.Image )
            
            
        case 1 :
            cell.CellLabel.text  = SportsCategory.BasketBall.rawValue
            cell.CellImage.image =  UIImage(named: SportsCategory.BasketBall.Image )
        case 2 :
            cell.CellLabel.text  = SportsCategory.Cricket.rawValue
            cell.CellImage.image =  UIImage(named: SportsCategory.Cricket.Image )
        default:
            cell.CellLabel.text  = SportsCategory.Tennis.rawValue
            cell.CellImage.image =  UIImage(named: SportsCategory.Tennis.Image )
        }
        
        
      
  
      
       
        
        
        return cell
    }
    
    
    
    // item clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   //     let vc = AllLeagues(viewModel: LeagesViewModel(sport: "football"))


      //  let viewModel:LeagesViewModel?

        if let allLeaguesVc = storyboard?.instantiateViewController(withIdentifier: "AllLeagues") as? AllLeagues {
            
            //SportsCategory.allCases[indexPath.item].rawValue.lowercased()
           // allLeaguesVc.viewModel.url = SportsCategory
            switch indexPath.item {
            case 0:  allLeaguesVc.viewModel =  LeagesViewModel(url: SportsCategory.Football.Url , sport: "football")
            case 1:  allLeaguesVc.viewModel = LeagesViewModel(url:SportsCategory.BasketBall.Url , sport: "basketball")
            case 2:  allLeaguesVc.viewModel = LeagesViewModel(url: SportsCategory.Cricket.Url , sport: "cricket")
            default: allLeaguesVc.viewModel = LeagesViewModel(url: SportsCategory.Tennis.Url , sport: "tennis")
              
            }
         
            self.navigationController?.pushViewController(allLeaguesVc, animated: true)
        } else {
            print("Failed to instantiate 'AllLeagues' view controller")
        }
        
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        CellMargins()
        
        if twoCellsLAyout{
            let noOfCellsInRow = 2  //number of column you want
               let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
               let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
                   + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

               let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size, height: size)
        }
        else{
            let noOfCellsInRow = 1  //number of column you want
               let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
               let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
                   + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

               let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            return CGSize(width: size, height: Int(Double(size)/2.8))
        }
            
        
        
    }
    
    
    func CellMargins(){
        
        let margin: CGFloat = 25
        guard let flowLayout = SportsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        flowLayout.minimumInteritemSpacing = margin
            flowLayout.minimumLineSpacing = margin
            flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
 
    
    
}
