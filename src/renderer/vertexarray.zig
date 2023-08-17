const RenderApi = @import("renderapi.zig");
const OpenGLVertexArray = @import("../platform/opengl/openglvertexarray.zig").OpenGLVertexArray;
const VertexBuffer = @import("vertexbuffer.zig").VertexBuffer;
const IndexBuffer = @import("indexbuffer.zig").IndexBuffer;

pub const VertexArray = struct {
    pub const Self = @This();

    glImpl: OpenGLVertexArray = undefined,

    pub fn init() !Self {
        switch (RenderApi.api) {
            .OpenGL => return .{ .glImpl = OpenGLVertexArray.init() },
            else => return error.UnsupportedRenderApiVertexBuffer,
        }
    }

    pub fn deinit(self: *Self) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.deinit(),
            else => unreachable,
        }
    }

    pub fn bind(self: *Self) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.bind(),
            else => unreachable,
        }
    }

    pub fn unbind(self: *Self) void {
        _ = self;
        switch (RenderApi.api) {
            .OpenGL => OpenGLVertexArray.unbind(),
            else => unreachable,
        }
    }

    pub fn addVertexBuffer(self: *Self, vertexBuffer: VertexBuffer) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.addVertexBuffer(vertexBuffer),
            else => unreachable,
        }
    }

    pub fn setIndexBuffer(self: *Self, indexBuffer: IndexBuffer) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.setIndexBuffer(indexBuffer),
            else => unreachable,
        }
    }

    pub fn getIndexBuffer(self: *Self) IndexBuffer {
        switch (RenderApi.api) {
            .OpenGL => return self.glImpl.getIndexBuffer(),
            else => unreachable,
        }
    }
};
