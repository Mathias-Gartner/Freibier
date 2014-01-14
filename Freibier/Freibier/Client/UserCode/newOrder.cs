using System;
using System.Linq;
using System.IO;
using System.IO.IsolatedStorage;
using System.Collections.Generic;
using Microsoft.LightSwitch;
using Microsoft.LightSwitch.Framework.Client;
using Microsoft.LightSwitch.Presentation;
using Microsoft.LightSwitch.Presentation.Extensions;
using System.Windows;

namespace LightSwitchApplication
{
    public partial class newOrder
    {
        partial void newOrder_InitializeDataWorkspace(global::System.Collections.Generic.List<global::Microsoft.LightSwitch.IDataService> saveChangesTo)
        {
            this.orderProperty = new ordersItem();
        }

        partial void newOrder_Saved()
        {
            this.ShowMessageBox("Order created.");

            this.Close(false);
            //Application.Current.ShowDefaultScreen(this.ordersItemProperty);
        }

        partial void orderedBeers_Validate(ScreenValidationResultsBuilder results)
        {
            // fix data before validation
            if (orderProperty.Details.EntityState != EntityState.Deleted && orderProperty.Details.EntityState != EntityState.Discarded)
            {
                orderedBeers.Where(ob => ob.ordersItem == null).All(ob =>
                {
                    if (ob.Details.EntityState != EntityState.Deleted && ob.Details.EntityState != EntityState.Discarded)
                        ob.ordersItem = orderProperty;

                    return true;
                });
            }
        }
    }
}