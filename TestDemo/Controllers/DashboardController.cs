using System.Data;
using System.Linq;
using System.Web.Mvc;
using TestDemo.Models;

namespace TestDemo.Controllers
{
    public class DashboardController : Controller
    {
        // GET: Dashboard
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public JsonResult TransactionSummary()
        {
            using (var db = new TestDemoEntities())
            {
                var data = (from t in db.Transactions select new { t.Type }).ToList();
                var egrp = data.Select(trans => trans.Type)
               .GroupBy(x => x, (Transcation, transactionCount) => new { Value = Transcation, Item = transactionCount.Count() });
                return Json(egrp.ToList(), JsonRequestBehavior.AllowGet);
            }
        }

    }
}