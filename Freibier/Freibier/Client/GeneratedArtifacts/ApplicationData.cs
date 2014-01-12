﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Dieser Code wurde von einem Tool generiert.
//     Laufzeitversion:4.0.30319.32559
//
//     Änderungen an dieser Datei können falsches Verhalten verursachen und gehen verloren, wenn
//     der Code erneut generiert wird.
// </auto-generated>
//------------------------------------------------------------------------------

// Ursprünglicher Dateiname:
// Erstellungsdatum: 12.01.2014 03:06:04
namespace LightSwitchApplication.Implementation
{
    
    /// <summary>
    /// Im Schema sind keine Kommentare für "ApplicationDataObjectContext" vorhanden.
    /// </summary>
    public partial class ApplicationDataObjectContext : global::Microsoft.LightSwitch.ClientGenerated.Implementation.DataServiceContext
    {
        /// <summary>
        /// Initialisiert ein neues ApplicationDataObjectContext-Objekt.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public ApplicationDataObjectContext(global::System.Uri serviceRoot) : 
                base(serviceRoot)
        {
            this.ResolveName = new global::System.Func<global::System.Type, string>(this.ResolveNameFromType);
            this.ResolveType = new global::System.Func<string, global::System.Type>(this.ResolveTypeFromName);
            this.OnContextCreated();
        }
        partial void OnContextCreated();
        /// <summary>
        /// Da sich der Namespace, der für diesen Dienstverweis in
        /// Visual Studio konfiguriert ist, von demjenigen unterscheidet,
        /// der im Server-Schema angegeben ist, verwenden Sie Typemapper,
        /// um Zuordnungen zwischen den beiden vorzunehmen.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        protected global::System.Type ResolveTypeFromName(string typeName)
        {
            if (typeName.StartsWith("LightSwitchApplication", global::System.StringComparison.Ordinal))
            {
                return this.GetType().Assembly.GetType(string.Concat("LightSwitchApplication.Implementation", typeName.Substring(22)), false);
            }
            return null;
        }
        /// <summary>
        /// Da sich der Namespace, der für diesen Dienstverweis in
        /// Visual Studio konfiguriert ist, von demjenigen unterscheidet,
        /// der im Server-Schema angegeben ist, verwenden Sie Typemapper,
        /// um Zuordnungen zwischen den beiden vorzunehmen.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        protected string ResolveNameFromType(global::System.Type clientType)
        {
            if (clientType.Namespace.Equals("LightSwitchApplication.Implementation", global::System.StringComparison.Ordinal))
            {
                return string.Concat("LightSwitchApplication.", clientType.Name);
            }
            return null;
        }
        /// <summary>
        /// Im Schema sind keine Kommentare für "OrderBuySuppliesOperations" vorhanden.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public global::System.Data.Services.Client.DataServiceQuery<DeliveryConfirmOperation> OrderBuySuppliesOperations
        {
            get
            {
                if ((this._OrderBuySuppliesOperations == null))
                {
                    this._OrderBuySuppliesOperations = base.CreateQuery<DeliveryConfirmOperation>("OrderBuySuppliesOperations");
                }
                return this._OrderBuySuppliesOperations;
            }
        }
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        private global::System.Data.Services.Client.DataServiceQuery<DeliveryConfirmOperation> _OrderBuySuppliesOperations;
        /// <summary>
        /// Im Schema sind keine Kommentare für "OrderBuySuppliesOperations" vorhanden.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public void AddToOrderBuySuppliesOperations(DeliveryConfirmOperation deliveryConfirmOperation)
        {
            base.AddObject("OrderBuySuppliesOperations", deliveryConfirmOperation);
        }
    }
    /// <summary>
    /// Im Schema sind keine Kommentare für "LightSwitchApplication.DeliveryConfirmOperation" vorhanden.
    /// </summary>
    /// <KeyProperties>
    /// Id
    /// </KeyProperties>
    [global::System.Data.Services.Common.EntitySetAttribute("OrderBuySuppliesOperations")]
    [global::System.Data.Services.Common.DataServiceKeyAttribute("Id")]
    public partial class DeliveryConfirmOperation : global::Microsoft.LightSwitch.ClientGenerated.Implementation.EntityBase, global::System.ComponentModel.INotifyPropertyChanged
    {
        /// <summary>
        /// Erstellt ein neues DeliveryConfirmOperation-Objekt.
        /// </summary>
        /// <param name="ID">Anfangswert von Id.</param>
        /// <param name="rowVersion">Anfangswert von RowVersion.</param>
        /// <param name="deliveryId">Anfangswert von DeliveryId.</param>
        /// <param name="executionError">Anfangswert von ExecutionError.</param>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public static DeliveryConfirmOperation CreateDeliveryConfirmOperation(int ID, byte[] rowVersion, int deliveryId, bool executionError)
        {
            DeliveryConfirmOperation deliveryConfirmOperation = new DeliveryConfirmOperation();
            deliveryConfirmOperation.Id = ID;
            deliveryConfirmOperation.RowVersion = rowVersion;
            deliveryConfirmOperation.DeliveryId = deliveryId;
            deliveryConfirmOperation.ExecutionError = executionError;
            return deliveryConfirmOperation;
        }
        /// <summary>
        /// Im Schema sind keine Kommentare für die Eigenschaft "Id" vorhanden.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public int Id
        {
            get
            {
                return this._Id;
            }
            set
            {
                this.OnIdChanging(value);
                if (object.Equals(this.Id, value))
                {
                    return;
                }
                this._Id = value;
                this.OnIdChanged();
                this.OnPropertyChanged("Id");
            }
        }
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        private int _Id;
        partial void OnIdChanging(int value);
        partial void OnIdChanged();
        /// <summary>
        /// Im Schema sind keine Kommentare für die Eigenschaft "RowVersion" vorhanden.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public byte[] RowVersion
        {
            get
            {
                if ((this._RowVersion != null))
                {
                    return ((byte[])(this._RowVersion.Clone()));
                }
                else
                {
                    return null;
                }
            }
            set
            {
                this.OnRowVersionChanging(value);
                if (object.Equals(this.RowVersion, value))
                {
                    return;
                }
                this._RowVersion = value;
                this.OnRowVersionChanged();
                this.OnPropertyChanged("RowVersion");
            }
        }
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        private byte[] _RowVersion;
        partial void OnRowVersionChanging(byte[] value);
        partial void OnRowVersionChanged();
        /// <summary>
        /// Im Schema sind keine Kommentare für die Eigenschaft "DeliveryId" vorhanden.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public int DeliveryId
        {
            get
            {
                return this._DeliveryId;
            }
            set
            {
                this.OnDeliveryIdChanging(value);
                if (object.Equals(this.DeliveryId, value))
                {
                    return;
                }
                this._DeliveryId = value;
                this.OnDeliveryIdChanged();
                this.OnPropertyChanged("DeliveryId");
            }
        }
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        private int _DeliveryId;
        partial void OnDeliveryIdChanging(int value);
        partial void OnDeliveryIdChanged();
        /// <summary>
        /// Im Schema sind keine Kommentare für die Eigenschaft "ExecutionError" vorhanden.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public bool ExecutionError
        {
            get
            {
                return this._ExecutionError;
            }
            set
            {
                this.OnExecutionErrorChanging(value);
                if (object.Equals(this.ExecutionError, value))
                {
                    return;
                }
                this._ExecutionError = value;
                this.OnExecutionErrorChanged();
                this.OnPropertyChanged("ExecutionError");
            }
        }
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        private bool _ExecutionError;
        partial void OnExecutionErrorChanging(bool value);
        partial void OnExecutionErrorChanged();
        /// <summary>
        /// Im Schema sind keine Kommentare für die Eigenschaft "ErrorMessage" vorhanden.
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public string ErrorMessage
        {
            get
            {
                return this._ErrorMessage;
            }
            set
            {
                this.OnErrorMessageChanging(value);
                if (object.Equals(this.ErrorMessage, value))
                {
                    return;
                }
                this._ErrorMessage = value;
                this.OnErrorMessageChanged();
                this.OnPropertyChanged("ErrorMessage");
            }
        }
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        private string _ErrorMessage;
        partial void OnErrorMessageChanging(string value);
        partial void OnErrorMessageChanged();
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        public event global::System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Data.Services.Design", "1.0.0")]
        protected virtual void OnPropertyChanged(string property)
        {
            if ((this.PropertyChanged != null))
            {
                this.PropertyChanged(this, new global::System.ComponentModel.PropertyChangedEventArgs(property));
            }
        }
    }
}