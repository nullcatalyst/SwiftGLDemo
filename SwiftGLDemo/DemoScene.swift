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
    
    init() {
        // Load the Shader files
        shader.load("DemoShader1.vsh", fragmentFile: "DemoShader1.fsh")
        
        // Bind the vertices into the Vertex Buffer Object (VBO)
        vbo.bind([
            Vec2(x: -0.5, y: -0.5),
            Vec2(x:  0.5, y: -0.5),
            Vec2(x: -0.5, y:  0.5),
            Vec2(x:  0.5, y:  0.5),
        ], count: 4)
        
        // After binding some data to our VBO, we must bind our VBO's data
        // into our Vertex Array Object (VAO) using the associated Shader attributes
        var attribute = GLuint(shader.attribute("position"))
        vao.bindVec2(attribute, vbo: vbo, offset: 0)
    }
    
    func update() {
        
    }
    
    func render() {
        // Clear the screen to black before we draw anything
        glClearColor(0, 0, 0, 0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        // Bind the Shader we plan to use
        shader.bind()
        
        // Bind the VAO we plan to use
        vao.bind()
        
        // Finally submit what we are drawing to the GPU
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
    
    func resize(#width: CFloat, height: CFloat) {
        
    }
}
