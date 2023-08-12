const RenderApi = @import("renderapi.zig");
const OpenGLVertexBuffer = @import("../platform/opengl/openglvertexbuffer.zig").OpenGLVertexBuffer;

pub const ShaderDataType = enum {
    None,
    Float,
    Float2,
    Float3,
    Float4,
    Mat3,
    Mat4,
    Int,
    Int2,
    Int3,
    Int4,
    Bool,
};

pub const BufferElement = struct {
    const Self = @This();

    name: []const u8,
    dataType: ShaderDataType,
    size: u32 = 0,
    offset: u32 = 0,
    normalized: bool = false,
};

pub const BufferLayout = struct {
    const Self = @This();

    elements: []const BufferElement,
    stride: u32 = 0,

    pub fn init(
        elements: []BufferElement,
    ) Self {
        var offset: u32 = 0;
        var stride: u32 = 0;
        for (0..elements.len) |i| {
            var element = &elements[i];
            element.offset = offset;
            offset += element.size;
            stride += element.size;
        }
        return .{ .elements = elements, .stride = stride };
    }
};

pub const VertexBuffer = struct {
    pub const Self = @This();

    glImpl: OpenGLVertexBuffer = undefined,

    pub fn init(
        vertices: []const f32,
        size: usize,
    ) !Self {
        switch (RenderApi.api) {
            .OpenGL => return .{ .glImpl = OpenGLVertexBuffer.init(vertices, size) },
            else => return error.UnsupportedRenderApiVertexBuffer,
        }
    }

    pub fn deinit(self: *Self) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.deinit(),
            else => unreachable,
        }
    }

    pub fn bind(self: *const Self) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.bind(),
            else => unreachable,
        }
    }

    pub fn setLayout(self: *Self, layout: BufferLayout) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.setLayout(layout),
            else => unreachable,
        }
    }

    pub fn getLayout(self: *const Self) BufferLayout {
        switch (RenderApi.api) {
            .OpenGL => return self.glImpl.getLayout(),
            else => unreachable,
        }
    }
};
