Note: This is a WIP fork to evaluating the ability to set individual corners. Progress:

- [x] iOS
- [ ] Android
- [ ] Fix Issue: Given a SquircleView has no child element, when not all corner properties set, and not a borderRadius is set, then the view will have a rounded corner set on all corners

I may or may not continue this work depending on need. 

# expo-squircle-view

A native implementation for figma corner smoothing (Squircle Shape) for react native expo apps

<p align="center">
<img width="830" alt="Screenshot 2024-01-19 at 3 55 14 PM" src="https://github.com/Malaa-tech/expo-squircle-view/assets/24798045/1c403119-11bc-49c0-9310-d8211ae6b020">
</p>


# Installation in managed Expo projects
```
npm install expo-squircle-view 
```
or
```
yarn add expo-squircle-view 
```

Then prebuild your app

# Installation in bare React Native projects

For bare React Native projects, you must ensure that you have [installed and configured the `expo` package](https://docs.expo.dev/bare/installing-expo-modules/) before continuing.
then do 
```
npm install expo-squircle-view
```
then do `npx pod-install`


# Running Example
<p align="center">
<img width="300" src="https://github.com/Malaa-tech/expo-squircle-view/assets/24798045/4157ad73-cf18-45ea-b130-379bd33635f0">
</p>


### Props (All props are optional)

<table>
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Explanation</th>
    <th>Default Value</th>
  </td>
  <tr>
    <td><code>cornerSmoothing</code></td>
    <td><code>number</code></td>
    <td>Controls the amount of smoothing for the radius, <code>0</code> means there is no smoothing (will render like any other <code>View</code>, 100 is maximum amount</td>
    <td><code>100</code></td>
  </tr>
  <tr>
    <td><code>preserveSmoothing</code></td>
    <td><code>boolean</code></td>
    <td>Setting this value to <code>false</code> the produced squircle will match the figma shape exactly, setting this to <code>false</code> will give you even more smoothing for higher <code>borderRadius</code> values</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>borderRadius</code> or <code>style.borderRadius</code></td>
    <td><code>number</code></td>
    <td>The component's border radius, you can either set it directly or set it from borderRadius like any other view</td>
    <td><code>0</code></td>
  </tr>
   <tr>
    <td><code>backgroundColor</code> or <code>style.backgroundColor</code></td>
    <td><code>ColorValue</code></td>
    <td>The background color of the component, you can either set it directly or set it from style.backgroundColor like any other view</td>
    <td><code>transperent</code></td>
  </tr>
   <tr>
    <td><code>borderColor</code> or <code>style.borderColor</code></td>
    <td><code>ColorValue</code></td>
    <td>Since borders has to match the squircle, you can either set it directly or set it from style.borderColor like any other view</td>
    <td><code>transperent</code></td>
  </tr>
   <tr>
    <td><code>borderWidth</code> or <code>style.borderWidth</code></td>
    <td><code>number</code></td>
    <td>Since borders has to match the squircle, you can either set it directly or set it from style.borderWith like any other view</td>
    <td><code>0</code></td>
  </tr>
   <tr>
    <td><code>ignoreBorderWidthFromPadding</code></td>
    <td><code>boolean<ViewStyle></code></td>
    <td>We introduced a breaking change in 0.6.0, if you want your styles to work the same as pre 0.6, enable this. when value is `false` the style will match react-native View behavior, when `true` it will ignore border width from affecting the padding of the content</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>style</code></td>
    <td><code>StyleProp<ViewStyle></code></td>
    <td>Default style prop for the component, like any other view</td>
    <td><code>undefined</code></td>
  </tr>
</table>


### Basic Example 

```tsx | pure
import { Text, View } from "react-native";
import { SquircleView } from "expo-squircle-view";

export default function App() {
  return (
    <View
      style={{
        alignItems: "center",
        justifyContent: "center",
        flex: 1,
      }}
    >
      <SquircleView
        cornerSmoothing={100} // 0-100
        preserveSmoothing={true} // false matches figma, true has more rounding
        style={{
          width: 200,
          height: 100,
          flexDirection: "row",
          justifyContent: "center",
          alignItems: "center",
          backgroundColor: "pink",
          borderRadius: 40,
          borderColor: "gray",
          borderWith: 4
        }}
      >
        <Text>Squircle</Text>
      </SquircleView>
    </View>
  );
}
```

### Using as a Button

import SquircleButton instead of SquircleView, and use it the same way as a TouchableOpacity

```tsx | pure
import { SquircleButton } from "expo-squircle-view"; 

...
  <SquircleButton>
  ...
  </SquircleButton>
...

```

### Kudos
Libraries that made this possible

https://github.com/phamfoo/figma-squircle

https://github.com/phamfoo/react-native-figma-squircle

https://github.com/samuel-rl/react-native-squircle


Blog from figma team explaining squircle

https://www.figma.com/blog/desperately-seeking-squircles/


