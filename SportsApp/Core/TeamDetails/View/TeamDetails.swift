//
//  TeamDetails.swift
//  SportsApp
//
//  Created by radwan on 02/02/20224.
//

import UIKit

class TeamDetails: UIViewController {
  
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var TeamLogo: UIImageView!
    
    @IBOutlet weak var TeamName: UILabel!
    @IBOutlet weak var TeamMeberCollection: UICollectionView!
    
    var viewModel : TeamDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TeamMeberCollection.delegate = self
        self.TeamMeberCollection.dataSource = self
        TeamMeberCollection.register(UINib(nibName: "TeamMembersCell", bundle: nil), forCellWithReuseIdentifier: "TeamMembersCell")
        
        LayoutConfig()
        LoadData()
        // Do any additional setup after loading the view.
    }
    
    
    convenience init(viewModel: TeamDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    

    func LayoutConfig() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            return self.Players()
        }
        TeamMeberCollection.setCollectionViewLayout(layout, animated: true)
    }
    
    func LoadData(){
        viewModel.FetchTeamDetails {[weak self] teamDetail in
            
            DispatchQueue.main.async {
                self?.TeamMeberCollection.reloadData()
                self?.TeamName?.text = self?.viewModel.TeamData?.first?.team_name ?? ""
                if let imageUrl = URL(string: self?.viewModel.TeamData?.first?.team_logo ?? ""){
                    self?.TeamLogo?.kf.setImage(with:imageUrl,placeholder: UIImage(named:"placeHolder"),options: [.callbackQueue(.mainAsync)])
                
                
            }
            else{
                
                self?.TeamLogo?.image = UIImage(named:"placeHolder")
            }
        }
        
    }
    }
}

extension TeamDetails:UICollectionViewDelegate,UICollectionViewDataSource {
    // MARK: - collection Data Sore
  
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // print("DeBuG:\(viewModel.TeamData)")
            print("DeBuG:\(viewModel.TeamData?.first?.coaches?.count)")
            switch section{
            case 0 :
             
                return  viewModel.sport=="tennis" ? 0: viewModel.TeamData?.first?.coaches?.count ?? 0
            case 1 :
                return viewModel.sport=="tennis" ? 1: viewModel.TeamData?.first?.players?.count ?? 0
            default: return 1
            }
        }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell  = TeamMeberCollection.dequeueReusableCell(withReuseIdentifier: "TeamMembersCell", for: indexPath) as? TeamMembersCell
            cell?.backgroundColor = .systemGray3
            cell?.PlayerImage.contentMode = .scaleAspectFill
            cell?.AgeLabel.isHidden = false
            cell?.card1label.isHidden = false
            cell?.card2label.isHidden = false
            cell?.teshirtnumber.isHidden = false
            switch indexPath.section{
            case 0 :
                cell?.PlayerImage.image = UIImage(named:"placeHolder")
                cell?.PlayerName.text = viewModel.TeamData?.first?.coaches?[indexPath.row].coach_name
                cell?.AgeLabel.isHidden = true
                cell?.card1label.isHidden = true
                cell?.card2label.isHidden = true
                cell?.teshirtnumber.isHidden = true
                cell?.PlayerAge.isHidden = true
                cell?.PlayerNumber.isHidden = true
                cell?.PlayerRedCards.isHidden = true
                cell?.PlayerYelloCards.isHidden = true
            case 1 :
                if(viewModel.sport=="tennis"){
                    cell?.AgeLabel.isHidden = true
                    cell?.card1label.isHidden = true
                    cell?.card2label.isHidden = true
                    cell?.teshirtnumber.isHidden = true
                    cell?.PlayerAge.isHidden = true
                    cell?.PlayerNumber.isHidden = true
                    cell?.PlayerRedCards.isHidden = true
                    cell?.PlayerYelloCards.isHidden = true
                }
                
                if let imageUrl = URL(string: viewModel.TeamData?.first?.players?[indexPath.row].player_image ?? ""){
                    cell?.PlayerImage.kf.setImage(with:imageUrl,placeholder: UIImage(named: "placeHolder"),options: [.callbackQueue(.mainAsync)]){
                        sucsees in
                        switch sucsees
                        {
                        case .success(_):
                            break
//                            print("Task done for: \(value.source.url?.absoluteString ?? "")")
                        case .failure(_):
                            cell?.PlayerImage?.image = UIImage(named:"placeHolder")
                            
                        }
                    }
                    
                    }
             
                
                cell?.PlayerName.text = viewModel.TeamData?.first?.players?[indexPath.row].player_name
                cell?.PlayerAge.text = viewModel.TeamData?.first?.players?[indexPath.row].player_age
                cell?.PlayerNumber.text = viewModel.TeamData?.first?.players?[indexPath.row].player_number
                cell?.PlayerYelloCards.text = viewModel.TeamData?.first?.players?[indexPath.row].player_yellow_cards
                cell?.PlayerRedCards.text = viewModel.TeamData?.first?.players?[indexPath.row].player_red_cards
            default:
                return UICollectionViewCell()
            }
            return cell!
        }

    
    //MARK: Header Functions
    func supplementtryHeader()->NSCollectionLayoutBoundarySupplementaryItem{
        
        .init(layoutSize: .init(widthDimension:.fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top )
        
    }
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         if kind == UICollectionView.elementKindSectionHeader{
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
             
             switch indexPath.section {
             case 0 :
                 if viewModel.sport=="tennis"||viewModel.sport=="basketball"||viewModel.sport=="cricket"{
                    sectionHeader.HeaderTitle?.text = ""
                    }
                else{ sectionHeader.HeaderTitle?.text = "Coaches"}
               // sectionHeader.HeaderTitle?.text = "Coaches"
                return sectionHeader
                
            case 1 :
                if viewModel.sport=="tennis"{
                    
                    sectionHeader.HeaderTitle?.text = "Player"
                    }
                else if viewModel.sport=="basketball"||viewModel.sport=="cricket"{
                    sectionHeader.HeaderTitle?.text = ""
                }
                else{ sectionHeader.HeaderTitle?.text = "Players"}
                
              //  sectionHeader.HeaderTitle?.text = "Players"
                return sectionHeader
        
                
            default :
                sectionHeader.HeaderTitle?.text = ""
                return sectionHeader
            }
        }
        return UICollectionViewCell()
    }
    
    
    
    
    //MARK: Functions For Animation
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func Players()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                               , heightDimension: .absolute(280))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                        , bottom: 10, trailing: 15)
        section.boundarySupplementaryItems = [self.supplementtryHeader()]
        return section
    }
    
    
    
}


