//
//  BaseViewController.swift
//  CoffeeShopFinder
//
//  Created by Joey Lee on 13/4/18.
//  Copyright © 2018 Joey Lee. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    /// this is automatically addded to *self.view* as a first childview.
    var mainView: UIView!
    /**
        if true, *mainView* will cover the status bar area.
        - important: set the value before calling *super.loadView()* in *loadView()* in child class.
    */
    var extendMainViewToTop: Bool = false
    /**
     if true, *mainView* will cover bottom home button area. it is effective only on 5.8 inches screen, iPhone X.
     - important: set the value before calling *super.loadView()* in *loadView()* in child class.
     */
    var extendMainViewToBottom: Bool = false
    
    override func loadView() {
        super.loadView()
        
        let frame = UIScreen.main.bounds
        
        // create a view
        view = UIView(frame: frame)
        view.backgroundColor = UIColor.white
        
        // create a main view
        mainView = UIView(frame: frame)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = UIColor.clear
        view.addSubview(self.mainView)
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: extendMainViewToTop ? view.topAnchor : view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: extendMainViewToBottom ? view.bottomAnchor : view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
