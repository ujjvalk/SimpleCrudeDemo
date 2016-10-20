using System.Linq;
using System.Web.Mvc;
using TestDemo.Models;

namespace TestDemo.Controllers
{
    public class DateRangeController : Controller
    {
        // GET: DateRange
        public ActionResult Index()
        {
            using (TestDemoEntities db = new TestDemoEntities())
            {
                ViewBag.List = db.DateRanges.ToList();
            }
            return View(new DateRange());
        }

        [HttpPost]
        public ActionResult Index(DateRange model)
        {
            using (TestDemoEntities db = new TestDemoEntities())
            {
                if (model != null && model.FromDate != null && model.Todate != null)
                {
                    if (model.Id > 0)
                    {
                        var data = db.DateRanges.Find(model.Id);
                        db.Entry(data).State = System.Data.Entity.EntityState.Modified;
                        data.FromDate = model.FromDate;
                        data.Todate = model.Todate;
                        db.SaveChanges();
                    }
                    else
                    {
                        db.DateRanges.Add(model);
                        db.SaveChanges();
                    }
                    ViewBag.Successmessage = "Record saved successfully.";
                }
                else
                {
                    ViewBag.Successmessage = "Please try again";
                }
                ViewBag.List = db.DateRanges.ToList();
            }
            return PartialView("P_List");
        }

        public ActionResult Edit(long id = 0)
        {
            using (var db = new TestDemoEntities())
            {
                if (id > 0)
                {
                    var data = db.DateRanges.Find(id);
                    return PartialView("P_Form", data);
                }
                return PartialView("P_Form");
            }
        }
        
        public ActionResult Delete(long id = 0)
        {
            using (var db = new TestDemoEntities())
            {
                var data = db.DateRanges.Find(id);
                if(data != null)
                {
                    db.DateRanges.Remove(data);
                    db.SaveChanges();
                }
                ViewBag.List = db.DateRanges.ToList();
                return PartialView("P_List");
            }
        }
    }
}