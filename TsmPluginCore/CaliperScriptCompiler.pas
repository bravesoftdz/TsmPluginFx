{/*! 
     Provides a wrapper class of Gisdk resource compiler for just-in-time script compiling.
     
     \modified    2019-07-02 11:21am
     \author      Wuping Xin
  */}
namespace Tsm.Plugin.Core;

uses
  RemObjects.Elements.RTL;

type
  CaliperScriptCompiler = public class
  public
    class method Compile(const aScript: String; const aCompilerPath: String; const aUiDbFilePathWithoutExt: String; out aMessages: ImmutableList<String>): Boolean;
    begin
      // Save the script content to a disk file in the same directory as the UI database.
      var lScriptFilePath := aUiDbFilePathWithoutExt + 'Script.rsc';
      
      if File.Exists(lScriptFilePath) then
        File.Delete(lScriptFilePath);
      
      File.WriteText(lScriptFilePath, aScript);

      // Delete any pre-existing error file.
      var lCompilerErrorFilePath := aUiDbFilePathWithoutExt + '.err';
      
      if File.Exists(lCompilerErrorFilePath) then
        File.Delete(lCompilerErrorFilePath);

      // Compile the script
      var lArgs := new List<String>('-u', aUiDbFilePathWithoutExt, lScriptFilePath);
      Process.Run(aCompilerPath, lArgs.ToArray);

      // Check if there is any errors.
      if File.Exists(lCompilerErrorFilePath) then
        aMessages := File.ReadLines(lCompilerErrorFilePath);
      
      result := assigned(aMessages) and (aMessages.Count > 0);
    end;
  end;

end.