//
//  VIP_StreamListTableViewController.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 12.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIP_StreamListTableViewController: UITableViewController
{
    fileprivate var _viuActivity: VIU_Activity?
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .default
    }
    
    
    
    
    //
    //
    //
    
    
    
    /*
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        
        // Only allow Portrait
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        
        // Only allow Portrait
        return UIInterfaceOrientation.Portrait
    }
    */
    
    
    //
    //
    //
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        self._viuActivity = VIU_Activity()
        
        self.view.tintColor = VIM_DesignData.current.colorTint
        self.navigationItem.title = "Viewer"
        
        self.myTask_GetStreams()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //
    // My methods
    //
    
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
    
    
    
    private func myTask_GetStreams() -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self._viuActivity?.show()
        
        
        let viuRequest: VIU_Request = VIU_Request(cmd: "getstreams")
        viuRequest.addPostValue(VIM_UserData.current.token!, forKey: "token")
        viuRequest.addPostValue("\(VIM_DesignData.current.viewerThumbLarge_W_px)", forKey: "thumbnailwidth")
        viuRequest.addPostValue("\(VIM_DesignData.current.viewerThumbLarge_H_px)", forKey: "thumbnailheight")
        //viuRequest.addPostValue(String(VIM_DesignData.current.sizeType), forKey: "sizetype")
        
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
                        self.myDidError("URL Error", error:error)
                        return
                    }
                    
                    if (response as? HTTPURLResponse)!.statusCode / 100 != 2 || response!.mimeType != "application/json"
                    {
                        self.myDidError("HTTP Error", errorMessage: "HTTP error details:\nmime-type: \(response!.mimeType ?? "-")\nstatus-code: \((response as? HTTPURLResponse)!.statusCode)")
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
                            self.myDidError("API Error", errorMessage: json_mess + "\n(code = \(json_code))")
                            return
                        }
                        
                        
                        
                        let json_data = allJsonData["data"] as! NSDictionary
                        VIM_AuthData.current.updateStreamListBy(dict: json_data)
                        
                        //print(VIM_AuthData.current.description)
                        self.tableView.reloadData()
                    }
                    catch let jsonError as NSError
                    {
                        self.myDidError("JSON Error", error:(jsonError as Error))
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
        return VIM_AuthData.current.streamList?.streams.count ?? 0
    }
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StreamListCell", for: indexPath) as! VIP_StreamListTableViewCell
        
        
        cell.updateByStream(VIM_AuthData.current.streamList!.streams[indexPath.row])
        //cell.updateByStream(VIM_AuthData.current.streamList!.streams[indexPath.row], tableView: self.tableView)

        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return VIM_DesignData.current.viewerRowLarge_H
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return VIM_DesignData.current.viewerRowLarge_H
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
