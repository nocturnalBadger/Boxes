//
//  GameViewController.swift
//  test
//
//  Created by Jeremy Schmidt on 10/3/14.
//  Copyright (c) 2014 Jeremy Schmidt. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    var scene: GameScene!
    
    @IBOutlet weak var togglesView: UIView!
    @IBOutlet weak var viewTogglingButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the view.
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        scene = GameScene(size: skView.bounds.size)
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        // scene.changeGravity(gravSlider.value)
        skView.presentScene(scene)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func moveSettingsOutOfScene()
    {
        UIView.animateWithDuration(0.5) {
            self.togglesView.constraints
            self.togglesView.frame.origin.y = -100 //= CGRectMake(self.togglesView.frame.origin.x, -100, self.togglesView.frame.width, self.togglesView.frame.height)
            self.viewTogglingButton.frame.origin.y -= 100 //= CGRectMake(self.viewTogglingButton.frame.origin.x, (self.viewTogglingButton.frame.origin.y - 100), self.viewTogglingButton.frame.width, self.viewTogglingButton.frame.height)
        }
    }
    
    func moveSettingsIntoScene()
    {
        UIView.animateWithDuration(0.5) {
            self.togglesView.frame.origin.y = 0 //= CGRectMake(self.togglesView.frame.origin.x, 0, self.togglesView.frame.width, self.togglesView.frame.height)
            self.viewTogglingButton.frame.origin.y += 100 //= CGRectMake(self.viewTogglingButton.frame.origin.x, (self.viewTogglingButton.frame.origin.y + 100), self.viewTogglingButton.frame.width, self.viewTogglingButton.frame.height)
            
        }
    }
    
    @IBAction func gravSliderDidChange(sender: UISlider)
    {
        scene.changeGravity(sender.value * -1)
    }
    
    //    @IBAction func rotationSwitchDidChange(sender: UISwitch)
    //    {
    //        if scene.rotationOn { scene.rotationOn = false }
    //        else { scene.rotationOn = true }
    //    }
    //
    @IBAction func bouncinessSliderDidChange(sender: UISlider)
    {
        scene.bounciness = CGFloat(sender.value)
    }
    
    @IBAction func frictionSliderDidChange(sender: UISlider)
    {
        scene.friction = sender.value
    }
    @IBAction func sizeSliderDidChange(sender: UISlider)
    {
        scene.maxSize = UInt32(sender.value)
    }
    
    @IBAction func clearAllButtonWasPressed(sender: UIButton)
    {
        scene.removeAllBoxes()
    }
    
    @IBAction func toggleToglingButtonWasPressed(sender: UIButton)
    {
        if togglesView.frame.origin.y == -100
        {
            moveSettingsIntoScene()
            //sender.setTitle("Hide", forState: UIControlState.Normal)
        }
        else
        {
            moveSettingsOutOfScene()
            //sender.setTitle("Show", forState: UIControlState.Normal)
        }
    }
    @IBAction func colorButonWasPressed(sender: UIButton)
    {
        sender.backgroundColor = scene.changeColor()
        
        if sender.backgroundColor == SKColor.blackColor() || sender.backgroundColor == SKColor.purpleColor() || sender.backgroundColor == SKColor.blueColor()
        {
            sender.setTitleColor(SKColor.whiteColor(), forState: UIControlState.Normal)
        }
        else
        {
            sender.setTitleColor(SKColor.blackColor(), forState: UIControlState.Normal)
        }
    }
}
