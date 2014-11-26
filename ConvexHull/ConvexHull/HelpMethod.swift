//
//  HelpMethod.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/25.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa
import AppKit

protocol ChooseAlgorithm {
    var algorithmSelected:Algorithm {get set}
}

enum Algorithm {
    case BruteForceCH
    case GrahamScan
    case DivideAndConquer
}

func == (left: PointView, right: PointView) -> Bool {
    return left.position == right.position
}

func getAppDelegate() -> AppDelegate{
    return NSApplication.sharedApplication().delegate as AppDelegate
}

func calculatePoint(pointP:CGPoint,onLine line:(pointA:CGPoint,pointB:CGPoint)) -> CGFloat {
    println((pointP.y - line.pointA.y) * (line.pointB.x - line.pointA.x) - (line.pointB.y - line.pointA.y) * (pointP.x - line.pointA.x))
    return (pointP.y - line.pointA.y) * (line.pointB.x - line.pointA.x) - (line.pointB.y - line.pointA.y) * (pointP.x - line.pointA.x)
}

func checkPoint(P:CGPoint,inTriangle triangle:(A:CGPoint,B:CGPoint,C:CGPoint)) -> Bool {
    let AB = calculatePoint(P, onLine: (triangle.A,triangle.B)) == 0||calculatePoint(P, onLine: (triangle.A,triangle.B)) * calculatePoint(triangle.C, onLine: (triangle.A,triangle.B)) > 0
    let AC = calculatePoint(P, onLine: (triangle.A,triangle.C)) == 0||calculatePoint(P, onLine: (triangle.A,triangle.C)) * calculatePoint(triangle.B, onLine: (triangle.A,triangle.C)) > 0
    let BC = calculatePoint(P, onLine: (triangle.C,triangle.B)) == 0||calculatePoint(P, onLine: (triangle.C,triangle.B)) * calculatePoint(triangle.A, onLine: (triangle.C,triangle.B)) > 0
//    println("AB:\(AB)")
//    println("AC:\(AC)")
//    println("BC:\(BC)")
    return AB && AC && BC
}

func calculatePolarAngle(origin:CGPoint, target:CGPoint) -> Double{
    let trans = (x: target.x - origin.x, y: target.y - origin.y)
    let angle = atan(Double(trans.y) / Double(trans.x))
    switch trans {
    case let (x,y) where x >= 0 && y >= 0:
        return angle
    case let (x,y) where x < 0 && y >= 0:
        return angle + M_PI
    case let (x,y) where x <= 0 && y < 0:
        return angle + M_PI
    case let (x,y) where x > 0 && y < 0:
        return angle + 2 * M_PI
    default:
        return 0
    }
}