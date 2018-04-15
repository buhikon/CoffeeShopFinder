# CoffeeShopFinder
A swift sample app which provides local coffee shops based on user location using Four Square APIs.


## How to run code
1. Check out or download this repository
2. Open `CoffeeShopFinder.xcworkspace` in `Xcode`
3. Choose appropriate device and run  `[Command]+ [R]` in Xcode

Cocoapods must be installed in your mac. If not, use the command below in Terminal app to install.
```
$ sudo gem install cocoapods
```

This project uses some open source libraries which is installed by Cocoapods. If something goes wrong with the libraries, please use the command below in Terminal app.
```
$ cd /{your_project_directory}
$ pod update
```

## How to test code
1. Press `[Command]`+`[U]` in Xcode


## Approaches
*Agile Approach*. Because I wanted to emphasis developing the app rather than predefined structured development.

I simply set the deadline to weekend, and started designing the structure. After that I started to write codes, test, and modify repeatedly.

## Assumptions
    * This project has been developed on Xcode 9.2
    * Compatible with iPhone and iPod Touch, but not iPad.
    * Requires iOS 11 or later to install the app.
    * Device should support GPS and be connected to the internet. Otherwise, it would be unable to continue to use.

## Architecture
This project has been developed in simplified MVP pattern for quick development and better testability.

## Network Module
This project has HTTP network functionality. It is based on [Alamofire](https://github.com/Alamofire/Alamofire) framework, and more features are added. 
Every API has its *Request* and *Response* class. 
    * *Request* class helps to build URLRequest easily.  
    * JSON response from server side will be stored in *Response* class.

## Used Open Source libraries
    * [Alamofire](https://github.com/Alamofire/Alamofire)
    * [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper)
    * [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)
    * [Toast-Swift](https://github.com/scalessec/Toast-Swift)

## Images license
This project contains images designed by [FreePik](http://www.freepik.com).
