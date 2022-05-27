# Notes

## Class methods #installEnhancements
The classes `Jun2dPoint`, `Jun3dPoint`, `JunAngle` and `JunOpenGLRenderingContext` contain a method named #installEnhancements and the accompanying #uninstallEnhancements. These manually install and remove methods, e.g. to Number and Point. This mechanism has been replaced with extension methods, which will be automatically removed when a package is unloaded.

Subsequently, the method #obsolete and class instance variable name `enhancements` have been removed from these classes.
