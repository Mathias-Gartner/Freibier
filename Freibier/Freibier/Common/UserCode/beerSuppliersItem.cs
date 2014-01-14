using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.LightSwitch;
namespace LightSwitchApplication
{
    public partial class beerSupplier
    {
        public override string ToString()
        {
            var beerName = "(beerType not yet loaded)";
            if (beerType != null)
                beerName = beerType.name;

            return String.Format("{0} (€ {1})", beerName, price.ToString("0.00"));
        }
    }
}
