//
//  ViewController.swift
//  CheckoutDemo
//
//  Created by Holo Technology on 4/19/20.
//  Copyright © 2020 Holo Technology. All rights reserved.
//

import UIKit
import Frames

class ViewController: UIViewController , CardViewControllerDelegate {
 
    @IBAction func goToPaymentPage(_ sender: Any) {
           navigationController?.pushViewController(cardViewController, animated: true)
       }

    let checkoutAPIClient = CheckoutAPIClient(publicKey: "pk_test_0ac26ab2-1195-456e-ae4c-d7c8be788f90",
                                                 environment: .sandbox)
       var cardViewController: CardViewController {
              let checkoutAPIClient = CheckoutAPIClient(publicKey: "pk_test_0ac26ab2-1195-456e-ae4c-d7c8be788f90",
                                                        environment: .sandbox)
              let b = CardViewController(checkoutApiClient: checkoutAPIClient, cardHolderNameState: .normal, billingDetailsState: .normal, defaultRegionCode: "SA")
//              b.billingDetailsAddress = CkoAddress(addressLine1: "Test line1", addressLine2: "Test line2", city: "London", state: "London", zip: "N12345", country: "GB")
//              b.billingDetailsPhone = CkoPhoneNumber(countryCode: "44", number: "77 1234 1234")
              b.delegate = self
//              b.addressViewController.setFields(address: b.billingDetailsAddress!, phone: b.billingDetailsPhone!)
              return b
          }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the card view controller delegate
        cardViewController.delegate = self
        // replace the bar button by Pay
        cardViewController.rightBarButtonItem = UIBarButtonItem(title: "PAY", style: .done , target: nil, action: nil)
        // specified which schemes are allowed
        cardViewController.availableSchemes = [.visa, .mastercard]

//        cardViewController.setDefault(regionCode: "GB")
    }
    
    
    
     func onTapDone(controller: CardViewController, cardToken: CkoCardTokenResponse?, status: CheckoutTokenStatus) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch status {
            case .success:
                self.showAlert(with: cardToken?.token ?? "")

                print("tokeeen \(cardToken)")
            case .failure:
                print("failure")
            }
               
     }
     
     func onSubmit(controller: CardViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true


     }
    
    private func showAlert(with cardToken: String) {
           let alert = UIAlertController(title: "Payment",
                                         message: cardToken, preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .default) { _ in
               alert.dismiss(animated: true, completion: nil)
           }
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
       }


}

