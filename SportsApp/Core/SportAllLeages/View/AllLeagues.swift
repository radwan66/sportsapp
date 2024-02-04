//
//  AllLeagues.swift
//  SportsApp
//
//  Created by radwan on 01/02/20224.
//
//


protocol cellReload{
    
}

import UIKit
import Kingfisher


class AllLeagues: UIViewController , UITableViewDelegate , UITableViewDataSource {
    var LeagesResult : [Leagues]?
    @IBOutlet weak var LeaguesTable: UITableView!
    
    var viewModel: LeagesViewModel!
    
    
   convenience init(viewModel: LeagesViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LeagesResult = [Leagues]()
        viewModel.fetch { [weak self] leages in
                self?.LeagesResult = leages
                self?.LeaguesTable.reloadData()
            
                    
        }
        
       
    
       
        LeaguesTable.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        let Back = UIBarButtonItem( image: UIImage(systemName: "arrowshape.turn.up.backward.circle"), style: .plain, target: self, action: #selector((Back)))
        Back.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = Back
    

        // Do any additional setup after loading the view.
    }
    
     @IBAction func Back(){
        self.navigationController?.popViewController(animated:true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LeaguesTable.reloadData()
    }
    
}


extension AllLeagues {
    
    //MARK- TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.LeagesResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LeaguesTable.dequeueReusableCell(withIdentifier: "FavoriteCell",for: indexPath) as! FavoriteCell
        
        cell.FavoriteLabel.text = self.LeagesResult?[indexPath.row].league_name
    
        
        let result1 =  CoreDataManger.sharedCoreManger.checkIfExixst(leageName:LeagesResult![indexPath.row].league_name!)
        if result1!{
     
            cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.favoriteButton.tintColor = UIColor.red

       
        }else{
            cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }

       
       
        
        cell.configure(sportName: viewModel.sport, leagueKey: self.LeagesResult?[indexPath.item].league_key!)
        
        if let imageUrl = URL(string: self.LeagesResult?[indexPath.row].league_logo ?? "") {
            cell.FavoriteImage.kf.setImage(with: imageUrl,placeholder: UIImage(named: "placeHolder"),options: [.callbackQueue(.mainAsync)]){
                sucsees in
                switch sucsees
                {
                case .success(_):
                    break

                case .failure(_):
                    cell.FavoriteImage?.image = UIImage(named:"placeHolder")
                    
                }
            }
        }
        else{
            cell.FavoriteImage.image = UIImage(named: "placeHolder")
        }
        //        cell.youtubeURL = self.LeagesResult?[indexPath.row].youtubeURL
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let LeageDetailVc =  storyboard?.instantiateViewController(withIdentifier: "LeaguesCollectionViewController") as? LeaguesCollectionViewController{
            LeageDetailVc.viewModel = LeagesDetailsViewModel(id: LeagesResult?[indexPath.row].league_key ?? 0 , sport: viewModel.sport ?? "football",LeageName: (LeagesResult?[indexPath.row].league_name)!,image: (LeagesResult?[indexPath.row].league_logo) ?? "")
            self.navigationController?.pushViewController(LeageDetailVc, animated: true)
        }
        else{
            print("Failed to instantiate 'AllLeagues' view controller")
        }
        
    }
}
