using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.LightSwitch;
namespace LightSwitchApplication
{
    public partial class orderedBeersItem
    {
        partial void beerSupplier_Changed()
        {
            if (price == 0)
                price = beerSupplier.price;
        }
    }
}
