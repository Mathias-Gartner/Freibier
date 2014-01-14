using System;
using System.Linq;
using System.IO;
using System.IO.IsolatedStorage;
using System.Collections.Generic;
using Microsoft.LightSwitch;
using Microsoft.LightSwitch.Framework.Client;
using Microsoft.LightSwitch.Presentation;
using Microsoft.LightSwitch.Presentation.Extensions;

namespace LightSwitchApplication
{
    public partial class newDelivery
    {
        partial void newDelivery_InitializeDataWorkspace(global::System.Collections.Generic.List<global::Microsoft.LightSwitch.IDataService> saveChangesTo)
        {
            this.deliveriesItemProperty = new deliveriesItem();
        }

        partial void newDelivery_Saved()
        {
            this.ShowMessageBox("Delivery created.");

            this.Close(false);
            //Application.Current.ShowDefaultScreen(this.deliveriesItemProperty);
        }
    }
}