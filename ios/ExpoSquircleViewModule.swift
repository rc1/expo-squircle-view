import ExpoModulesCore

public class ExpoSquircleViewModule: Module {
    public func definition() -> ModuleDefinition {
        Name("ExpoSquircleView")
        
        View(ExpoSquircleView.self) { 
            Prop("squircleBackgroundColor") { (view: ExpoSquircleView, prop: UIColor) in
                view.setBackgroundColor(prop)
            }
            Prop("squircleBorderColor") { (view: ExpoSquircleView, prop: UIColor) in
                view.setBorderColor(prop)
            }
            Prop("squircleBorderWidth") { (view: ExpoSquircleView, prop: Float) in
                view.setBorderWidth(CGFloat(prop))
            }
            Prop("borderRadius") { (view: ExpoSquircleView, prop: Float) in
                view.setRadius(CGFloat(prop))
            }
            Prop("borderTopLeftRadius") { (view: ExpoSquircleView, prop: Float) in
                view.setTopLeftRadius(CGFloat(prop))
            }
            Prop("borderTopRightRadius") { (view: ExpoSquircleView, prop: Float) in
                view.setTopRightRadius(CGFloat(prop))
            }
            Prop("borderBottomLeftRadius") { (view: ExpoSquircleView, prop: Float) in
                view.setBottomLeftRadius(CGFloat(prop))
            }
            Prop("borderBottomRightRadius") { (view: ExpoSquircleView, prop: Float) in
                view.setBottomRightRadius(CGFloat(prop))
            }
            Prop("cornerSmoothing") { (view: ExpoSquircleView, prop: Int) in
                view.setCornerSmoothing(CGFloat(prop))
            }
            Prop("preserveSmoothing") { (view: ExpoSquircleView, prop: Bool) in
                view.setPreserveSmoothing(prop)
            }
            Prop("enabledIOSAnimation") { (view: ExpoSquircleView, prop: Bool) in
                view.isAnimationEnabled = prop
            }
        }
    }
}
