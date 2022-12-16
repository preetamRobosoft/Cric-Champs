//
//  MainPageController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 07/12/22.
//


import UIKit

class MainPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageHeadings = ["Welcome to Cric Champs!", "Create & Manage Tournaments", "View Tournaments"]
    var pageImages = ["WelcomeInfo1", "WelcomeInfo3", "WelcomeInfo3"]
    var pageContent = ["Your one stop app for Creating and managing your own cricket tournaments and share it with your viewers.",
                       "Create Fixtures by inputting teams, grounds, umpires, overs etc. and manage them thereafter.",
                       "Use Tournament code to get access for viewing live scores and updates of a tournament."]
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! OnboardingViewController).index
        index -= 1
        return contentViewController(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! OnboardingViewController).index
        index += 1
        return contentViewController(at: index)
    }

    func contentViewController(at index: Int) -> OnboardingViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
            pageContentViewController.index = index
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            return pageContentViewController
        }

        return nil
    }

    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1 ) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            if index == 1{
            nextViewController.skip.isHidden = true
            }
        }
    }
}
