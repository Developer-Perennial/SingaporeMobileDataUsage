# SingaporeMobileDataUsage

This application display the amount the of data sent over Singapore’s mobile networks.
Showing the data Year wise. Can see the year in which data usage get descrease

Fetching the data from url https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=500


# Application workflow:
1. Application is develope using the MVVM architecture.
2. Used alamofire for api calling
3. Used Core data framework for local cache.

![workFlow](https://github.com/Developer-Perennial/SingaporeMobileDataUsage/blob/master/Architecture.png)

# How to use:
1. Clone the repository
2. Install Pods
3. Run application using Xcode

# How to Unit test:
  Added differrent target for UI and functinal Unit testing
  1.  DataUsage Unit Tests
      This target is use to Unit test the viewcontroller, viewModel, DB services and Network services. 
  2. Mobile Data UsageUITests
      This target is use to do UI testing.
    
Code coverge
![Code coverage](https://github.com/Developer-Perennial/SingaporeMobileDataUsage/blob/master/Code%20coverage.png)

# Pod files 
1. Alamofire
    Use for network services calling.

2. IHProgressHUD
   Use to show loading indicator.

   
