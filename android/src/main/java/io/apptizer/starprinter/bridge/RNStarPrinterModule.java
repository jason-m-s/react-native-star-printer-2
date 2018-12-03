
package io.apptizer.starprinter.bridge;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class RNStarPrinterModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNStarPrinterModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNStarPrinter";
  }
}