﻿//------------------------------------------------------------------------------
// <auto-generated>
//    Dieser Code wurde aus einer Vorlage generiert.
//
//    Manuelle Änderungen an dieser Datei führen möglicherweise zu unerwartetem Verhalten Ihrer Anwendung.
//    Manuelle Änderungen an dieser Datei werden überschrieben, wenn der Code neu generiert wird.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.ComponentModel;
using System.Data.EntityClient;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Runtime.Serialization;
using System.Xml.Serialization;

[assembly: EdmSchemaAttribute()]
namespace ApplicationData.Implementation
{
    #region Kontexte
    
    /// <summary>
    /// Keine Dokumentation für Metadaten verfügbar.
    /// </summary>
    public partial class ApplicationDataObjectContext : ObjectContext
    {
        #region Konstruktoren
    
        /// <summary>
        /// Initialisiert ein neues ApplicationDataObjectContext-Objekt mithilfe der in Abschnitt 'ApplicationDataObjectContext' der Anwendungskonfigurationsdatei gefundenen Verbindungszeichenfolge.
        /// </summary>
        public ApplicationDataObjectContext() : base("name=ApplicationDataObjectContext", "ApplicationDataObjectContext")
        {
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialisiert ein neues ApplicationDataObjectContext-Objekt.
        /// </summary>
        public ApplicationDataObjectContext(string connectionString) : base(connectionString, "ApplicationDataObjectContext")
        {
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialisiert ein neues ApplicationDataObjectContext-Objekt.
        /// </summary>
        public ApplicationDataObjectContext(EntityConnection connection) : base(connection, "ApplicationDataObjectContext")
        {
            OnContextCreated();
        }
    
        #endregion
    
        #region Partielle Methoden
    
        partial void OnContextCreated();
    
        #endregion
    
        #region ObjectSet-Eigenschaften
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        public ObjectSet<DeliveryConfirmOperation> DeliveryConfirmOperations
        {
            get
            {
                if ((_DeliveryConfirmOperations == null))
                {
                    _DeliveryConfirmOperations = base.CreateObjectSet<DeliveryConfirmOperation>("DeliveryConfirmOperations");
                }
                return _DeliveryConfirmOperations;
            }
        }
        private ObjectSet<DeliveryConfirmOperation> _DeliveryConfirmOperations;
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        public ObjectSet<OrderReceivedOperation> OrderReceivedOperations
        {
            get
            {
                if ((_OrderReceivedOperations == null))
                {
                    _OrderReceivedOperations = base.CreateObjectSet<OrderReceivedOperation>("OrderReceivedOperations");
                }
                return _OrderReceivedOperations;
            }
        }
        private ObjectSet<OrderReceivedOperation> _OrderReceivedOperations;

        #endregion

        #region AddTo-Methoden
    
        /// <summary>
        /// Veraltete Methode zum Hinzufügen eines neuen Objekts zum EntitySet 'DeliveryConfirmOperations'. Verwenden Sie stattdessen die Methode '.Add' der zugeordneten Eigenschaft 'ObjectSet&lt;T&gt;'.
        /// </summary>
        public void AddToDeliveryConfirmOperations(DeliveryConfirmOperation deliveryConfirmOperation)
        {
            base.AddObject("DeliveryConfirmOperations", deliveryConfirmOperation);
        }
    
        /// <summary>
        /// Veraltete Methode zum Hinzufügen eines neuen Objekts zum EntitySet 'OrderReceivedOperations'. Verwenden Sie stattdessen die Methode '.Add' der zugeordneten Eigenschaft 'ObjectSet&lt;T&gt;'.
        /// </summary>
        public void AddToOrderReceivedOperations(OrderReceivedOperation orderReceivedOperation)
        {
            base.AddObject("OrderReceivedOperations", orderReceivedOperation);
        }

        #endregion

    }

    #endregion

    #region Entitäten
    
    /// <summary>
    /// Keine Dokumentation für Metadaten verfügbar.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="LightSwitchApplication", Name="DeliveryConfirmOperation")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class DeliveryConfirmOperation : EntityObject
    {
        #region Factory-Methode
    
        /// <summary>
        /// Erstellt ein neues DeliveryConfirmOperation-Objekt.
        /// </summary>
        /// <param name="id">Anfangswert der Eigenschaft Id.</param>
        /// <param name="rowVersion">Anfangswert der Eigenschaft RowVersion.</param>
        /// <param name="deliveryId">Anfangswert der Eigenschaft DeliveryId.</param>
        /// <param name="executionError">Anfangswert der Eigenschaft ExecutionError.</param>
        public static DeliveryConfirmOperation CreateDeliveryConfirmOperation(global::System.Int32 id, global::System.Byte[] rowVersion, global::System.Int32 deliveryId, global::System.Boolean executionError)
        {
            DeliveryConfirmOperation deliveryConfirmOperation = new DeliveryConfirmOperation();
            deliveryConfirmOperation.Id = id;
            deliveryConfirmOperation.RowVersion = rowVersion;
            deliveryConfirmOperation.DeliveryId = deliveryId;
            deliveryConfirmOperation.ExecutionError = executionError;
            return deliveryConfirmOperation;
        }

        #endregion

        #region Primitive Eigenschaften
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 Id
        {
            get
            {
                return _Id;
            }
            set
            {
                if (_Id != value)
                {
                    OnIdChanging(value);
                    ReportPropertyChanging("Id");
                    _Id = value;
                    ReportPropertyChanged("Id");
                    OnIdChanged();
                }
            }
        }
        private global::System.Int32 _Id;
        partial void OnIdChanging(global::System.Int32 value);
        partial void OnIdChanged();
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Byte[] RowVersion
        {
            get
            {
                return StructuralObject.GetValidValue(_RowVersion);
            }
            set
            {
                OnRowVersionChanging(value);
                ReportPropertyChanging("RowVersion");
                _RowVersion = value;
                ReportPropertyChanged("RowVersion");
                OnRowVersionChanged();
            }
        }
        private global::System.Byte[] _RowVersion;
        partial void OnRowVersionChanging(global::System.Byte[] value);
        partial void OnRowVersionChanged();
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 DeliveryId
        {
            get
            {
                return _DeliveryId;
            }
            set
            {
                OnDeliveryIdChanging(value);
                ReportPropertyChanging("DeliveryId");
                _DeliveryId = value;
                ReportPropertyChanged("DeliveryId");
                OnDeliveryIdChanged();
            }
        }
        private global::System.Int32 _DeliveryId;
        partial void OnDeliveryIdChanging(global::System.Int32 value);
        partial void OnDeliveryIdChanged();
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Boolean ExecutionError
        {
            get
            {
                return _ExecutionError;
            }
            set
            {
                OnExecutionErrorChanging(value);
                ReportPropertyChanging("ExecutionError");
                _ExecutionError = value;
                ReportPropertyChanged("ExecutionError");
                OnExecutionErrorChanged();
            }
        }
        private global::System.Boolean _ExecutionError;
        partial void OnExecutionErrorChanging(global::System.Boolean value);
        partial void OnExecutionErrorChanged();
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String ErrorMessage
        {
            get
            {
                return _ErrorMessage;
            }
            set
            {
                OnErrorMessageChanging(value);
                ReportPropertyChanging("ErrorMessage");
                _ErrorMessage = value;
                ReportPropertyChanged("ErrorMessage");
                OnErrorMessageChanged();
            }
        }
        private global::System.String _ErrorMessage;
        partial void OnErrorMessageChanging(global::System.String value);
        partial void OnErrorMessageChanged();

        #endregion

    
    }
    
    /// <summary>
    /// Keine Dokumentation für Metadaten verfügbar.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="LightSwitchApplication", Name="OrderReceivedOperation")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class OrderReceivedOperation : EntityObject
    {
        #region Factory-Methode
    
        /// <summary>
        /// Erstellt ein neues OrderReceivedOperation-Objekt.
        /// </summary>
        /// <param name="id">Anfangswert der Eigenschaft Id.</param>
        /// <param name="rowVersion">Anfangswert der Eigenschaft RowVersion.</param>
        /// <param name="orderId">Anfangswert der Eigenschaft OrderId.</param>
        /// <param name="executionError">Anfangswert der Eigenschaft ExecutionError.</param>
        public static OrderReceivedOperation CreateOrderReceivedOperation(global::System.Int32 id, global::System.Byte[] rowVersion, global::System.Int32 orderId, global::System.Boolean executionError)
        {
            OrderReceivedOperation orderReceivedOperation = new OrderReceivedOperation();
            orderReceivedOperation.Id = id;
            orderReceivedOperation.RowVersion = rowVersion;
            orderReceivedOperation.OrderId = orderId;
            orderReceivedOperation.ExecutionError = executionError;
            return orderReceivedOperation;
        }

        #endregion

        #region Primitive Eigenschaften
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 Id
        {
            get
            {
                return _Id;
            }
            set
            {
                if (_Id != value)
                {
                    OnIdChanging(value);
                    ReportPropertyChanging("Id");
                    _Id = value;
                    ReportPropertyChanged("Id");
                    OnIdChanged();
                }
            }
        }
        private global::System.Int32 _Id;
        partial void OnIdChanging(global::System.Int32 value);
        partial void OnIdChanged();
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Byte[] RowVersion
        {
            get
            {
                return StructuralObject.GetValidValue(_RowVersion);
            }
            set
            {
                OnRowVersionChanging(value);
                ReportPropertyChanging("RowVersion");
                _RowVersion = value;
                ReportPropertyChanged("RowVersion");
                OnRowVersionChanged();
            }
        }
        private global::System.Byte[] _RowVersion;
        partial void OnRowVersionChanging(global::System.Byte[] value);
        partial void OnRowVersionChanged();
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 OrderId
        {
            get
            {
                return _OrderId;
            }
            set
            {
                OnOrderIdChanging(value);
                ReportPropertyChanging("OrderId");
                _OrderId = value;
                ReportPropertyChanged("OrderId");
                OnOrderIdChanged();
            }
        }
        private global::System.Int32 _OrderId;
        partial void OnOrderIdChanging(global::System.Int32 value);
        partial void OnOrderIdChanged();
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Boolean ExecutionError
        {
            get
            {
                return _ExecutionError;
            }
            set
            {
                OnExecutionErrorChanging(value);
                ReportPropertyChanging("ExecutionError");
                _ExecutionError = value;
                ReportPropertyChanged("ExecutionError");
                OnExecutionErrorChanged();
            }
        }
        private global::System.Boolean _ExecutionError;
        partial void OnExecutionErrorChanging(global::System.Boolean value);
        partial void OnExecutionErrorChanged();
    
        /// <summary>
        /// Keine Dokumentation für Metadaten verfügbar.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String ErrorMessage
        {
            get
            {
                return _ErrorMessage;
            }
            set
            {
                OnErrorMessageChanging(value);
                ReportPropertyChanging("ErrorMessage");
                _ErrorMessage = value;
                ReportPropertyChanged("ErrorMessage");
                OnErrorMessageChanged();
            }
        }
        private global::System.String _ErrorMessage;
        partial void OnErrorMessageChanging(global::System.String value);
        partial void OnErrorMessageChanged();

        #endregion

    
    }

    #endregion

    
}
