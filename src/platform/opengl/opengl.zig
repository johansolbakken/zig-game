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
