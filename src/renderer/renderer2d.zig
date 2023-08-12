const VertexArray = @import("vertexarray.zig").VertexArray;
const VertexBuffer = @import("vertexbuffer.zig").VertexBuffer;
const BufferLayout = @import("vertexbuffer.zig").BufferLayout;
const BufferElement = @import("vertexbuffer.zig").BufferElement;
const ShaderDataType = @import("vertexbuffer.zig").ShaderDataType;
const IndexBuffer = @import("indexbuffer.zig").IndexBuffer;
const Shader = @import("shader.zig").Shader;
const RenderCommand = @import("rendercommand.zig");

const colorVert = @embedFile("../shaders/color.vert");
const colorFrag = @embedFile("../shaders/color.frag");

const RendererData = struct {
    const Self = @This();

    va: VertexArray,
    shader: Shader,

    fn init() Self {
        var va = try VertexArray.init();
        va.bind();

        var vb = try VertexBuffer.init(&[_]f32{
            0.5, 0.5, 0.0, // top right
            0.5, -0.5, 0.0, // bottom right
            -0.5, -0.5, 0.0, // bottom left
            -0.5, 0.5, 0.0, // top left
        }, 3 * 4 * @sizeOf(f32));
        vb.setLayout(BufferLayout.init(@constCast(&[_]BufferElement{
            .{
                .dataType = ShaderDataType.Float3,
                .name = "a_Position",
            },
        })));
        va.addVertexBuffer(vb);

        var ib = try IndexBuffer.init(&[_]u32{
            0, 1, 3,
            1, 2, 3,
        }, 6);
        va.setIndexBuffer(ib);

        const shader = try Shader.init(colorVert, colorFrag);

        return .{
            .va = va,
            .shader = shader,
        };
    }

    fn deinit(self: *Self) void {
        self.shader.deinit();
        self.va.deinit();
    }
};

var rendererData: RendererData = undefined;

pub fn init() !void {
    rendererData = RendererData.init();
}

pub fn deinit() void {
    rendererData.deinit();
}

pub fn drawQuad(
    position: @Vector(3, f32),
    size: @Vector(2, f32),
    color: @Vector(3, f32),
) void {
    _ = color;
    _ = size;
    _ = position;
    rendererData.va.bind();
    rendererData.shader.bind();

    //rendererData.shader.setUniformVec3("u_Color", color);

    RenderCommand.drawIndexed(&rendererData.va);
}
