//
//  CatView.swift

//import UIKit
import GLKit


class CatView: GLKViewController, GLKViewControllerDelegate {
 
    private var rotation: Float = 1.0
    
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        let aspect = fabsf(Float(view.bounds.size.width) / Float(view.bounds.size.height))
        let projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), aspect, 4.0, 10.0)
      
        effect.transform.projectionMatrix = projectionMatrix
        var modelViewMatrix = GLKMatrix4MakeTranslation(0.0, 0.0, -6.0)
        rotation += 90 * Float(timeSinceLastUpdate)
        //modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(rotation), 0, 0, 1) 
        effect.transform.modelviewMatrix = modelViewMatrix

    }
    
    private var context: EAGLContext?
    private var ebo = GLuint()
    private var vbo = GLuint()
    private var vao = GLuint()
    private var effect = GLKBaseEffect()


    
    private func setupGL(){
        context = EAGLContext(api: .openGLES3)
        EAGLContext.setCurrent(context)
        
        if let view = self.view as? GLKView, let context = context{
            
            view.context = context
            delegate = self
        }
        let vertexAttribColor = GLuint(GLKVertexAttrib.color.rawValue)
       
        let vertexAttribPosition = GLuint(GLKVertexAttrib.position.rawValue)
      
        let vertexSize = MemoryLayout<Vertex>.stride
  
        let colorOffset = MemoryLayout<GLfloat>.stride * 3
    
        let colorOffsetPointer = UnsafeRawPointer(bitPattern: colorOffset)
        //VAO
        glGenVertexArraysOES(1, &vao)
        glBindVertexArrayOES(vao)
        //VBO
        glGenBuffers(1, &vbo)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vbo)
        glBufferData(GLenum(GL_ARRAY_BUFFER), Vertices.size(), Vertices, GLenum(GL_STATIC_DRAW))
        glEnableVertexAttribArray(vertexAttribPosition)
        glVertexAttribPointer(vertexAttribPosition, 3, GLenum(GL_FLOAT), GLboolean(UInt8(GL_FALSE)), GLsizei(vertexSize), nil)
            
        glEnableVertexAttribArray(vertexAttribColor)
        glVertexAttribPointer(vertexAttribColor, 4, GLenum(GL_FLOAT), GLboolean(UInt8(GL_FALSE)), GLsizei(vertexSize), colorOffsetPointer)
        //EBO
        glGenBuffers(1, &ebo)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), ebo)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), ​Indices.size(), ​Indices, GLenum(GL_STATIC_DRAW))
        glBindVertexArrayOES(0)
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)


    }
    // cleane up
    private func tearDownGL() {
      EAGLContext.setCurrent(context)
        
      glDeleteBuffers(1, &vao)
      glDeleteBuffers(1, &vbo)
      glDeleteBuffers(1, &ebo)
            
      EAGLContext.setCurrent(nil)
            
      context = nil
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.5, 0.5, 0.85, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        effect.prepareToDraw()
        
        glBindVertexArrayOES(vao);
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(​Indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
        glBindVertexArrayOES(0)

    }
    var Vertices = [
        Vertex(x:   0,  y: 0.65, z: 0, r: 0.85, g: 0.10, b: 0.05, a: 1),//0 main
        Vertex(x:  -0.85,y: 1.5, z: 0, r: 0.85, g: 0.10, b: 0.05, a: 1),//1
        Vertex(x:  0.85, y: 1.5, z: 0, r: 0.85, g: 0.10, b: 0.05, a: 1),//2
        Vertex(x: -0.55,y: 2, z: 0, r: 0.85, g: 0.10, b: 0.05, a: 1),//3
        Vertex(x:  0.55,y: 2, z: 0, r: 0.85, g: 0.10, b: 0.05, a: 1),//4
        Vertex(x:   0,  y: 2, z: 0, r: 0, g: 0, b: 0, a: 1),//5
        Vertex(x: -0.85, y: 2.5,   z: 0, r: 0, g: 0, b: 0, a: 1),//6
        Vertex(x: 0.85,  y: 2.5,   z: 0, r: 0, g: 0, b: 0, a: 1),//7
        
        Vertex(x: 0, y: -0.55, z: 0, r: 0, g: 0, b: 0, a: 1),//8
        Vertex(x: -0.55, y: 1.2, z: 0, r: 0, g: 0, b: 0, a: 1),//9
        Vertex(x: 0.55, y: 1.2, z: 0, r: 0, g: 0, b: 0, a: 1),//10
        
        
        Vertex(x: 0.85, y: -0.55, z: 0, r: 0.85, g: 0.10, b: 0.05, a: 1),//11
        Vertex(x: 1, y: -0.1, z: 0, r: 0.85, g: 0.10, b: 0.05, a: 1),//12
        Vertex(x: 1.2, y: -1, z: 0, r: 0.85, g: 0.10, b: 0.05, a: 1),//13
        Vertex(x: 0.55, y: -1.25, z: 0, r: 0.85, g: 0.10, b: 0.05, a: 1),//14
    ]

    var ​Indices: [GLbyte] = [
        0, 1, 3,//ухо
        0, 2, 4,//верх морды
        0, 3, 5,//ухо
        0, 4, 5, //низ морды
        1, 3, 6, //нос
        2, 4, 7, //глаз левый
        8, 9, 0,//тело 1
        8, 10, 0, //тело 2
        8, 10, 11,//тело 3
        10, 11, 12,//тело 4
       12, 13, 14 //хвост
        
    ]
    override func viewDidLoad() {
      super.viewDidLoad()
      setupGL()
        
    }
    
    deinit {
      tearDownGL()
    }

}
