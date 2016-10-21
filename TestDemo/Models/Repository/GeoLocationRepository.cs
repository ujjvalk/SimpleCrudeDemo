using System;
using System.Linq;
using TestDemo.Models.CustomModels;

namespace TestDemo.Models.Repository
{
    public class GeoLocationRepository : IDisposable
    {
        #region GetList
        public GeoLocationModel GetList()
        {
            try
            {
                var pageDetails = new GeoLocationModel();
                using (var db = new TestDemoEntities())
                {
                    pageDetails.geoList = (from e in db.GeoLocations
                                           select new GeoLocationModel()
                                           {
                                               Id = e.Id,
                                               GeoLocationAddress = e.GeoLocationAddress,
                                               Latitude = e.Latitude,
                                               Longiude = e.Longiude
                                           }).ToList();
                }
                return pageDetails;
            }
            catch (Exception)
            {
                return new GeoLocationModel();
            }
        }
        #endregion

        #region GetById
        public GeoLocationModel GetById(long id)
        {
            using (var db = new TestDemoEntities())
            {
                var details = new GeoLocationModel();
                var data = db.GeoLocations.Where(m => m.Id == id).FirstOrDefault();
                details.Id = data.Id;
                details.GeoLocationAddress = data.GeoLocationAddress;
                details.Latitude = data.Latitude;
                details.Longiude = data.Longiude;
                return details;
            }
        }

        #endregion

        #region Add Data
        public bool AddData(GeoLocationModel model)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var pageData = new GeoLocation();
                    {
                        pageData.GeoLocationAddress = model.GeoLocationAddress;
                        pageData.Latitude = model.Latitude;
                        pageData.Longiude = model.Longiude;
                        db.GeoLocations.Add(pageData);
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
        public bool EditData(GeoLocationModel model)
        {
            try
            {
                using (var db = new TestDemoEntities())
                {
                    var data = (from sm in db.GeoLocations
                                where sm.Id == model.Id
                                select sm).FirstOrDefault();
                    if (data != null)
                    {
                        data.GeoLocationAddress = model.GeoLocationAddress;
                        data.Latitude = model.Latitude;
                        data.Longiude = model.Longiude;
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
                    var data = db.GeoLocations.Find(Id);
                    if (data != null)
                    {
                        db.GeoLocations.Remove(data);
                        db.SaveChanges();
                        return true;
                    }
                    return false;
                }
               
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