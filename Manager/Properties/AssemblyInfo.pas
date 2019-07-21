namespace TsmPluginFx.Manager;

interface

uses
  System.Reflection,
  System.Resources,
  System.Runtime.InteropServices;

  [assembly: AssemblyTitle('TsmPluginFx.Manager')]
  [assembly: AssemblyDescription('TransModeler Plugin Framework')]
  [assembly: AssemblyConfiguration('')]
  [assembly: AssemblyCompany('KLD Engneering, P. C.')]
  [assembly: AssemblyProduct('')]
  [assembly: AssemblyCopyright('Copyright ©  2019')]
  [assembly: AssemblyTrademark('')]
  [assembly: AssemblyCulture('')]
  [assembly: AssemblyVersion('1.0.0.0')]
  [assembly: NeutralResourcesLanguage('')]
  [assembly: ComVisible(false)]
  [assembly: Guid("5044ff28-1828-40af-93ab-4607f759b2b7")]

  //
  // In order to sign your assembly you must specify a key to use. Refer to the
  // Microsoft .NET Framework documentation for more information on assembly signing.
  //
  // Use the attributes below to control which key is used for signing.
  //
  // Notes:
  //   (*) If no key is specified, the assembly is not signed.
  //   (*) KeyName refers to a key that has been installed in the Crypto Service
  //       Provider (CSP) on your machine. KeyFile refers to a file which contains
  //       a key.
  //   (*) If the KeyFile and the KeyName values are both specified, the
  //       following processing occurs:
  //       (1) If the KeyName can be found in the CSP, that key is used.
  //       (2) If the KeyName does not exist and the KeyFile does exist, the key
  //           in the KeyFile is installed into the CSP and used.
  //   (*) In order to create a KeyFile, you can use the sn.exe (Strong Name) utility.
  //       When specifying the KeyFile, the location of the KeyFile should be
  //       relative to the project output directory, which in Oxygene by default is the
  //       same as the project directory. For example, if your KeyFile is
  //       located in the project directory, you would specify the AssemblyKeyFile
  //       attribute as [assembly: AssemblyKeyFile('mykey.snk')]
  //   (*) Delay Signing is an advanced option - see the Microsoft .NET Framework
  //       documentation for more information on this.
  //
  [assembly: AssemblyDelaySign(false)]
  [assembly: AssemblyKeyFile('')]
  [assembly: AssemblyKeyName('')]

implementation

end.