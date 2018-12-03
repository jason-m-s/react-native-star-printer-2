
# react-native-star-printer-2

## Getting started

`$ npm install react-native-star-printer-2 --save` (not hosted on npm yet. Download the package, extract and use `npm install path/to/package`)

### Mostly automatic installation

`$ react-native link react-native-star-printer-2`

* You need to link the following frameworks into your Xcode project 
    1. Go to `https://www.starmicronics.com/support/sdkdocumentation.aspx` and download the iOS SDK
    2. Drag the `StarIO.framework` and `StarIO_Extension.framework` found in the SDK under your `project-path/Frameworks` folder
    3. Add `CoreBluetooth.framwork` and `ExternalAccessory.framework` in the `Link Binary with Libraries` build phase

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-star-printer-2` and add `RNStarPrinter.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNStarPrinter.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Follow the steps * above
5. Run your project (`Cmd+R`)<

#### Android (Not Supported Yet)

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import io.apptizer.starprinter.bridge.RNStarPrinterPackage;` to the imports at the top of the file
  - Add `new RNStarPrinterPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-star-printer'
  	project(':react-native-star-printer').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-star-printer/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-star-printer-2')
  	```


## Usage
```javascript
import {NativeModules} from 'react-native';
const StarPrinter = NativeModules.StarPrinter;

// TODO: What to do with the module?
StarPrinter;

// The following commands are exposed by the native bridge

// 1. Scan for printers
StarPrinter.searchPrinter("target") //target: "BT:" "BLE:" "TCP:" "USB:"

// 2. Print base64 image
StarPrinter.printBase64Image(
                base64Image,
                printer.portName,
                printer.modelName,
                StarPrinter.PaperSizes.ThreeInch)
            .then((response) => console.log(response))
            .catch((error) => console.log(error))
            
// 3. Print HTML String (css supported)
StarPrinter.printHtmlString(
                htmlString,
                printer.portName,
                printer.modelName,
                StarPrinter.PaperSizes.ThreeInch,
                height)
                .then((response) => console.log(response + ": Success"))
                .catch((error) => console.log(error));
```

