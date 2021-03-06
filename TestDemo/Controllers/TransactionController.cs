﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TestDemo.Models.CustomModels;
using TestDemo.Models.Repository;

namespace TestDemo.Controllers
{
    public class TransactionController : Controller
    {
        // GET: Transaction
        public ActionResult Index()
        {
            using (var repo = new TransactionRepository())
            {
                var model = repo.GetList();
                var List = repo.UserList();
                ViewBag.User = new SelectList(List, "AcountId", "Name");
                ViewBag.TransactionType = new SelectList(new[] { new { ID = "Credit", Name = "Credit" }, new { ID = "Debit", Name = "Debit" }, new { ID = "Transfer", Name = "Transfer" }, }, "ID", "Name", 1);
                return View(model);
            }
        }

        [HttpPost]
        public ActionResult Index(TransactionModel model)
        {
            using (var repo = new TransactionRepository())
            {
                if (model != null)
                {
                    model.AcountId = Convert.ToInt64(model.Name);
                    repo.AddData(model);
                    var data = repo.GetList();
                    return PartialView("P_List", data);
                }

                var List = repo.UserList();
                ViewBag.User = new SelectList(List, "AcountId", "Name");
            }
            ViewBag.TransactionType = new SelectList(new[] { new { ID = "Credit", Name = "Credit" }, new { ID = "Debit", Name = "Debit" }, new { ID = "Transfer", Name = "Transfer" }, }, "ID", "Name", 1);
            return View();
        }

        [HttpPost]
        public ActionResult Transfer(TransferModel model)
        {
            if (model != null)
            {

            }

            return View();
        }

        public JsonResult GetToUser(long id = 0)
        {

            using (var repo = new TransactionRepository())
            {
                var List = repo.UserList().Where(e => e.AcountId != id).Select(a=>new {a.AcountId,a.Name}).ToList();

                return Json(List, JsonRequestBehavior.AllowGet);
            }

        }
        public JsonResult GetMaxAmount(long id = 0)
        {

            using (var repo = new TransactionRepository())
            {
                var data = repo.UserList().Where(e => e.AcountId == id).Select(a => new { a.TotalBalance }).FirstOrDefault();

                return Json(data, JsonRequestBehavior.AllowGet);
            }

        }
        
    }
}