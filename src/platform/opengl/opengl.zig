const glad = @cImport(@cInclude("glad/glad.h"));
const glinit = @cImport(@cInclude("platform/opengl/glinit.h"));
const std = @import("std");

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

pub fn createProgram() u32 {
    return glad.glCreateProgram();
}

pub fn deleteProgram(program: u32) void {
    glad.glDeleteProgram(program);
}

pub fn attachShader(program: u32, shader: u32) void {
    glad.glAttachShader(program, shader);
}

pub fn linkProgram(program: u32) !void {
    glad.glLinkProgram(program);
    try debugProgramLinking(program);
}

pub fn debugProgramLinking(program: u32) !void {
    var success: i32 = 0;
    glad.glGetProgramiv(program, glad.GL_LINK_STATUS, &success);
    if (success == 0) {
        var infoLog: [512]u8 = undefined;
        var length: i32 = 0;
        glad.glGetProgramInfoLog(program, 512, &length, &infoLog);
        std.log.err("OpenGL program linking failed: {s}", .{infoLog[0..@intCast(length)]});
    }
}

pub fn useProgram(program: u32) void {
    glad.glUseProgram(program);
}

pub const ShaderType = enum(c_uint) {
    Vertex = glad.GL_VERTEX_SHADER,
    Fragment = glad.GL_FRAGMENT_SHADER,
    Geometry = glad.GL_GEOMETRY_SHADER,
    TessControl = glad.GL_TESS_CONTROL_SHADER,
    TessEvaluation = glad.GL_TESS_EVALUATION_SHADER,
    Compute = glad.GL_COMPUTE_SHADER,
};

pub fn createShader(shaderType: ShaderType) u32 {
    return glad.glCreateShader(@intFromEnum(shaderType));
}

pub fn deleteShader(shader: u32) void {
    glad.glDeleteShader(shader);
}

pub fn shaderSource(shader: u32, source: []const u8) void {
    glad.glShaderSource(shader, 1, @ptrCast(&source), null);
}

pub fn compileShader(shader: u32) !void {
    glad.glCompileShader(shader);
    try debugShaderCompilation(shader);
}

pub fn debugShaderCompilation(shader: u32) !void {
    var success: i32 = 0;
    glad.glGetShaderiv(shader, glad.GL_COMPILE_STATUS, &success);
    if (success == 0) {
        var infoLog: [512]u8 = undefined;
        var length: i32 = 0;
        glad.glGetShaderInfoLog(shader, 512, &length, &infoLog);
        std.log.err("OpenGL shader compilation failed: {s}", .{infoLog[0..@intCast(length)]});
    }
}

pub fn getUniformLocation(program: u32, name: []const u8) i32 {
    return glad.glGetUniformLocation(program, @ptrCast(name));
}

pub fn uniform3f(location: i32, x: f32, y: f32, z: f32) void {
    glad.glUniform3f(location, x, y, z);
}
