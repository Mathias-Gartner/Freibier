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
    public partial class orderReceived
    {
        partial void orderReceivedOperation_CanExecute(ref bool result)
        {
            result = (this.orders.SelectedItem != null && !this.orders.SelectedItem.received);
        }

        partial void orderReceivedOperation_Execute()
        {
            if (this.orders.SelectedItem == null)
                return;

            var dataWorkspace = new DataWorkspace();
            var order = this.orders.SelectedItem;

            var operation = dataWorkspace.ApplicationData.OrderReceivedOperations.AddNew();
            operation.OrderId = order.id;

            dataWorkspace.ApplicationData.SaveChanges();
            if (operation.ExecutionError)
            {
                this.ShowMessageBox("Operation failed: " + operation.ErrorMessage);
            }

            this.Refresh();
        }

        partial void showOrderDetailsOperation_Execute()
        {
            this.OpenModalWindow("OrderDetailsDialog");
        }
    }
}
