//
//  VIL_MenuViewController.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIL_MenuViewController: UIViewController
{
    @IBOutlet var btnViewer: UIButton!
    @IBOutlet var btnStreamer: UIButton!
    
    @IBAction func btnViewer_OnTouchUp(_ sender: Any)
    {
        print("Go to Viewer")
    }
    
    @IBAction func btnStreamer_OnTouchUp(_ sender: Any)
    {
        print("Go to Streamer")
        
        let sb = UIStoryboard.init(name: "Stream", bundle: nil)
        let vcStream = sb.instantiateViewController(withIdentifier: "visStream") as! VIS_StreamViewController
        
        present(vcStream, animated: true, completion: nil)
    }
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .default
    }
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    /*
    override func viewWillDisappear(_ animated: Bool)
    {
        print("Menu Controler - WILL DISAPPEAR")
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        print("Menu Controler - DID  DISAPPEAR")
    }
    */
    
    

    override func didReceiveMemoryWarning()
    {
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
