using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.LightSwitch;
using Microsoft.LightSwitch.Security.Server;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
namespace LightSwitchApplication
{
    public partial class ApplicationDataService
    {
        partial void OrderBuySuppliesOperations_Inserting(DeliveryConfirmOperation entity)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                var connectionStringName = this.DataWorkspace.freibierDB.Details.Name;
                connection.ConnectionString = ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;

                var procedure = "usp_delivery_confirm";
                using (SqlCommand command = new SqlCommand(procedure, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@deliveryId", entity.DeliveryId));

                    connection.Open();
                    try
                    {
                        command.ExecuteNonQuery();
                    }
                    catch (SqlException e)
                    {
                        entity.ExecutionError = true;
                        entity.ErrorMessage = e.Message;
                    }
                }
            }

            if (!entity.ExecutionError)
                this.Details.DiscardChanges();
        }
    }
}
