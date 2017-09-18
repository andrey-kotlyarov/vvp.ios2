//
//  VIP_StreamListTableViewController.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 12.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation




class VIP_StreamListTableViewController: UITableViewController
{
    
    fileprivate var _bbtBack: UIBarButtonItem?
    fileprivate var _bbtThumbLarge: UIBarButtonItem?
    fileprivate var _bbtThumbSmall: UIBarButtonItem?
    
    
    
    
    
    fileprivate var _viuActivity: VIU_Activity?
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .default
    }
    
    
    
    
    
    override func viewDidLayoutSubviews()
    {
        
        //print("viewDidLayoutSubviews")
        
        if VIM_UserData.current.thumbType == .large
        {
            self.tableView.separatorStyle = .singleLine
        }
        if VIM_UserData.current.thumbType == .small
        {
            self.tableView.separatorStyle = .none
        }
        
        
        
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        //print("did load")
        self.tableView.separatorStyle = .none
        self.tableView.separatorColor = VIM_DesignData.current.colorBG.withAlphaComponent(0.25)
        self.tableView.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        //self.tableView.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        self._viuActivity = VIU_Activity()
        
        //self.view.tintColor = VIM_DesignData.current.colorTint
        
        
        // NAVIGATION BAR
        self.navigationItem.title = "Viewer"
        self._bbtBack = UIBarButtonItem(
            image: UIImage(named: "ic_chevron_left"),
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(bbtBack_OnTouchUp(_:))
        )
        self._bbtThumbLarge = UIBarButtonItem(
            image: UIImage(named: "ic_view_agenda"),
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(bbtThumbLarge_OnTouchUp(_:))
        )
        self._bbtThumbSmall = UIBarButtonItem(
            image: UIImage(named: "ic_reorder"),
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(bbtThumbSmall_OnTouchUp(_:))
        )
        
        
        self.navigationItem.setLeftBarButtonItems(NSArray(object: self._bbtBack!) as? [UIBarButtonItem], animated: false)
        
        //self.navigationItem.setRightBarButtonItems(NSArray(objects: self._bbtThumbSmall!, self._bbtThumbLarge!) as? [UIBarButtonItem], animated: true)
        
        if (VIM_UserData.current.thumbType == .large)
        {
            self.navigationItem.setRightBarButtonItems(NSArray(object: self._bbtThumbLarge!) as? [UIBarButtonItem], animated: true)
        }
        else if (VIM_UserData.current.thumbType == .small)
        {
            self.navigationItem.setRightBarButtonItems(NSArray(object: self._bbtThumbSmall!) as? [UIBarButtonItem], animated: true)
        }
        
        
        
        
        self.myTask_GetStreams()
        
        
    }
    
    func bbtBack_OnTouchUp(_ sender: UIBarButtonItem?)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func bbtThumbLarge_OnTouchUp(_ sender: UIBarButtonItem?)
    {
        VIM_UserData.current.thumbType = .small
        VIM_UserData.current.saveUserData()
        
        
        //todo ???
        self.navigationItem.setRightBarButtonItems(NSArray(object: self._bbtThumbSmall!) as? [UIBarButtonItem], animated: true)
        self.tableView.reloadData()
    }
    func bbtThumbSmall_OnTouchUp(_ sender: UIBarButtonItem?)
    {
        VIM_UserData.current.thumbType = .large
        VIM_UserData.current.saveUserData()
        
        
        //todo ???
        self.navigationItem.setRightBarButtonItems(NSArray(object: self._bbtThumbLarge!) as? [UIBarButtonItem], animated: true)
        self.tableView.reloadData()
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        //VIU_App.lockOrientation(.portrait)
        
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        //VIU_App.lockOrientation(.all)
    }
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //
    // My methods
    //
    /*
    private func myDidError(_ title: String, errorMessage: String) -> Void
    {
        let alertController = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alertController.view.tintColor = VIM_DesignData.current.colorTint
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
        
        return
    }
    
    private func myDidError(_ title: String, error: Error?) -> Void
    {
        self.myDidError(title, errorMessage: error?.localizedDescription ?? "")
    }
    */
    
    
    private func myTask_GetStreams() -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self._viuActivity?.show()
        
        
        let viuRequest: VIU_Request = VIU_Request(cmd: "get_stream_list")
        viuRequest.addPostValue(VIM_UserData.current.token!, forKey: "token")
        
        if VIM_UserData.current.isDebugMode()
        {
            //DEBUG
            viuRequest.addPostValue("1", forKey: "_testdata_")
        }
        
        //DEBUG
        //viuRequest.addPostValue("2500", forKey: "_delay_")
        
        //DEBUG
        //print(viuRequest)
        
        let task = URLSession.shared.dataTask(
            with: viuRequest.urlRequest(),
            completionHandler:
            {
                (data: Data?, response: URLResponse?, error: Error?) in
                
                //
                // completionHandler START
                //
                //
                
                //DEBUG
                //print("data: \(data)")
                //print("response: \(response)")
                //print("error: \(error)")
                
                DispatchQueue.main.async()
                {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self._viuActivity?.hide()
                    
                    if error != nil || response == nil || data == nil
                    {
                        VIU_UI.alertError(title: "URL Error", error: error, viewController: self)
                        return
                    }
                    
                    if (response as? HTTPURLResponse)!.statusCode / 100 != 2 || response!.mimeType != "application/json"
                    {
                        VIU_UI.alertError(title: "HTTP Error", errorMessage: "HTTP Error\nmime-type: \(response!.mimeType ?? "-")\nstatus-code: \((response as? HTTPURLResponse)!.statusCode)", viewController: self)
                        return
                    }
                    
                    
                    
                    
                    
                    do
                    {
                        let allJsonData: NSMutableDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                        
                        let json_code = allJsonData["code"] as! Int
                        let json_mess = allJsonData["mess"] as! String
                        
                        //DEBUG
                        //print("JSON: \(allJsonData)")
                        //print("JSON_code: \(json_code); JSON_mess: \(json_mess)")
                        
                        
                        if json_code != 0
                        {
                            VIU_UI.alertError(title: "API Error", errorMessage: json_mess, viewController: self, code: json_code)
                            return
                        }
                        
                        
                        
                        let json_data = allJsonData["data"] as! NSDictionary
                        VIM_AuthData.current.updateStreamListBy(dict: json_data)
                        
                        //print(VIM_AuthData.current.description)
                        self.tableView.reloadData()
                    }
                    catch let jsonError as NSError
                    {
                        VIU_UI.alertError(title: "JSON Error", error: jsonError as Error, viewController: self)
                        return
                    }
                    
                    
                    
                    
                    
                }
                
                //
                // completionHandler END
                //
                //
            }
        )
        task.resume()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        
        //DEBUG
        //print("tt = \(VIM_UserData.current.thumbType.description)")
        
        return VIM_AuthData.current.streamList?.streams.count ?? 0
    }
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if VIM_UserData.current.thumbType == .small
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StreamListSmallCell", for: indexPath) as! VIP_StreamListSmallTableViewCell
            
            //
            //
            //
            cell.updateByStream(VIM_AuthData.current.streamList!.streams[indexPath.row], theRowIndex: indexPath.row)
            
            cell.imgThumb.image = nil
            VIM_ImageData.current.imageBy(
                src: VIM_AuthData.current.streamList!.streams[indexPath.row].takeThumbSmallSrc(),
                ttl: 120,
                completationBlock:
                {
                    (img: UIImage?) -> Void in
                    
                    //print("\(indexPath.row) <-> \(cell.myRowIndex)")
                    
                    if indexPath.row == cell.myRowIndex
                    {
                        cell.imgThumb.image = img
                    }
            }
            )
            //
            //
            //
            
            return cell
        
        
        }
        //else if VIM_UserData.current.thumbType == .large
        //{
            let cell = tableView.dequeueReusableCell(withIdentifier: "StreamListCell", for: indexPath) as! VIP_StreamListTableViewCell
            
            //
            //
            //
            cell.updateByStream(VIM_AuthData.current.streamList!.streams[indexPath.row], theRowIndex: indexPath.row)
        
            cell.imgThumb.image = nil
            VIM_ImageData.current.imageBy(
                src: VIM_AuthData.current.streamList!.streams[indexPath.row].takeThumbLargeSrc(),
                ttl: 120,
                completationBlock:
                {
                    (img: UIImage?) -> Void in
                    
                    //print("\(indexPath.row) <-> \(cell.myRowIndex)")
                    
                    if indexPath.row == cell.myRowIndex
                    {
                        cell.imgThumb.image = img
                    }
                }
            )
            //
            //
            //
            
            return cell
        //}
        
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var height: CGFloat = 0.0
        
        switch VIM_UserData.current.thumbType
        {
        case .large:
            height = VIM_DesignData.current.viewerRowLarge_H
        case .small:
            height = VIM_DesignData.current.viewerRowSmall_H
        }
        
        return height
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var height: CGFloat = 0.0
        
        switch VIM_UserData.current.thumbType
        {
        case .large:
            height = VIM_DesignData.current.viewerRowLarge_H
        case .small:
            height = VIM_DesignData.current.viewerRowSmall_H
        }
        
        return height
    }
    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the item to be re-orderable.
        return false
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        VIM_AuthData.current.stream = VIM_AuthData.current.streamList!.streams[indexPath.row]
        
        
        let pvc = storyboard?.instantiateViewController(withIdentifier: "vipPlayer") as! VIP_PlayerViewController
        
        
        
        if let urlVideo = VIM_AuthData.current.stream!.videoURL
        {
            pvc.player = AVPlayer(url: urlVideo);
            present(pvc, animated: true, completion: nil)
        }
        
        
        
        
        
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
