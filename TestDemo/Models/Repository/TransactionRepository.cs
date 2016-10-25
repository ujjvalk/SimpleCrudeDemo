using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using TestDemo.Models.CustomModels;

namespace TestDemo.Models.Repository
{
    public class TransactionRepository : IDisposable
    {
        #region GetList
        public TransactionModel GetList()
        {
            try
            {
                var pageDetails = new TransactionModel();
                using (var db = new TestDemoEntities())
                {
                    pageDetails.tranList = (from b in db.BankAcounts
                                            join t in db.Transactions
                   on b.AcountId equals t.AcountId
                                            //into newtrans
                                            //from e in newtrans.DefaultIfEmpty()
                                            select new TransactionModel()
                                            {
                                                AcountId = b.AcountId,
                                                Name = b.Name,
                                                Amount = t.Amount ?? 0,
                                                TotalBalance = b.TotalBalance,
                                                Type = t.Type ?? "",
                                                TransactionId = t.TransactionId,
                                                AvailBalance = t.AvailBalance
                                            }).OrderByDescending(e=>e.TransactionId).ToList();
                }
                return pageDetails;
            }
            catch (Exception)
            {
                return new TransactionModel();
            }
        }
        #endregion

        #region GetUser

        public List<BankAcount> UserList()
        {
            using (var db = new TestDemoEntities())
            {
                return db.BankAcounts.ToList();
            }
        }

        #endregion

        #region Add Data
        public bool AddData(TransactionModel model)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    BankAcount bankAcountData = db.BankAcounts.Find(model.AcountId);
                    if (bankAcountData != null)
                    {
                        if (model.Type == "Credit")
                        {
                            bankAcountData.TotalBalance -= model.Amount;
                        }
                        if (model.Type == "Debit")
                        {
                            bankAcountData.TotalBalance += model.Amount;
                        }
                        if(model.Type == "Transfer")
                        {
                            bankAcountData.TotalBalance -= model.Amount;
                            db.Database.ExecuteSqlCommand("update  BankAcount set TotalBalance +=" + model.Amount + "where AcountId=" + model.TransferTo + ";");
                        }
                        Transaction transactionData = new Transaction();
                        transactionData.AcountId = model.AcountId;
                        transactionData.Amount = model.Amount;
                        transactionData.Type = model.Type;
                        transactionData.AvailBalance = bankAcountData.TotalBalance;
                        db.Transactions.Add(transactionData);
                        db.SaveChanges();
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                
            }
            catch (Exception)
            {
                return false;
            }
        }
        #endregion

        #region Transaction To User
        public bool userTransaction(TransferModel model)
        {
            try
            {
                if (model != null)
                {

                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        #endregion

        #region Disposible

        private bool _disposed = false;

        private void Dispose(bool disposing)
        {
            if (!this._disposed)
            {
                if (disposing)
                {
                    using (var db = new TestDemoEntities())
                    {
                        db.Dispose();
                    }
                }
            }
            this._disposed = true;
        }

        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize(this);
        }


        #endregion
    }
}