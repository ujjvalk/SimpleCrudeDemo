using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestDemo.Models.CustomModels
{
    public class TransactionModel
    {
        //Account
        public long AcountId { get; set; }
        public string Name { get; set; }
        public Nullable<decimal> TotalBalance { get; set; }

        //Transaction
        public long TransactionId { get; set; }
        public string Type { get; set; }
        public Nullable<decimal> Amount { get; set; }
        public Nullable<decimal> AvailBalance { get; set; }

        public long TransferTo { get; set; }

        public List<TransactionModel> tranList { get; set; }
    }

    public class TransferModel
    {
        public long AcountId { get; set; }

        public long ToAcountId { get; set; }

        public Nullable<decimal> Amount { get; set; }
    }
}