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
    public partial class deliveryDelivered
    {
        partial void deliveryDeliveredOperation_CanExecute(ref bool result)
        {
            result = (this.deliveries.SelectedItem != null && !this.deliveries.SelectedItem.delivered);
        }

        partial void deliveryDeliveredOperation_Execute()
        {
            if (this.deliveries.SelectedItem == null)
                return;

            var dataWorkspace = new DataWorkspace();
            var delivery = this.deliveries.SelectedItem;

            var operation = dataWorkspace.ApplicationData.DeliveryConfirmOperations.AddNew();
            operation.DeliveryId = delivery.id;

            dataWorkspace.ApplicationData.SaveChanges();
            if (operation.ExecutionError)
            {
                this.ShowMessageBox("Operation failed: " + operation.ErrorMessage);
            }

            this.Refresh();
        }

        partial void ShowDetailsOperation_Execute()
        {
            this.OpenModalWindow("DeliveryDetailsDialog");
        }
    }
}
