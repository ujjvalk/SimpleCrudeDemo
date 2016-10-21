using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TestDemo.Models.CustomModels;


namespace TestDemo.Models.Repository
{
    public class SliderRepository : IDisposable
    {
        #region GetList
        public SliderModel GetList()
        {
            try
            {
                SliderModel pageDetails = new SliderModel();
                using (var db = new TestDemoEntities())
                {
                    pageDetails.sliderList = (from e in db.tblSliders
                                              where e.IsDelete == false
                                              select new SliderModel()
                                           {
                                               SliderId = e.SliderId,
                                               SImage = e.SImage,
                                               IsActive = e.IsActive,
                                           }).ToList();

                }
                return pageDetails;
            }
            catch (Exception)
            {
                return new SliderModel();
            }
        }
        #endregion

        #region GetById
        public SliderModel GetById(long id)
        {
            using (var db = new TestDemoEntities())
            {
                SliderModel details = new SliderModel();
                var data = db.tblSliders.Where(m => m.SliderId == id).First();
                if (data != null)
                {
                    details.SliderId = data.SliderId;
                    details.SImage = data.SImage;
                    details.IsActive = data.IsActive;
                }
                return details;
            }
        }

        #endregion

        #region Add Data
        public bool AddData(SliderModel model)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var pageData = new tblSlider();
                    {
                        pageData.SImage = model.SImage;
                        pageData.IsActive = true;
                        pageData.IsDelete = false;
                        db.tblSliders.Add(pageData);
                        db.SaveChanges();
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        #endregion

        #region Edit Data
        public bool EditData(SliderModel model)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var data = (from sm in db.tblSliders
                                where sm.SliderId == model.SliderId
                                select sm).First();
                    if (data != null)
                    {
                        data.SImage = model.SImage;
                        db.SaveChanges();
                        return true;
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        #endregion

        #region Delete Record
        public bool DeleteRecord(long Id)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var data = db.tblSliders.Find(Id);
                    if (data != null)
                    {
                        data.IsDelete = true;
                        db.Entry(data).CurrentValues.SetValues(data);
                        db.SaveChanges();
                        return true;
                    }
                }
                return false;
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