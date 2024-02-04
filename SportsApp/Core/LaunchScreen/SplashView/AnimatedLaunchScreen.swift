//
//  ViewController.swift
//  SportsApp
//
//  Created by radwan on 31/01/20224.
//

import UIKit
import Lottie
class AnimatedLaunchScreen: UIViewController {
    private var animationView: LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
         animationView = .init(name: "Sports")
         
         animationView!.frame = view.bounds
         
         animationView!.contentMode = .scaleAspectFit
         
         animationView!.loopMode = .loop
         
        animationView!.animationSpeed = 1.5
         
         view.addSubview(animationView!)
        
         animationView!.play()
        
       // Timer.scheduledTimer(timeInterval: 4.3 , target: self, selector: #selector(MainNav), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(MainNav), userInfo: nil, repeats: false)
        
    }
    

    @objc func MainNav(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBar") as? TabBarController
        self.navigationController!.pushViewController(vc!, animated: true)
        
        
        
       
    }
   
}
