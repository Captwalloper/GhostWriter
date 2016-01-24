# GhostWriter
Stylizes scripts' text output to neat effect.


USAGE: (Command Line)

GhostWriter.ahk [options] mode content target

options: -fast  greatly reduces delays

modes:  
        t __       parrots content; ignores target param </br>
        f __      parrots file content; ignores target param </br>
        tf __    appends content to target file </br>
        ff __     appends file content to target file </br>
        rc __     treats content and target as text; simultaneously outputs both on separate lines </br>
        
content:        the text to be parroted; mode may specify that it is actually a filename, whose contents should be parroted
                
target:         the file to be appended by content; may be ignored; for rc is treated as text



EXAMPLES:

GhostWriter.ahk t "text to be parroted a character at a time" </br>
GhostWriter.ahk -fast t "text to be parroted very rapidly" </br>
GhostWriter.ahk f "FileWhoseContentsWillBeParroted.txt" </br>
GhostWriter.ahk tf "text which will be appended" "FileToBeAppended.txt" </br>
GhostWriter.ahk ff "AppendingFileContents.txt" "FileToBeAppended.txt" </br>
GhostWriter.ahk rc "Slowly parroted text" "Rappidly parroted text." </br>



NOTES:

The included driver may be run to demo the application. As file system configurations may differ, the config section of the autohotkey files may need editing.
