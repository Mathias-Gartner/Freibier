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
    public partial class Application
    {
        partial void beerRecipients_CanRun(ref bool result)
        {
            result = Current.User.HasPermission("LightSwitchApplication:Office");
        }

        partial void beerTypes_CanRun(ref bool result)
        {
            result = Current.User.HasPermission("LightSwitchApplication:Office");
        }

        partial void countries_CanRun(ref bool result)
        {
            result = Current.User.HasPermission("LightSwitchApplication:Office");
        }

        partial void drivers_CanRun(ref bool result)
        {
            result = Current.User.HasPermission("LightSwitchApplication:Office");
        }

        partial void newOrder_CanRun(ref bool result)
        {
            result = Current.User.HasPermission("LightSwitchApplication:Office");
        }

        partial void orderReceived_CanRun(ref bool result)
        {
            result = Current.User.HasPermission("LightSwitchApplication:Office") || Current.User.HasPermission("LightSwitchApplication:Driver");
        }

        partial void storage_CanRun(ref bool result)
        {
            result = Current.User.HasPermission("LightSwitchApplication:Office");
        }

        partial void supplierStorage_CanRun(ref bool result)
        {
            result = Current.User.HasPermission("LightSwitchApplication:Office");
        }
    }
}
