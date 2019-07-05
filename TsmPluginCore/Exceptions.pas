namespace Tsm.Plugin.Core;

type
  EDllModuleLoadingException = public class(Exception)  
  public
    constructor(const aModuleName: not nullable String; const aError: not nullable String);
    begin
      inherited(String.Format('Module ''{0}'' failed to be loaded with error: {1}.', 
        [aModuleName, aError]));
    end;
  end;

  EUiScriptCompileErrorException = public class(Exception)
  private
    fErrors: String;
  public
    constructor(const aErrors: not nullable String);
    begin
      inherited ('UI script failed to compile with errors.');
      fErrors := aErrors;
    end;

    property Errors: String read fErrors;
  end;

  EParameterItemNameNotUniqueException = public class(Exception)
  public
    constructor(const aItemName: not nullable String);
    begin
      inherited(String.Format('Parameter item name ''{0}'' is not unique.', [aItemName]));
    end;
  end;

  EParameterItemMissingException = public class(Exception)
  public
    constructor(const aItemName: not nullable String);
    begin
      inherited(String.Format('Parameter item with name ''{0}'' is missing.', [aItemName]));
    end;
  end;

  EInvalidParameterItemTypeException = public class(Exception)
  public
    constructor(const aItemName: not nullable String; const aItemType: not nullable String);
    begin
      inherited(String.Format('Parameter item ''{0}'' has invalid type ''{1}''.', [aItemName, aItemType]));
    end;
  end;

end.