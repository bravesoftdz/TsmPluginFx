{/*! 
     Provides a light weight parser class for TransModeler pml file.  

     \modified    2019-07-03 10:20am
     \author      Wuping Xin
  */}
namespace TsmPluginFx.Core;

uses 
  RemObjects.Elements.RTL;

type
  XmlDocumentHelper =  public extension class(XmlDocument)
  public
    method AllElementsWithName(aLocalName: not nullable String; aNamespace: nullable XmlNamespace := nil; aXmlElement: XmlElement := nil): not nullable sequence of XmlElement;
    begin
      var lXmlElement := if assigned(aXmlElement) then aXmlElement else Root;
      if lXmlElement.Elements.Count = 0 then exit(new List<XmlElement>);
      
      result := lXmlElement.ElementsWithName(aLocalName, aNamespace);

      for each el in lXmlElement.Elements do
        result := (not nullable sequence of XmlElement)(result.Concat(AllElementsWithName(aLocalName, aNamespace, el)));
    end;
  end;

  TsmPluginParameterParser = public class
  private
    fBasePmlDoc, fUserPmlDoc, fProjectPmlDoc: XmlDocument;
    fPmlValueAttribute: XmlAttribute;
    fPmlValueTag: String;
    fBaseParamItems, fUserParamItems, fProjectParamItems: ISequence<XmlElement>;
  private
    method FindParameterItem(const aName: not nullable String; const aItems: not nullable ISequence<XmlElement>): XmlElement;
    begin
      var lparamItems: ISequence<XmlElement> :=
              from
                p in aItems
              where
                (assigned(p.Attribute['name']) and (p.Attribute['name'].FullName = aName))
              select
                p;

      if (lparamItems.Count > 1) then
        raise new EParameterItemNameNotUniqueException(aName);

      result := if lparamItems.Count > 0 then lparamItems.First;
    end;

    method FindPluginParameterItem(const aName: not nullable String): XmlElement;
    begin
      // Param item must exist in base Pml
      var lparamItem_base := FindParameterItem(aName, fBaseParamItems);
      
      if not assigned(lparamItem_base) then
        raise new EParameterItemMissingException(aName); 
      
      result := lparamItem_base;
      
      if assigned(fUserParamItems) then begin
        var lparamItem_user := FindParameterItem(aName, fUserParamItems);        
        result := if assigned(lparamItem_user) then lparamItem_user else result;
      end;
    
      if assigned(fProjectParamItems) then begin
        var lparamItem_proj := FindParameterItem(aName, fProjectParamItems);        
        result := if assigned(lparamItem_proj) then lparamItem_proj else result;
      end;
    end;

  public
    constructor(const aBasePmlFilePath, aUserPmlFilePath, aProjectPmlFilePath: not nullable String);
    begin
      fBasePmlDoc := XmlDocument.FromFile(aBasePmlFilePath);
      
      // Get the value tag. It could be "value", or "v", or anything.
      fPmlValueAttribute := fBasePmlDoc.Root.Attribute['value'];            
      fPmlValueTag := if assigned(fPmlValueAttribute) then fPmlValueAttribute.Value else 'value';

      fBaseParamItems := fBasePmlDoc.AllElementsWithName('item');

      if File.Exists(aUserPmlFilePath) then begin
        fUserPmlDoc := XmlDocument.FromFile(aUserPmlFilePath);
        fUserParamItems := fUserPmlDoc.AllElementsWithName('item');
      end;

      if File.Exists(aProjectPmlFilePath) then begin
        fProjectPmlDoc := XmlDocument.FromFile(aProjectPmlFilePath);
        fProjectParamItems := fProjectPmlDoc.AllElementsWithName('item');
      end;
    end;

    method Item(const aName: not nullable String): ISequence<String>;
    begin
      var lparamItem: XmlElement := FindPluginParameterItem(aName);
      result := from v in lparamItem.ElementsWithName(fPmlValueTag) select v.Value;
    end;

    method TableItem(const aName: not nullable String; aColumn, aRow: UInt32): String;
    begin
      var lparamItem: XmlElement := FindPluginParameterItem(aName);
      
      if lparamItem.Attribute['type'].Value <> 'table' then
        raise new EInvalidParameterItemTypeException(aName, lparamItem.Attribute['type'].Value);
      
      var lCell := lparamItem.ElementsWithName('rows')
                             .First  // Only one element named "rows".
                             .ElementsWithName('row')
                             .ToArray[aRow]
                             .ElementsWithName(fPmlValueTag)
                             .ToArray[aColumn];

      result := lCell.Value;
    end;
  end;

end.