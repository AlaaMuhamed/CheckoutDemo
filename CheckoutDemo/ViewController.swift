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
    var madaBins = ["588845",    "440647" ,   "440795",   "446404" ,   "457865"  , "968208" ,
                    "588846"   , "493428"   , "539931"  ,  "558848" ,   "557606" ,   "968210" ,
                    "636120" ,   "417633"  ,  "468540" ,   "468541" ,  "468542"   , "468543",
                    "968201"  ,  "446393"  , "588847"  ,  "400861" ,  "409201" ,   "458456",
                    "484783"  ,  "968205"  ,  "462220"   , "455708",   "588848"  ,  "455036",
                    "968203"  ,  "486094"  ,  "486095"  ,  "486096"  ,  "504300" ,    "440533" ,
                    "489317"   , "489318"  ,  "489319"  ,  "445564" ,   "968211" ,   "401757",
                    "410685"  ,  "432328" ,  "428671" ,  "428672"  ,  "428673"  ,  "968206",
                    "446672"  ,  "543357" ,   "434107" ,  "431361"  ,  "604906"  ,  "521076",
                    "588850"   , "968202" ,   "535825"  ,  "529415" ,   "543085",   "524130",
                    "554180"  ,  "549760"  ,  "588849" ,   "968209" ,  "524514" ,  "529741",
                    "537767"  ,  "535989"  ,  "536023" ,  "513213" ,   "585265"  ,  "588983",
                    "588982"  ,  "589005"   , "508160"  ,  "531095" ,   "530906"   , "532013",
                    "588851"  ,  "605141"  ,  "968204" ,   "422817"  ,  "422818"  ,  "422819",
                    "428331" ,   "483010"  ,  "483011"  ,  "483012"  , "589206"   , "968207",
                    "419593"  ,  "439954"  ,  "407197"  ,  "407395" ,   "520058" ,   "530060",
                    "531196"]
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
                if madaBins.contains(cardToken?.bin ?? "") {
                    print("isMadaCard")
                }
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

