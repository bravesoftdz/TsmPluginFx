namespace Tsm.Plugin.Core;

uses 
  RemObjects.Elements.RTL;

type
  XmlDocumentHelper =  public extension class(XmlDocument)
  public
    method AllElementsWithName(aLocalName: not nullable String; aNamespace: nullable XmlNamespace := nil;
      aXmlElement: XmlElement := nil): not nullable sequence of XmlElement;
    begin
      var lXmlElement: XmlElement;
      if not assigned(aXmlElement) then
        lXmlElement := Root
      else
        lXmlElement := aXmlElement;

      if lXmlElement.Elements.Count = 0 then
        exit(new List<XmlElement>);
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
    method FindParameterItem(const aName: not nullable String;
      const aItems: not nullable ISequence<XmlElement>): XmlElement;
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
      if (lparamItems.Count = 0) then
        result := nil
      else
        result := lparamItems.First;
    end;

    method FindPluginParameterItem(const aName: not nullable String): XmlElement;
    begin
      var lparamItem_base, lparamItem_user, lparamItem_proj: XmlElement;
      // Param item must exist in base Pml
      lparamItem_base := FindParameterItem(aName, fBaseParamItems);
      if not assigned(lparamItem_base) then
        raise new EParameterItemMissingException(aName); 
      result := lparamItem_base;
      // User param item, existing?
      if assigned(fUserParamItems) then begin
        lparamItem_user := FindParameterItem(aName, fUserParamItems);
        if assigned(lparamItem_user) then result := lparamItem_user;
      end;
      // Proj param item, existing?
      if assigned(fProjectParamItems) then begin
        lparamItem_proj := FindParameterItem(aName, fProjectParamItems);
        if assigned(lparamItem_proj) then result := lparamItem_proj;
      end;
    end;

  public
    constructor(const aBasePmlFilePath: not nullable String; const aUserPmlFilePath: not nullable String;
      const aProjectPmlFilePath: not nullable String);
    begin
      fBasePmlDoc := XmlDocument.FromFile(aBasePmlFilePath);
      fPmlValueAttribute := fBasePmlDoc.Root.Attribute['value'];
      // Get the value tag. It could be "value", or "v", or anything.
      if not assigned(fPmlValueAttribute) then
        fPmlValueTag := 'value'
      else
        fPmlValueTag := fPmlValueAttribute.Value;

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
                    .First  // There should always be one and only one rows element.
                    .ElementsWithName('row')
                    .ToArray[aRow]
                    .ElementsWithName(fPmlValueTag)
                    .ToArray[aColumn];
      result := lCell.Value;
    end;
  end;

end.