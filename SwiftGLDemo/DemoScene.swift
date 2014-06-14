//
//  DemoScene.swift
//  SwiftGLDemo
//
//  Created by Scott Bennett on 2014-06-09.
//  Copyright (c) 2014 Scott Bennett. All rights reserved.
//

import Foundation

/// IMPORTANT: The SwiftGL framework must be imported to be able to use it
import SwiftGL

class DemoScene: Scene {
    let shader = Shader()
    let vao    = Vao()
    let vbo    = Vbo()
    let ibo    = Vbo()
    var modelview  = Mat4.identity()
    var projection = Mat4.identity()
    
    init() {
        // Load the Shader files
        shader.load("DemoShader1.vsh", fragmentFile: "DemoShader1.fsh") {
            program in
            // Here we will bind the attibute names to the correct position
            // Doing this will allow us to use the VBO/VAO with more than one shader, ensuring that the right
            // values get passed in to the correct shader variables
            glBindAttribLocation(program, 0, "position")
            glBindAttribLocation(program, 1, "color")
        }
        
        // Bind the vertices into the Vertex Buffer Object (VBO)
        vbo.bind([
            Vertex(position: Vec4(x: -0.5, y: -0.5, z: 0.5), color: Vec4(x: 1, y: 1, z: 0, w: 1)),
            Vertex(position: Vec4(x:  0.5, y: -0.5, z: 0.5), color: Vec4(x: 1, y: 1, z: 0, w: 1)),
            Vertex(position: Vec4(x: -0.5, y:  0.5, z: 0.5), color: Vec4(x: 1, y: 1, z: 0, w: 1)),
            Vertex(position: Vec4(x:  0.5, y:  0.5, z: 0.5), color: Vec4(x: 1, y: 1, z: 0, w: 1)),
            
            Vertex(position: Vec4(x:  0.5, y: -0.5, z: -0.5), color: Vec4(x: 1, y: 0, z: 0, w: 1)),
            Vertex(position: Vec4(x: -0.5, y: -0.5, z: -0.5), color: Vec4(x: 1, y: 0, z: 0, w: 1)),
            Vertex(position: Vec4(x:  0.5, y:  0.5, z: -0.5), color: Vec4(x: 1, y: 0, z: 0, w: 1)),
            Vertex(position: Vec4(x: -0.5, y:  0.5, z: -0.5), color: Vec4(x: 1, y: 0, z: 0, w: 1)),
            
            Vertex(position: Vec4(x: -0.5, y: -0.5, z: -0.5), color: Vec4(x: 0, y: 1, z: 0, w: 1)),
            Vertex(position: Vec4(x: -0.5, y: -0.5, z:  0.5), color: Vec4(x: 0, y: 1, z: 0, w: 1)),
            Vertex(position: Vec4(x: -0.5, y:  0.5, z: -0.5), color: Vec4(x: 0, y: 1, z: 0, w: 1)),
            Vertex(position: Vec4(x: -0.5, y:  0.5, z:  0.5), color: Vec4(x: 0, y: 1, z: 0, w: 1)),
            
            Vertex(position: Vec4(x:  0.5, y: -0.5, z:  0.5), color: Vec4(x: 0, y: 0, z: 1, w: 1)),
            Vertex(position: Vec4(x:  0.5, y: -0.5, z: -0.5), color: Vec4(x: 0, y: 0, z: 1, w: 1)),
            Vertex(position: Vec4(x:  0.5, y:  0.5, z:  0.5), color: Vec4(x: 0, y: 0, z: 1, w: 1)),
            Vertex(position: Vec4(x:  0.5, y:  0.5, z: -0.5), color: Vec4(x: 0, y: 0, z: 1, w: 1)),
            
            Vertex(position: Vec4(x: -0.5, y: -0.5, z: -0.5), color: Vec4(x: 1, y: 0, z: 1, w: 1)),
            Vertex(position: Vec4(x:  0.5, y: -0.5, z: -0.5), color: Vec4(x: 1, y: 0, z: 1, w: 1)),
            Vertex(position: Vec4(x: -0.5, y: -0.5, z:  0.5), color: Vec4(x: 1, y: 0, z: 1, w: 1)),
            Vertex(position: Vec4(x:  0.5, y: -0.5, z:  0.5), color: Vec4(x: 1, y: 0, z: 1, w: 1)),
            
            Vertex(position: Vec4(x: -0.5, y:  0.5, z:  0.5), color: Vec4(x: 1, y: 1, z: 1, w: 1)),
            Vertex(position: Vec4(x:  0.5, y:  0.5, z:  0.5), color: Vec4(x: 1, y: 1, z: 1, w: 1)),
            Vertex(position: Vec4(x: -0.5, y:  0.5, z: -0.5), color: Vec4(x: 1, y: 1, z: 1, w: 1)),
            Vertex(position: Vec4(x:  0.5, y:  0.5, z: -0.5), color: Vec4(x: 1, y: 1, z: 1, w: 1)),
        ], count: 24)
        
        var elements: CConstPointer<GLushort> = [
            0, 1, 2, 3,
            3, 4,
            4, 5, 6, 7,
            7, 8,
            8, 9, 10, 11,
            11, 12,
            12, 13, 14, 15,
            15, 16,
            16, 17, 18, 19,
            19, 20,
            20, 21, 22, 23,
        ]
        
        ibo.bindElements(elements, count: 34)
        
        // After binding some data to our VBO, we must bind our VBO's data
        // into our Vertex Array Object (VAO) using the associated Shader attributes
        vao.bind(attribute: 0, type: Vec4.self, vbo: vbo, offset: 0)
        vao.bind(attribute: 1, type: Vec4.self, vbo: vbo, offset: sizeof(Vec4))
        vao.bindElements(ibo)
    }
    
    func update() {
        // Rotate the matrix by 1 deg each frame (1 full rotation should take 6 seconds)
        modelview = modelview * Mat4.rotateZ(radians(0.25))
        modelview = modelview * Mat4.rotateY(radians(0.50))
        modelview = modelview * Mat4.rotateX(radians(0.75))
    }
    
    func render() {
        glDepthFunc(GLenum(GL_LESS))
        glEnable(GLenum(GL_DEPTH_TEST))
        
        // Clear the screen to black before we draw anything
        glClearColor(0, 0, 0, 0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        
        // Bind the Shader we plan to use
        shader.bind()
        
        // Bind the updated matrix
        shader.bind(uniform: "matrix", m: projection * Mat4.translate(x: 0, y: 0, z: -5) * modelview)
        
        // Bind the VAO we plan to use
        vao.bind()
        
        // Finally submit what we are drawing to the GPU
        glDrawElements(GLenum(GL_TRIANGLE_STRIP), 34, GLenum(GL_UNSIGNED_SHORT), nil)
    }
    
    func resize(#width: CFloat, height: CFloat) {
        projection = Mat4.perspective(fovy: radians(45), width: width, height: height, near: 1, far: 9)
    }
}
