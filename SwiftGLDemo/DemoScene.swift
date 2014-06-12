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
    var matrix = Mat4.identity()
    
    init() {
        // Load the Shader files
        shader.load("DemoShader1.vsh", fragmentFile: "DemoShader1.fsh")
        
        // Bind the vertices into the Vertex Buffer Object (VBO)
        vbo.bind([
            Vertex(position: Vec4(x: -0.5, y: -0.5), color: Vec4(x: 1, y: 0, z: 0, w: 1)),
            Vertex(position: Vec4(x:  0.5, y: -0.5), color: Vec4(x: 0, y: 1, z: 0, w: 1)),
            Vertex(position: Vec4(x: -0.5, y:  0.5), color: Vec4(x: 0, y: 0, z: 1, w: 1)),
            Vertex(position: Vec4(x:  0.5, y:  0.5), color: Vec4(x: 1, y: 1, z: 1, w: 1)),
        ], count: 4)
        
        // After binding some data to our VBO, we must bind our VBO's data
        // into our Vertex Array Object (VAO) using the associated Shader attributes
        var positionAttrib = GLuint(shader.attribute("position"))
        var colorAttrib    = GLuint(shader.attribute("color"))
        vao.bindVec4(positionAttrib, vbo: vbo, offset: 0)
        vao.bindVec4(colorAttrib,    vbo: vbo, offset: sizeof(Vec4))
    }
    
    func update() {
        // Rotate the matrix by 1 deg each frame (1 full rotation should take 6 seconds)
        matrix = matrix * Mat4.rotateZ(radians(1))
    }
    
    func render() {
        // Clear the screen to black before we draw anything
        glClearColor(0, 0, 0, 0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        // Bind the Shader we plan to use
        shader.bind()
        
        // Bind the updated matrix
        shader.bind(uniform: "matrix", m: matrix)
        
        // Bind the VAO we plan to use
        vao.bind()
        
        // Finally submit what we are drawing to the GPU
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func resize(#width: CFloat, height: CFloat) {
        
    }
}
