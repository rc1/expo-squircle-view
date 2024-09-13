//
//  SquirclePath.swift
//  ExpoSquircleView
//
//  Created by Wadah Esam on 18/01/2024.
//

import Foundation
import PocketSVG

struct CurveProperties {
    var a: CGFloat
    var b: CGFloat
    var c: CGFloat
    var d: CGFloat
    var p: CGFloat
    var arcSectionLength: CGFloat
    var cornerRadius: CGFloat
}

struct SquirclePath {
    
    static func create(width: CGFloat, height: CGFloat, topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomRightRadius: CGFloat, bottomLeftRadius: CGFloat, cornerSmoothing: CGFloat, preserveSmoothing: Bool) -> CGPath {
        
        let topLeftCurveProperties = createCurveProperties(width: width, height: height, radius: topLeftRadius, cornerSmoothing: cornerSmoothing, preserveSmoothing: preserveSmoothing)
        let topRightCurveProperties = createCurveProperties(width: width, height: height, radius: topRightRadius, cornerSmoothing: cornerSmoothing, preserveSmoothing: preserveSmoothing)
        let bottomRightCurveProperties = createCurveProperties(width: width, height: height, radius: bottomRightRadius, cornerSmoothing: cornerSmoothing, preserveSmoothing: preserveSmoothing)
        let bottomLeftCurveProperties = createCurveProperties(width: width, height: height, radius: bottomLeftRadius, cornerSmoothing: cornerSmoothing, preserveSmoothing: preserveSmoothing)
       
        let stringPath = getSVGPathFromPathParams(width: width, height: height, topLeftCurveProperties: topLeftCurveProperties, topRightCurveProperties: topRightCurveProperties, bottomRightCurveProperties: bottomRightCurveProperties, bottomLeftCurveProperties: bottomLeftCurveProperties);
        let svgString = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 \(height) \(width)'><path d='\(stringPath)'/></svg>"
        let paths = SVGBezierPath.paths(fromSVGString: svgString)
        return paths[0].cgPath
    }
    
    static func createCurveProperties (width:CGFloat, height:CGFloat, radius:CGFloat, cornerSmoothing:CGFloat, preserveSmoothing: Bool) -> CurveProperties {
        let checkedRadius = min(radius, width  / 2, height / 2)
        let checkedCornerSmoothing =  max(min(cornerSmoothing / 100, 1), 0)
        
        let curveProperties = calculateCurveProperties(cornerRadius: checkedRadius, cornerSmoothing: checkedCornerSmoothing, preserveSmoothing: preserveSmoothing, roundingAndSmoothingBudget: min(width , height) / 2)
        
        return curveProperties;
    }
    
    static func getSVGPathFromPathParams(width: CGFloat, height: CGFloat, topLeftCurveProperties: CurveProperties, topRightCurveProperties: CurveProperties, bottomRightCurveProperties: CurveProperties, bottomLeftCurveProperties: CurveProperties) -> String {
        let pathString = """
            M \(width - topRightCurveProperties.p) 0
            \(SquirclePath.getTopRightPath(curveProperties: topRightCurveProperties))
            L \(width) \(height - bottomRightCurveProperties.p)
            \(SquirclePath.getBottomRightPath(curveProperties: bottomRightCurveProperties))
            L \(bottomLeftCurveProperties.p) \(height)
            \(SquirclePath.getBottomLeftPath(curveProperties: bottomLeftCurveProperties))
            L 0 \(topLeftCurveProperties.p)
            \(SquirclePath.getTopLeftPath(curveProperties: topLeftCurveProperties))
            Z
            """
        
        return pathString.replacingOccurrences(of: "[\\t\\s\\n]+", with: " ", options: .regularExpression).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func getTopLeftPath(curveProperties: CurveProperties) -> String {
        if (curveProperties.cornerRadius >= 0) {
            return """
            c 0 \(-curveProperties.a) 0 \(-(curveProperties.a + curveProperties.b)) \(curveProperties.d) \(-(curveProperties.a + curveProperties.b + curveProperties.c))
            a \(curveProperties.cornerRadius) \(curveProperties.cornerRadius) 0 0 1 \(curveProperties.arcSectionLength) -\(curveProperties.arcSectionLength)
            c \(curveProperties.c) \(-curveProperties.d)  \(curveProperties.b + curveProperties.c) \(-curveProperties.d) \(curveProperties.a + curveProperties.b + curveProperties.c) \(-curveProperties.d)
            """;
        }
        return "";
    }
    
    static func getBottomLeftPath(curveProperties: CurveProperties) -> String {
        if (curveProperties.cornerRadius >= 0) {
            return """
            c \(-curveProperties.a) 0 \(-(curveProperties.a + curveProperties.b)) 0 \(-(curveProperties.a + curveProperties.b + curveProperties.c)) \(-curveProperties.d)
            a \(curveProperties.cornerRadius) \(curveProperties.cornerRadius) 0 0 1 -\(curveProperties.arcSectionLength) -\(curveProperties.arcSectionLength)
            c \(-curveProperties.d) \(-curveProperties.c) \(-curveProperties.d) \(-(curveProperties.b + curveProperties.c)) \(-curveProperties.d) \(-(curveProperties.a + curveProperties.b + curveProperties.c))
            """;
        }
        return "";
    }
    
    static func getBottomRightPath(curveProperties: CurveProperties) -> String {
        if (curveProperties.cornerRadius >= 0) {
            return """
            c 0 \(curveProperties.a) 0 \(curveProperties.a + curveProperties.b) \(-curveProperties.d) \(curveProperties.a + curveProperties.b + curveProperties.c)
            a \(curveProperties.cornerRadius) \(curveProperties.cornerRadius) 0 0 1 -\(curveProperties.arcSectionLength) \(curveProperties.arcSectionLength)
            c \(-curveProperties.c) \(curveProperties.d) \(-(curveProperties.b + curveProperties.c)) \(curveProperties.d) \(-(curveProperties.a + curveProperties.b + curveProperties.c)) \(curveProperties.d)
            """;
        }
        return "";
    }
    
    static func getTopRightPath(curveProperties: CurveProperties) -> String {
        if (curveProperties.cornerRadius >= 0) {
            return """
            c \(curveProperties.a) 0 \(curveProperties.a + curveProperties.b) 0 \(curveProperties.a + curveProperties.b + curveProperties.c) \(curveProperties.d)
            a \(curveProperties.cornerRadius) \(curveProperties.cornerRadius) 0 0 1 \(curveProperties.arcSectionLength) \(curveProperties.arcSectionLength)
            c \(curveProperties.d) \(curveProperties.c) \(curveProperties.d) \(curveProperties.c + curveProperties.d) \(curveProperties.d) \(curveProperties.a + curveProperties.b + curveProperties.c)
            """;
        }
        return "";
    }
    
    
    static func calculateCurveProperties(cornerRadius: CGFloat, cornerSmoothing: CGFloat, preserveSmoothing: Bool, roundingAndSmoothingBudget: CGFloat) -> CurveProperties {
        var p = (1 + cornerSmoothing) * cornerRadius
        var cornerSmoothing = cornerSmoothing
        
        if !preserveSmoothing {
            let maxCornerSmoothing = roundingAndSmoothingBudget / cornerRadius - 1
            cornerSmoothing = min(cornerSmoothing, maxCornerSmoothing)
            p = min(p, roundingAndSmoothingBudget)
        }
        
        let arcMeasure = 90 * (1 - cornerSmoothing)
        let arcSectionLength = sin(toRadians(arcMeasure / 2)) * cornerRadius * sqrt(2)
        let angleAlpha = (90 - arcMeasure) / 2
        let p3ToP4Distance = cornerRadius * tan(toRadians(angleAlpha / 2))
        let angleBeta = 45 * cornerSmoothing
        let c = p3ToP4Distance * cos(toRadians(angleBeta))
        let d = c * tan(toRadians(angleBeta))
        var b = (p - arcSectionLength - c - d) / 3
        var a = 2 * b
        
        if preserveSmoothing && p > roundingAndSmoothingBudget {
            let p1ToP3MaxDistance = roundingAndSmoothingBudget - d - arcSectionLength - c
            let minA = p1ToP3MaxDistance / 6
            let maxB = p1ToP3MaxDistance - minA
            b = min(b, maxB)
            a = p1ToP3MaxDistance - b
            p = min(p, roundingAndSmoothingBudget)
        }
        
        return CurveProperties(a: a, b: b, c: c, d: d, p: p, arcSectionLength: arcSectionLength, cornerRadius: cornerRadius)
    }
    
    static func toRadians(_ degrees: CGFloat) -> CGFloat {
        return degrees * .pi / 180
    }
}
