//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by radwan on 02/02/20224.
//

import UIKit
import CoreData
//import SystemConfiguration
import Alamofire

class FavoriteViewController : UIViewController, UITableViewDelegate , UITableViewDataSource {
    var leagues: [Leaguess] = []
    
    @IBOutlet weak var FavoriteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteTableView.delegate = self
        FavoriteTableView.dataSource = self
        
        FavoriteTableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        self.navigationItem.setHidesBackButton(true, animated: true)
        fetchData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    
    //MARK- TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteCell
        let league = leagues[indexPath.row]
        
        cell.FavoriteLabel.text = league.league_name
        cell.FavoriteImage.image = UIImage(data: league.league_logo!)
        cell.favoriteButton.isHidden = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the league from Core Data
            let alertController = UIAlertController(title: "Delete", message: "Are You sure You want Delte this leage?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { alert in
                let leagueToDelete = self.leagues[indexPath.row]
                CoreDataManger.sharedCoreManger.deleteLeagueFromCoreData(league: leagueToDelete)
                // Remove the league from the data source
                self.leagues.remove(at: indexPath.row)
                
                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            let CancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            
            
            
            alertController.addAction(okAction)
            alertController.addAction(CancelAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let LeageDetailVc =  storyboard?.instantiateViewController(withIdentifier: "LeaguesCollectionViewController") as? LeaguesCollectionViewController{
            
            if isOnline(){
                LeageDetailVc.viewModel = LeagesDetailsViewModel(id: Int(leagues[indexPath.item].league_key) , sport: leagues[indexPath.item].league_sportName ?? "",LeageName: leagues[indexPath.item].league_name!,image: "")
                self.navigationController?.pushViewController(LeageDetailVc, animated: true)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: "No internet Connection Please turn in wifi or Data", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
            
            
        }
        else{
            print("Failed to instantiate 'AllLeagues' view controller")
        }
        
    }
    
    
    func fetchData(){
        let result = CoreDataManger.sharedCoreManger.fetchData()
        if(result.error != nil){
            let alertController = UIAlertController(title: "Fething Erorr", message: result.error?.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        else{
            guard let leages = result.Leagues else {return}
            self.leagues = leages
            self.FavoriteTableView.reloadData()
        }
        
        
    }
    
    
    
    func isOnline() -> Bool {
        
       
        
        return NetworkReachabilityManager()!.isReachable
        
    }
    
    
}
