const opengl = @import("opengl.zig");
const std = @import("std");

const VertexBuffer = @import("../../renderer/vertexbuffer.zig").VertexBuffer;
const ShaderDataType = @import("../../renderer/vertexbuffer.zig").ShaderDataType;
const IndexBuffer = @import("../../renderer/indexbuffer.zig").IndexBuffer;

fn getOpenGLType(dataType: ShaderDataType) opengl.GLType {
    switch (dataType) {
        .Float => return opengl.GLType.Float,
        .Float2 => return opengl.GLType.Float,
        .Float3 => return opengl.GLType.Float,
        .Float4 => return opengl.GLType.Float,
        .Int => return opengl.GLType.Int,
        else => std.debug.panic("Unknown ShaderDataType", .{}),
    }
}

fn getComponentCount(dataType: ShaderDataType) i32 {
    switch (dataType) {
        .Float => return 1,
        .Float2 => return 2,
        .Float3 => return 3,
        .Float4 => return 4,
        .Mat3 => return 3 * 3,
        .Mat4 => return 4 * 4,
        .Int => return 1,
        .Int2 => return 2,
        .Int3 => return 3,
        .Int4 => return 4,
        .Bool => return 1,
        else => std.debug.panic("Unknown ShaderDataType", .{}),
    }
}

pub const OpenGLVertexArray = struct {
    const Self = @This();

    rendererId: u32,
    indexBuffer: IndexBuffer = undefined,
    vertexBuffer: VertexBuffer = undefined,

    pub fn init() Self {
        var rendererId: u32 = 0;
        opengl.genVertexArrays(1, &rendererId);
        return .{
            .rendererId = rendererId,
        };
    }

    pub fn deinit(self: *Self) void {
        self.indexBuffer.deinit();
        self.vertexBuffer.deinit();
        opengl.deleteVertexArrays(1, &self.rendererId);
    }

    pub fn bind(self: *Self) void {
        opengl.bindVertexArray(self.rendererId);
    }

    pub fn unbind(self: *Self) void {
        _ = self;
        opengl.bindVertexArray(0);
    }

    pub fn addVertexBuffer(self: *Self, vertexBuffer: VertexBuffer) void {
        vertexBuffer.bind();
        self.vertexBuffer = vertexBuffer;

        var index: u32 = 0;
        const layout = vertexBuffer.getLayout();
        for (layout.elements) |element| {
            opengl.enableVertexAttribArray(index);
            opengl.vertexAttribPointer(
                index,
                getComponentCount(element.dataType),
                getOpenGLType(element.dataType),
                element.normalized,
                @intCast(layout.stride),
                element.offset,
            );
            index += 1;
        }
    }

    pub fn setIndexBuffer(self: *Self, indexBuffer: IndexBuffer) void {
        indexBuffer.bind();
        self.indexBuffer = indexBuffer;
    }
};
