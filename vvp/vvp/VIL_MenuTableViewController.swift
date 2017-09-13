//
//  UI_MenuTableViewController.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 08.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIL_MenuTableViewController: UITableViewController
{
    
    
    
    
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = "Virtual Video Pass"
        tableView.tintColor = VIM_DesignData.current.colorTint
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rowsCount = 0
        
        switch section
        {
            case 0:
                rowsCount = 2
            case 1:
                rowsCount = 3
            default:
                rowsCount = 0
        }
        
        // #warning Incomplete implementation, return the number of rows
        return rowsCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.section == 0 && indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuProfileCell", for: indexPath) as! VIL_MenuProfileTableViewCell
            
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.myUpdateCell(profile: VIM_AuthData.current.profile!)
            
            return cell
        }
        else if indexPath.section == 0 && indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
            
            cell.accessoryType = (VIM_AuthData.current.orgs!.count > 1 ? UITableViewCellAccessoryType.disclosureIndicator : UITableViewCellAccessoryType.none)
            cell.textLabel?.text = "Organization: " + (VIM_AuthData.current.org?.name ?? "")
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
            
            //cell.accessoryType = UITableViewCellAccessoryType.detailButton
            
            if indexPath.row == 0
            {
                cell.accessoryType = UITableViewCellAccessoryType.detailDisclosureButton
                cell.textLabel?.text = "Viewer"
            }
            if indexPath.row == 1
            {
                cell.accessoryType = UITableViewCellAccessoryType.detailButton
                cell.textLabel?.text = "Streamer"
            }
            if indexPath.row == 2
            {
                cell.accessoryType = UITableViewCellAccessoryType.none
                cell.textLabel?.text = "Other"
            }
            
            return cell
        }
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 && indexPath.row == 0
        {
            return 72.0
        }
        
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 && indexPath.row == 0
        {
            return 72.0
        }
        
        return 44.0
    }
    
    /*
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let label = UILabel()
        label.text = "HEADER \(section)"
        
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let label = UILabel()
        label.text = "FOOTER \(section)"
        
        
        return label
    }
    */
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0
        {
            return "PROFILE"
        }
        if section == 1
        {
            return "ACTIONS"
        }
        
        return ""
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        //return true
        
        return false
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert
        {
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
        //return true
        
        return false
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    {
        if indexPath.section == 1 && indexPath.row == 0
        {
            //"Viewer"
            let alertController = UIAlertController(title: "VVP VIEWER", message: "About Virtual Video Pass Viewer", preferredStyle: .alert)
            alertController.view.tintColor = VIM_DesignData.current.colorTint
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        if indexPath.section == 1 && indexPath.row == 1
        {
            //"Streamer"
            let alertController = UIAlertController(title: "VVP STREAMER", message: "About Virtual Video Pass Streamer", preferredStyle: .alert)
            alertController.view.tintColor = VIM_DesignData.current.colorTint
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.section == 0 && indexPath.row == 0
        {
            performSegue(withIdentifier: "vilMenuToProfile", sender: self)
        }
        
        if indexPath.section == 0 && indexPath.row == 1
        {
            if VIM_AuthData.current.orgs!.count > 1
            {
                performSegue(withIdentifier: "vilMenuToOrg", sender: self)
            }
        }
        
        if indexPath.section == 1
        {
            
            if indexPath.row == 0
            {
                
                VIM_AuthData.current.clearStreamList()
                performSegue(withIdentifier: "vilMenuToStreamList", sender: self)
            }
            if indexPath.row == 1
            {
                //TODO
                let sb = UIStoryboard.init(name: "Stream", bundle: nil)
                let vcStream = sb.instantiateViewController(withIdentifier: "visStream") as! VIS_StreamViewController
                self.present(vcStream, animated: true, completion: nil)
            }
            
            if indexPath.row == 2
            {
                
            }
        }
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //DEBUG
        //print("S1: " + segue.identifier!)
    }
    

}
