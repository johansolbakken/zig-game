const glad = @cImport(@cInclude("glad/glad.h"));
const glinit = @cImport(@cInclude("platform/opengl/glinit.h"));

pub fn init() !void {
    if (glinit.initGlad() != 0) {
        return error.FailedToInitGlad;
    }
}
