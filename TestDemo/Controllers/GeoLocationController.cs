using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TestDemo.Models.CustomModels;
using TestDemo.Models.Repository;


namespace TestDemo.Controllers
{
    public class GeoLocationController : Controller
    {
        // GET: GeoLoc
        [HttpGet]
        public ActionResult Index()
        {
            using (var repo = new GeoLocationRepository())
            {
                var model = repo.GetList();
                return View(model);
            }
        }

        [HttpPost]
        public ActionResult Index(GeoLocationModel model)
        {
            using (var repo = new GeoLocationRepository())
            {
                bool flag = false;

                if (model.Id > 0)
                {
                    flag = repo.EditData(model);
                }
                else
                {
                    flag = repo.AddData(model);
                }
                ViewBag.Successmessage = flag == false ? "Please try again" : "Record saved successfully.";
                var data = repo.GetList();
                return PartialView("P_List", data);
            }
        }

        public ActionResult Edit(long id = 0)
        {
            using (var repo = new GeoLocationRepository())
            {
                if (id > 0)
                {
                    var data = repo.GetById(id);
                    return PartialView("P_Form", data);
                }
                return PartialView("P_Form");
            }
        }

        public ActionResult Delete(long id = 0)
        {
            using (var repo = new GeoLocationRepository())
            {
                bool flag = repo.DeleteRecord(id);
                if(!flag)
                {
                    return HttpNotFound();
                }
                var model = repo.GetList();
                return PartialView("P_List", model);
            }
        }
    }
}