﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace LightSwitchApplication
{
    /// <summary>
    /// Defines the names of the application permissions.
    /// </summary>
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.LightSwitch.BuildTasks.CodeGen", "11.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    public static class Permissions
    {
        /// <summary>
        /// Bietet die Möglichkeit, die Sicherheit für die Anwendung zu verwalten.
        /// </summary>
        public const string SecurityAdministration = global::Microsoft.LightSwitch.Security.ApplicationPermissions.SecurityAdministration;

        /// <summary>
        /// Ruft alle für die Anwendung definierten Berechtigungen ab. Hierzu zählen systemdefinierte und benutzerdefinierte Berechtigungen.
        /// </summary>
        public static global::System.Collections.ObjectModel.ReadOnlyCollection<string> AllPermissions { get { return global::Microsoft.LightSwitch.Security.ApplicationPermissions.AllPermissions; } }
    }
}
