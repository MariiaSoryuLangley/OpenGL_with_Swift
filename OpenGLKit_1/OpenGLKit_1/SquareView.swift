
import UIKit
import GLKit


class SquareView: GLKViewController, GLKViewControllerDelegate {
    
    private var rotation: Float = 1.0
    
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        let aspect = fabsf(Float(view.bounds.size.width) / Float(view.bounds.size.height))
        let projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0), aspect, 4.0, 10.0)

        effect.transform.projectionMatrix = projectionMatrix
        var modelViewMatrix = GLKMatrix4MakeTranslation(0.0, 0.0, -6.0)
        rotation += 90 * Float(timeSinceLastUpdate)
        modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(rotation), 0, 0, 1)//вращаем фигуру, 0, 0, 0 - квадрата нет; 0, 0, 1 - вращается вокруг центра; 0, 1, 1 - вращается хз как, но не так; 1, 1, 1 - вращается хз как, но не так; 1, 0, 1 - вращается хз как, но не так
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
//          var colorRGB = 0.0
//            repeat {
//
//            }while //delegate != self
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
        glBufferData(GLenum(GL_ARRAY_BUFFER), Vertices_2.size(), Vertices_2, GLenum(GL_STATIC_DRAW))
        glEnableVertexAttribArray(vertexAttribPosition)
        glVertexAttribPointer(vertexAttribPosition, 3, GLenum(GL_FLOAT), GLboolean(UInt8(GL_FALSE)), GLsizei(vertexSize), nil)

        glEnableVertexAttribArray(vertexAttribColor)
        glVertexAttribPointer(vertexAttribColor, 4, GLenum(GL_FLOAT), GLboolean(UInt8(GL_FALSE)), GLsizei(vertexSize), colorOffsetPointer)
        //EBO
        glGenBuffers(1, &ebo)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), ebo)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), ​Indices_2.size(), ​Indices_2, GLenum(GL_STATIC_DRAW))
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
       // repeat{
        glClearColor(0.5, 0.5, 0.85, 1.0)
            glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
            
       // }while

        effect.prepareToDraw()

        glBindVertexArrayOES(vao);
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(​Indices_2.count), GLenum(GL_UNSIGNED_BYTE), nil)
        glBindVertexArrayOES(0)

    }
    var Vertices_2 = [
        Vertex(x:  1, y: -1, z: 0, r: 1, g: 0, b: 0, a: 1),
        Vertex(x:  1, y:  1, z: 0, r: 0, g: 1, b: 0, a: 1),
        Vertex(x: -1, y:  1, z: 0, r: 0, g: 0, b: 1, a: 1),
        Vertex(x: -1, y: -1, z: 0, r: 0, g: 0, b: 0, a: 1),

    ]

    var ​Indices_2: [GLbyte] = [
        0, 1, 2,
        2, 3, 0
    ]
    override func viewDidLoad() {
      super.viewDidLoad()
      setupGL()

    }

    deinit {
      tearDownGL()
    }
    @IBOutlet var Viewshka: GLKView!


}

