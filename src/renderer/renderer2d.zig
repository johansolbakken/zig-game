const VertexArray = @import("vertexarray.zig").VertexArray;
const VertexBuffer = @import("vertexbuffer.zig").VertexBuffer;
const IndexBuffer = @import("indexbuffer.zig").IndexBuffer;
const Shader = @import("shader.zig").Shader;
const RenderCommand = @import("rendercommand.zig");

const opengl = @import("../platform/opengl/opengl.zig");
const std = @import("std");

const colorVert = @embedFile("../shaders/color.vert");
const colorFrag = @embedFile("../shaders/color.frag");

const RendererData = struct {
    const Self = @This();

    va: VertexArray,
    vb: VertexBuffer,
    ib: IndexBuffer,
    shader: Shader,

    fn init() Self {
        const vertices = [_]f32{
            0.5, 0.5, 0.0, // top right
            0.5, -0.5, 0.0, // bottom right
            -0.5, -0.5, 0.0, // bottom left
            -0.5, 0.5, 0.0, // top left
        };
        const indices = [_]u32{
            0, 1, 3,
            1, 2, 3,
        };

        var va = try VertexArray.init();
        va.bind();

        var vb = try VertexBuffer.init(&vertices, 3 * 4 * @sizeOf(f32));
        vb.bind();

        var ib = try IndexBuffer.init(&indices, 6);
        ib.bind();

        opengl.enableVertexAttribArray(0);
        opengl.vertexAttribPointer(0, 3, opengl.GLType.Float, false, 3 * @sizeOf(f32), 0);

        const shader = try Shader.init(colorVert, colorFrag);
        return .{
            .va = va,
            .vb = vb,
            .ib = ib,
            .shader = shader,
        };
    }

    fn deinit(self: *Self) void {
        self.shader.deinit();
        self.ib.deinit();
        self.vb.deinit();
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

    RenderCommand.drawIndexed(&rendererData.va, rendererData.ib.getCount());
}
