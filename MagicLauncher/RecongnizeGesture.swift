//
//  RecongnizeGesture.swift
//  MagicLauncher
//
//  Created by Jaroslav Chaninovicz on 08/06/15.
//  Copyright (c) 2015 Jaroslav Chaninovicz. All rights reserved.
//

import Foundation
import UIKit
import GLKit

class RecongnizeGesture {
    let defaultPathSampleSize = 64
    let BoundingBoxSize : Float = 250
    let theta :Float = 0.7853981634
    let thetaThreshold : Float = 0.034906585
    
    func recognizeGesture(gesturePath: [CGPoint], definedGestures: [Gesture])->Gesture? {
        if definedGestures.count == 0 || gesturePath.count < 2 {
            return nil
        }
        
        var b: Float = MAXFLOAT
        var bestGesture : Gesture?
        
        var normalisedPath = normaliseGesturePath(gesturePath)
        
        for (var i = 0; i < definedGestures.count; i++) {
            var d = recognizerDistanceAtBestAngle(normalisedPath, definedGesturePath: definedGestures[i].path, radiansA: -theta, radiansB: theta, radiansDelta: thetaThreshold)

            if (d < b) {
                b = d;
                bestGesture = definedGestures[i]
            }
        }

        return bestGesture
    }
    
    func normaliseGesturePath(path: [CGPoint])->[CGPoint] {
        var resamplePath: [CGPoint] = recognizerResample(path, pathSize: defaultPathSampleSize)
        var scaledPath = recognizerScaleTo(resamplePath, size: BoundingBoxSize)
        var origin = GLKVector2Make(0, 0)
        var normalisedPath = recognizerTranslateTo(scaledPath, origin: origin)
        return normalisedPath
    }
    
    func recognizerDistanceAtBestAngle(path: [CGPoint], definedGesturePath: [CGPoint], radiansA : Float, radiansB : Float, radiansDelta: Float) -> Float{
        
        var radA = radiansA
        var radB = radiansB
        
        var phi : Float = 0
        if(phi == 0) {
            phi = 0.5 * (-1 + sqrtf(5))
        }
        
        var x1 = phi * radA + (1 - phi) * radB
        var f1 = recognizerDistanceAtAngle(path, gesture: definedGesturePath, radians: x1)
        var x2 = (1 - phi) * radA + phi * radB
        var f2 = recognizerDistanceAtAngle(path, gesture: definedGesturePath, radians: x2)
        
        
        while(fabsf(radB - radA) > radiansDelta) {
            if(f1 < f2) {
                radB = x2
                x2 = x1
                f2 = f1
                x1 = phi * radA + (1 - phi) * radB
                f1 = recognizerDistanceAtAngle(path, gesture: definedGesturePath, radians: x1)
            } else {
                radA = x1
                x1 = x2
                f1 = f2
                x2 = (1 - phi) * radA + phi * radB
                f2 = recognizerDistanceAtAngle(path, gesture: definedGesturePath, radians: x2)
            }
        }
        
        return fminf(f1,f2)
    }
    
    func recognizerDistanceAtAngle(path: [CGPoint], gesture: [CGPoint], radians : Float)->Float {
        var rotatedPath = recognizerRotateBy(path, radians: radians)
        if(rotatedPath.count == 0) {
            return MAXFLOAT
        }
        var d : Float = recognizerPathDistance(rotatedPath, pathB: gesture)
        return d
    }
    
    func recognizerPathDistance(pathA: [CGPoint], pathB: [CGPoint])->Float {
        
        var d : Float = 0
        if(pathA.count == pathB.count) {
            for(var i = 0; i < pathA.count; i++) {
                var pointA = GLKVector2Make(Float(pathA[i].x), Float(pathA[i].y))
                var pointB = GLKVector2Make(Float(pathB[i].x), Float(pathB[i].y))
                var distance: Float = GLKVector2Distance(pointA, pointB)
                if(!isnan(distance)) {
                    d += distance
                }
            }
        }

        return d / Float(pathA.count)
    }
    
    func recognizerRotateBy(path: [CGPoint], radians: Float)->[CGPoint] {
        var newPath = [CGPoint]()
        if(path.count > 0) {
            var centroid = recognizerCentroid(path)
            var cos : Float = cosf(radians)
            var sin: Float = sinf(radians)
            
            for(var i = 0; i < path.count; i++) {
                var point = GLKVector2Make(Float(path[i].x), Float(path[i].y))
                var x : Float = (point.x - centroid.x) * cos - (point.y - centroid.y) * sin + centroid.x
                var y : Float = (point.x - centroid.x) * sin + (point.y - centroid.y) * cos + centroid.y
                newPath.append(CGPoint(x: CGFloat(x), y: CGFloat(y)))
            }
        }
        
        return newPath
    }
    
    func recognizerTranslateTo(path: [CGPoint], origin: GLKVector2)->[CGPoint] {
        var centroid = recognizerCentroid(path)
        var translatedPath = [CGPoint]()
        
        for(var i = 0; i < path.count; i++) {
            var x = path[i].x
            var y = path[i].y
            var point = CGPoint(x: x + CGFloat(origin.x - centroid.x), y: y + CGFloat(origin.y - centroid.y))
            translatedPath.append(point)
        }
        return translatedPath
    }
    
    func recognizerCentroid(path: [CGPoint])->GLKVector2 {
        var sumX : Float = 0
        var sumY : Float = 0
        
        for(var i = 0; i < path.count; i++) {
            sumX += Float(path[i].x)
            sumY += Float(path[i].y)
        }
        
        return GLKVector2Make(sumX / Float(path.count), sumY / Float(path.count))
    }
    
    func recognizerScaleTo(path: [CGPoint], size: Float)->[CGPoint] {
        var resizedPath = [CGPoint]()
        var box = recognizerBoundingBox(path)
        
        for (var i = 0; i < path.count; i++) {
            var x = path[i].x
            var y = path[i].y
            var point = CGPoint(x: x * (CGFloat(size) / box.size.width), y: y * (CGFloat(size) / box.size.height))
            resizedPath.append(point)
        }
        return resizedPath
    }
    
    func recognizerBoundingBox(path: [CGPoint])->CGRect {
        
        var minX = MAXFLOAT
        var minY = MAXFLOAT
        var maxX = -MAXFLOAT
        var maxY = -MAXFLOAT
        
        for(var i = 0; i < path.count; i++) {
            if(Float(path[i].x) < minX) {
                minX = Float(path[i].x)
            }
            if(Float(path[i].x) > maxX) {
                maxX = Float(path[i].x)
            }
            if(Float(path[i].y) < minY) {
                minY = Float(path[i].y)
            }
            if(Float(path[i].y) > maxY) {
                maxY = Float(path[i].y)
            }
        }

        return CGRectMake(CGFloat(minX), CGFloat(minY), CGFloat(maxX - minX), CGFloat(maxY - minY))
    }
    
    
    func recognizerResample(path: [CGPoint], pathSize: Int)->[CGPoint] {
        var I : Float = recognizerPathLength(path) / Float(pathSize - 1)
        var D : Float = 0
        
        var newPath = [CGPoint]()
        
        if(path.count == 0) {
            return newPath
        }
        
        newPath.append(CGPoint(x: path[0].x, y: path[0].y))
        var i = 1
        
        var prevPoint = GLKVector2Make(Float(path[0].x), Float(path[0].y))
        var currentPoint = GLKVector2Make(Float(path[1].x), Float(path[1].y))
        while(i < path.count) {

            var d : Float = GLKVector2Distance(prevPoint, currentPoint)
            if(D + d >= I) {
                var x : Float = prevPoint.x + ((I - D) / d) * (currentPoint.x - prevPoint.x)
                var y : Float = prevPoint.y + ((I - D) / d) * (currentPoint.y - prevPoint.y)
                newPath.append(CGPoint(x: CGFloat(x), y: CGFloat(y)))
                prevPoint = GLKVector2Make(x, y)
                D = 0
            } else {
                D += d
                prevPoint = GLKVector2Make(Float(path[i - 1].x), Float(path[i - 1].y))
                currentPoint = GLKVector2Make(Float(path[i].x), Float(path[i].y))
                i++
            }
        }
        
        if(newPath.count == pathSize - 1) {
            newPath.append(CGPoint(x: path[path.count - 1].x, y: path[path.count - 1].y))
        }

        return newPath
    }
    
    func recognizerPathLength(path: [CGPoint])->Float {
        var d: Float = 0.0
        
        for(var i = 1; i < path.count; i++) {
            let vStart = GLKVector2Make(Float(path[i - 1].x), Float(path[i - 1].y))
            let vEnd = GLKVector2Make(Float(path[i].x), Float(path[i].y))
            d += GLKVector2Distance(vStart, vEnd)
        }

        return d
    }
}