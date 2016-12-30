//
//  ContactsViewController.swift
//  DaumMapExample
//
//  Created by YuJungin on 2016. 12. 29..
//  Copyright © 2016년 이규진. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UITableViewController {
    
    var contactList = [CNContact]()
  //  var filteredList = [CNContact]()
   // var isStudent = true
  //  let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        
        let userDefault = UserDefaults.standard
        userDefault.string(forKey: "어쭈구")
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "누구"
        print("1")
        hideKeyboardWhenTappedAround()
        print("2")
        initViews()
        print("3")
        initModels()
        print("4")
    }
    
    func initViews() {
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
       // tableView.tableHeaderView = searchController.searchBar
    }
    
    func initModels() {
        getContacts()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = contactList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneNumCell")!
        let formatter = CNContactFormatter()
        
        cell.textLabel!.text = formatter.string(from: item)
        let number = item.phoneNumbers.first?.value
        print(number?.stringValue.asPhoneFormat)
//        
//        if let phoneNumberToText = number?.stringValue.asPhoneFormat{
//            cell.detailTextLabel!.text = phoneNumberToText
//        }
//        cell.detailTextLabel!.text = number?.stringValue.asPhoneFormat
        
        return cell
    }
    
    //연락처 정보 가져오는 메소드
    func getContacts() {
        let store = CNContactStore()
        
        //현재 디바이스에서 해당 앱이 연락처에 접근하는걸 승인했는지 아닌지 체크하는 메소드
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            store.requestAccess(for: .contacts, completionHandler: { (authorized: Bool, error: Error?) -> Void in
                if authorized {
                    self.retrieveContactsWithStore(store)
                }
            })
        } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            retrieveContactsWithStore(store)
        }
    }
    
    
    //디바이스에 저장된 연락처를 가져와 [CNContact] 배열에 저장하는 메소드
    func retrieveContactsWithStore(_ store: CNContactStore) {
        do {
            let contactIDs = try store.defaultContainerIdentifier()
            
            let predicate = CNContact.predicateForContactsInContainer(withIdentifier: contactIDs)
            
            //각각의 정보마다(전화번호, 이메일, 이름 등) 고유키가 있고 이 키를 지정해주지 않으면 해당 정보를 가져올 수 없다. 여기서는 전화번호를 가져오기 위해 CNContactPhoneNumbersKey를 사용
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
            contactList = contacts
         
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })
        } catch {
            print(error)
        }
    }

    
//    //검색창에 사용자가 입력하는 값에 따라 매번 테이블뷰의 내용을 갱신
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        filteredList = contactList.filter { contact in
//            let formatter = CNContactFormatter()
//            if let text = formatter.string(from: contact) {
//                if searchText.isEmpty {
//                    return true
//                } else {
//                    return text.contains(searchText)
//                }
//            } else {
//                return false
//            }
//        }
//        tableView.reloadData()
//    }
    
//    //검색창에 사용자가 입력할 때마다 위의 메소드 실행
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchText: searchController.searchBar.text!)
//    }

}
