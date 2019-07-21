{/*! 
     Provides a wrapper class of Gisdk resource compiler for just-in-time script compiling.
     
     \modified    2019-07-17 13:10pam
     \author      Wuping Xin
  */}
namespace TsmPluginFx.Core;

uses
  RemObjects.Elements.RTL;

type
  CaliperScriptCompiler = public class
  public
    class method Compile(const aScript: String; const aCompilerPath: String; const aUiDbFilePathWithoutExt: String): tuple of (Success: Boolean, Errors: ImmutableList<String>);
    begin
      // Save the script content to a disk file in the same directory as the UI database.
      var lScriptFilePath := aUiDbFilePathWithoutExt + 'Script.rsc';
      if File.Exists(lScriptFilePath) then File.Delete(lScriptFilePath);
      File.WriteText(lScriptFilePath, aScript);

      // Delete any pre-existing error file.
      var lCompilerErrorFilePath := aUiDbFilePathWithoutExt + '.err';
      if File.Exists(lCompilerErrorFilePath) then File.Delete(lCompilerErrorFilePath);

      // Compile the script
      var lArgs := new List<String>('-u', aUiDbFilePathWithoutExt, lScriptFilePath);
      Process.Run(aCompilerPath, lArgs.ToArray);

      // Check if there is any errors.
      var lErrors := if File.Exists(lCompilerErrorFilePath) then File.ReadLines(lCompilerErrorFilePath);
      result := (assigned(lErrors), lErrors);
    end;
  end;

end.