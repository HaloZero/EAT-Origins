//
//  RootCoordinator.swift
//  Origins
//
//  Created by Rohan on 4/21/16.
//  Copyright © 2016 Rohan. All rights reserved.
//

import Foundation

class RootCoordinator {

    let navigationController = UINavigationController()

    func start() {
        navigationController.navigationBarHidden = true
        let listViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ListView")
        // I'm supposed to become the ListViewController's delegaet but now I've created a circular dependency
        // What happens if a ViewController is doing more than one thing? Does that mean the delegate does more than one thing?

//        listViewController.delegate = self
        navigationController.pushViewController(listViewController, animated: true)
    }

    func showUser(user: User) {
        let profileViewController = ProfileViewController(user: user)
        navigationController.pushViewController(profileViewController, animated: true)
    }
}

protocol SelectUserDelegate {

    func didSelectUser(user: User)
}