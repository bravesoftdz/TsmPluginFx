namespace TsmPluginFx.Manager;

uses 
  GisdkAPI,
  System.Reflection,
  System.IO,
  System.Collections.Generic;

type
  TsmPluginModuleManager = public class (IGisdkExtension)
  private
    fModules: not nullable List<TsmPluginModule> := new List<TsmPluginModule>;
    fConfigFilePath: String;
 
    method ConfigFilePath: String;
    begin
      if not String.IsNullOrEmpty(fConfigFilePath) then exit fConfigFilePath;

      var lCodeBase := &Assembly.GetExecutingAssembly.CodeBase; 
      var lUri := new UriBuilder(lCodeBase);
      fConfigFilePath := Uri.UnescapeDataString(lUri.Path) + '.config';

      exit fConfigFilePath;
    ensure
      File.Exists(fConfigFilePath);
    end;
  
    method LoadConfig;
    begin
      var lConfigXmlDoc := RemObjects.Elements.RTL.XmlDocument.FromFile(ConfigFilePath);
      var lActive: Boolean;
      var lPath: String;

      for each el in lConfigXmlDoc.Root.Elements do begin
        lActive := Convert.ToBoolean(el.Attribute['enabled'].Value);
        lPath   := el.Attribute['path'].Value;
        fModules.Add(new TsmPluginModule(lPath, lActive));
      end;
    end;

    method SaveConfig;
    begin
      var lConfigXmlDoc := RemObjects.Elements.RTL.XmlDocument.FromFile(ConfigFilePath);

      for each p in fModules do begin
        for each el in lConfigXmlDoc.Root.Elements do
          if el.Attribute['path'].Value.Equals(p.Path) then
            el.Attribute['enabled'].Value := p.Enabled.ToString;
      end;

      lConfigXmlDoc.SaveToFile(ConfigFilePath)
    end;
    
    method ShowUI;
    begin
      SaveConfig;
    end;

  public
    constructor;
    begin
      LoadConfig;
    end;
  
    method Load(app: IGisdkEngine);
    begin
      ShowUI;
    end;

    property Title: String 
      read begin
        exit 'TransModeler Plugin Manager';
      end;
  end;

end.