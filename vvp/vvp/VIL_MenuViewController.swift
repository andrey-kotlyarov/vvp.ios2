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
    @IBOutlet var selOrgs: UIPickerView!
    
    
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
        
        selOrgs.dataSource = self
        selOrgs.delegate = self
        
        
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



extension VIL_MenuViewController: UIPickerViewDataSource
{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 5
    }
}

extension VIL_MenuViewController: UIPickerViewDelegate
{
    /*
    // returns width of column and height of row for each component.
    @available(iOS 2.0, *)
    optional public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    
    @available(iOS 2.0, *)
    optional public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    
    
    // these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
    // for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
    // If you return back a different object, the old one will be released. the view will be centered in the row rect
    @available(iOS 2.0, *)
    optional public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    
    @available(iOS 6.0, *)
    optional public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? // attributed title is favored if both methods are implemented
    
    @available(iOS 2.0, *)
    optional public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    
    
    @available(iOS 2.0, *)
    optional public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    */
}

