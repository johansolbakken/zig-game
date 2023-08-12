const glad = @cImport(@cInclude("glad/glad.h"));
const glinit = @cImport(@cInclude("platform/opengl/glinit.h"));

pub fn init() !void {
    if (glinit.initGlad() != 0) {
        return error.FailedToInitGlad;
    }
}

pub fn setClearColor(r: f32, g: f32, b: f32, a: f32) void {
    glad.glClearColor(r, g, b, a);
}

pub fn clear() void {
    glad.glClear(glad.GL_COLOR_BUFFER_BIT | glad.GL_DEPTH_BUFFER_BIT);
}

pub fn genVertexArrays(n: i32, arrays: *u32) void {
    glad.glGenVertexArrays(n, @ptrCast(arrays));
}

pub fn deleteVertexArrays(n: i32, arrays: *u32) void {
    glad.glDeleteVertexArrays(n, @ptrCast(arrays));
}

pub fn bindVertexArray(array: u32) void {
    glad.glBindVertexArray(array);
}

pub fn genBuffers(n: i32, buffers: *u32) void {
    glad.glGenBuffers(n, @ptrCast(buffers));
}

pub fn deleteBuffers(n: i32, buffers: *u32) void {
    glad.glDeleteBuffers(n, @ptrCast(buffers));
}

pub const BufferBindingTarget = enum(c_uint) {
    ArrayBuffer = glad.GL_ARRAY_BUFFER,
    AtomicCounterBuffer = glad.GL_ATOMIC_COUNTER_BUFFER,
    CopyReadBuffer = glad.GL_COPY_READ_BUFFER,
    CopyWriteBuffer = glad.GL_COPY_WRITE_BUFFER,
    DispatchIndirectBuffer = glad.GL_DISPATCH_INDIRECT_BUFFER,
    DrawIndirectBuffer = glad.GL_DRAW_INDIRECT_BUFFER,
    ElementArrayBuffer = glad.GL_ELEMENT_ARRAY_BUFFER,
    PixelPackBuffer = glad.GL_PIXEL_PACK_BUFFER,
    PixelUnpackBuffer = glad.GL_PIXEL_UNPACK_BUFFER,
    QueryBuffer = glad.GL_QUERY_BUFFER,
    ShaderStorageBuffer = glad.GL_SHADER_STORAGE_BUFFER,
    TextureBuffer = glad.GL_TEXTURE_BUFFER,
    TransformFeedbackBuffer = glad.GL_TRANSFORM_FEEDBACK_BUFFER,
    UniformBuffer = glad.GL_UNIFORM_BUFFER,
};

pub fn bindBuffer(target: BufferBindingTarget, buffer: u32) void {
    glad.glBindBuffer(@intFromEnum(target), buffer);
}

pub const BufferUsage = enum(c_uint) {
    StreamDraw = glad.GL_STREAM_DRAW,
    StreamRead = glad.GL_STREAM_READ,
    StreamCopy = glad.GL_STREAM_COPY,
    StaticDraw = glad.GL_STATIC_DRAW,
    StaticRead = glad.GL_STATIC_READ,
    StaticCopy = glad.GL_STATIC_COPY,
    DynamicDraw = glad.GL_DYNAMIC_DRAW,
    DynamicRead = glad.GL_DYNAMIC_READ,
    DynamicCopy = glad.GL_DYNAMIC_COPY,
};

pub fn bufferData(target: BufferBindingTarget, size: i32, data: *void, usage: BufferUsage) void {
    glad.glBufferData(@intFromEnum(target), size, data, @intFromEnum(usage));
}

pub fn enableVertexAttribArray(index: u32) void {
    glad.glEnableVertexAttribArray(index);
}

pub const GLType = enum(c_uint) {
    Byte = glad.GL_BYTE,
    UnsignedByte = glad.GL_UNSIGNED_BYTE,
    Short = glad.GL_SHORT,
    UnsignedShort = glad.GL_UNSIGNED_SHORT,
    Int = glad.GL_INT,
    UnsignedInt = glad.GL_UNSIGNED_INT,
    HalfFloat = glad.GL_HALF_FLOAT,
    Float = glad.GL_FLOAT,
    Double = glad.GL_DOUBLE,
    Fixed = glad.GL_FIXED,
};

pub fn vertexAttribPointer(index: u32, size: i32, dataType: GLType, normalized: bool, stride: i32, pointer: u32) void {
    glad.glVertexAttribPointer(index, size, @intFromEnum(dataType), @intFromBool(normalized), stride, @ptrFromInt(pointer));
}

pub const DrawMode = enum(c_uint) {
    Points = glad.GL_POINTS,
    LineStrip = glad.GL_LINE_STRIP,
    LineLoop = glad.GL_LINE_LOOP,
    Lines = glad.GL_LINES,
    LineStripAdjacency = glad.GL_LINE_STRIP_ADJACENCY,
    LinesAdjacency = glad.GL_LINES_ADJACENCY,
    TriangleStrip = glad.GL_TRIANGLE_STRIP,
    TriangleFan = glad.GL_TRIANGLE_FAN,
    Triangles = glad.GL_TRIANGLES,
    TriangleStripAdjacency = glad.GL_TRIANGLE_STRIP_ADJACENCY,
    TrianglesAdjacency = glad.GL_TRIANGLES_ADJACENCY,
    Patches = glad.GL_PATCHES,
};

pub fn drawIndexed(mode: DrawMode, count: i32, dataType: GLType) void {
    glad.glDrawElements(@intFromEnum(mode), count, @intFromEnum(dataType), null);
}
