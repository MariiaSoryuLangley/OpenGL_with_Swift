
import UIKit
import GLKit

extension  Array {
   func  size () -> Int {
     return  MemoryLayout < Element > .stride *  self .count
  }
}

class CubeView: GLKViewController, GLKViewControllerDelegate {
 
    private var rotation: Float = 1.0
    
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        let aspect = fabsf(Float(view.bounds.size.width) / Float(view.bounds.size.height))
        let projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), aspect, 4.0, 10.0)
      
        effect.transform.projectionMatrix = projectionMatrix
        var modelViewMatrix = GLKMatrix4MakeTranslation(0.0, 0.0, -6.0)
        rotation += 45 * Float(timeSinceLastUpdate)
        modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(rotation), 1, 1, 1)//вращаем фигуру, 0, 0, 0 - квадрата нет; 0, 0, 1 - вращается вокруг центра; 0, 1, 1 - вращается хз как, но не так; 1, 1, 1 - вращается хз как, но не так; 1, 0, 1 - вращается хз как, но не так
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
        
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
    
        glEnable(GLenum(GL_DEPTH_TEST))
        glEnable(GLenum(GL_CULL_FACE))
        
        effect.prepareToDraw()
        
        glBindVertexArrayOES(vao);
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 12*3)
        glBindVertexArrayOES(0)

    }
    var Vertices = [
        Vertex(x: -1, y: -1, z: -1, r: 0.583, g: 0.871, b: 0.015, a: 1),//0
        Vertex(x: -1, y: -1, z: 1, r: 0.409, g:  0.115, b: 0.436, a: 1),//1
        Vertex(x: -1, y: 1, z: 1, r: 0.127, g: 0.483, b: 0.844, a: 1),//2
        Vertex(x: 1, y: 1, z: -1, r: 0.822, g: 0.059, b: 0.201, a: 1),//3
        Vertex(x: -1, y: -1, z: -1, r: 0.435, g: 0.602, b: 0.223, a: 1),//4
        Vertex(x: -1, y: 1, z: -1, r: 0.310, g: 0.747, b: 0.185, a: 1),//5
        Vertex(x: 1, y: -1, z: 1, r: 0.597, g: 0.770, b: 0.761, a: 1),//0
        Vertex(x: -1, y: -1, z: -1, r: 0.559, g: 0.436, b: 0.730, a: 1),//1
        Vertex(x: 1, y: -1, z: -1, r: 0.359, g: 0.583, b: 0.152, a: 1),//2
        Vertex(x: 1, y: 1, z: -1, r: 0.483, g: 0.596, b: 0.789, a: 1),//3
        Vertex(x: 1, y: -1, z: -1, r: 0.559, g: 0.861, b: 0.639, a: 1),//4
        Vertex(x: -1, y: -1, z: -1, r: 0.195, g: 0.548, b: 0.859, a: 1),//5
        Vertex(x: -1, y: -1, z: -1, r: 0.014, g: 0.184, b: 0.576, a: 1),//0
        Vertex(x: -1, y: 1, z: 1, r: 0.771, g: 0.328, b: 0.970, a: 1),//1
        Vertex(x: -1, y: 1, z: -1, r: 0.406, g: 0.615, b: 0.116, a: 1),//2
        Vertex(x: 1, y: -1, z: 1, r: 0.676, g: 0.971, b: 0.133, a: 1),//3
        Vertex(x: -1, y: -1, z: 1, r: 0.971, g: 0.572, b: 0.833, a: 1),//4
        Vertex(x: -1, y: -1, z: -1, r: 0.140, g: 0.616, b: 0.489, a: 1),//5
        Vertex(x: -1, y: 1, z: 1, r: 0.997, g: 0.513, b: 0.064, a: 1),//0
        Vertex(x: -1, y: -1, z: 1, r: 0.945, g: 0.719, b: 0.592, a: 1),//1
        Vertex(x: 1, y: -1, z: 1, r: 0.543, g: 0.021, b: 0.978, a: 1),//2
        Vertex(x: 1, y: 1, z: 1, r: 0.279, g: 0.317, b: 0.505, a: 1),//3
        Vertex(x: 1, y: -1, z: -1, r: 0.167, g: 0.620, b: 0.077, a: 1),//4
        Vertex(x: 1, y: 1, z: -1, r: 0.347, g: 0.857, b: 0.137, a: 1),//5
        Vertex(x: 1, y: -1, z: -1, r: 0.055, g: 0.953, b: 0.042, a: 1),//0
        Vertex(x: 1, y: 1, z: 1, r: 0.714, g: 0.505, b: 0.345, a: 1),//1
        Vertex(x: 1, y: -1, z: 1, r: 0.783, g: 0.290, b: 0.734, a: 1),//2
        Vertex(x: 1, y: 1, z: 1, r: 0.722, g: 0.645, b: 0.174, a: 1),//3
        Vertex(x: 1, y: 1, z: -1, r: 0.302, g: 0.455, b: 0.848, a: 1),//4
        Vertex(x: -1, y: 1, z: -1, r: 0.225, g: 0.587, b: 0.040, a: 1),//5
        Vertex(x: 1, y: 1, z: 1, r: 0.217, g: 0.713, b: 0.338, a: 1),//0
        Vertex(x: -1, y: 1, z: -1, r: 0.053, g: 0.959, b: 0.120, a: 1),//1
        Vertex(x: -1, y: 1, z: 1, r: 0.393, g: 0.621, b: 0.362, a: 1),//2
        Vertex(x: 1, y: 1, z: 1, r: 0.603, g: 0.211, b: 0.457, a: 1),//3
        Vertex(x: -1, y: 1, z: 1, r: 0.820, g: 0.883, b: 0.371, a: 1),//4
        Vertex(x: 1, y: -1, z: 1, r: 0.082, g: 0.099, b: 0.879, a: 1),//5
    ]

    var ​Indices: [GLbyte] = [
        0, 1, 2,
        2, 3, 0,
        0, 3, 4,
        2, 3, 5,
        5, 6, 7,
        8, 9, 10,
        11, 12, 13
        
    ]
    override func viewDidLoad() {
      super.viewDidLoad()
      setupGL()
        
    }
    
    deinit {
      tearDownGL()
    }

}

