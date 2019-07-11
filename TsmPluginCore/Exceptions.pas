{/*! 
     Provides exception classes for different situations.

     \modified    2019-07-09 14:30pm
     \author      Wuping Xin
  */}
namespace Tsm.Plugin.Core;

type
  EDllModuleLoadingException = public class(Exception)  
  public
    constructor(const aModuleName: not nullable String; const aError: not nullable String);
    begin
      inherited($"Module {aModuleName} failed to be loaded with error: {aError}.");
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
      inherited($"Parameter item name {aItemName} is not unique.");
    end;
  end;

  EParameterItemMissingException = public class(Exception)
  public
    constructor(const aItemName: not nullable String);
    begin
      inherited($"Parameter item with name {aItemName} is missing.");
    end;
  end;

  EInvalidParameterItemTypeException = public class(Exception)
  public
    constructor(const aItemName: not nullable String; const aItemType: not nullable String);
    begin
      inherited($"Parameter item {aItemName} has invalid type {aItemType}.");
    end;
  end;

end.