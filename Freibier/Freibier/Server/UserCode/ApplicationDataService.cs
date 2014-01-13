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
        partial void DeliveryConfirmOperations_Inserting(DeliveryConfirmOperation entity)
        {
            string errorMessage;
            entity.ExecutionError = executeStoredProcedure("usp_delivery_confirm", new[] { new SqlParameter("@deliveryId", entity.DeliveryId) }, out errorMessage);
            if (entity.ExecutionError)
                entity.ErrorMessage = errorMessage;
        }

        partial void OrderReceivedOperations_Inserting(OrderReceivedOperation entity)
        {
            string errorMessage;
            entity.ExecutionError = executeStoredProcedure("usp_order_received", new[] { new SqlParameter("@orderId", entity.OrderId) }, out errorMessage);
            if (entity.ExecutionError)
                entity.ErrorMessage = errorMessage;
        }

        private bool executeStoredProcedure(string procedureName, SqlParameter[] parameters, out string errorMessage)
        {
            var error = false;
            errorMessage = null;

            using (SqlConnection connection = new SqlConnection())
            {
                var connectionStringName = this.DataWorkspace.freibierDB.Details.Name;
                connection.ConnectionString = ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;

                using (SqlCommand command = new SqlCommand(procedureName, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddRange(parameters);

                    connection.Open();
                    try
                    {
                        command.ExecuteNonQuery();
                    }
                    catch (SqlException e)
                    {
                        error = true;
                        errorMessage = e.Message;
                    }
                }
            }

            if (!error)
                this.Details.DiscardChanges();

            return error;
        }
    }
}
